--ZetaCore.lua
--Description: Manages script tables, merging vanilla and mod content together.
local this={
	--Module Info
	modName="Zeta",
	modVersion=6,
	updateOutsideGame=true,
	--Reload Params
	modType = {
		Static = 1,
		Dynamic = 2,
		Graphics = 3,
	},
	reloadType = {
		All = { 1, 2, 3 },
		Dynamic = { 2, 3 },
		Static = { 1 },
		Graphics = {3},
	},
}

--params
--toggle: Enables or disables all mods
--force: If enabled, will toggle even when saving or loading
--showMsg:  If enabled, shows announcelog msg
--noRefresh:  If enabled, won't get updates online
--reloadFiles: If disabled, mod files won't be reloaded.
--reloadType: Decides which mods to reload. See enum above
function this.ReloadMods(setParams) 
	local params = setParams --Reload parameters
	if params == nil then params = {} end
	if TppScriptVars.IsSavingOrLoading() == false or params.force == true then
		--Reloadable tables
		local ScriptTables = {
			{ ZetaGrInit, this.modType.Graphics },
			{ ZetaCommonPackList, this.modType.Dynamic },
			{ ZetaMissionList, this.modType.Dynamic },
			{ ZetaEquipIdTable, this.modType.Dynamic },
			{ ZetaEquipParameters, this.modType.Dynamic },
			{ ZetaEquipMotionDataForChimera, this.modType.Dynamic },
			{ ZetaChimeraPartsPackageTable, this.modType.Dynamic },
			{ ZetaEquipParameterTables, this.modType.Dynamic },
			{ ZetaDamageParameterTables, this.modType.Dynamic },
			{ ZetaEquipMotionData, this.modType.Dynamic },
			--{ ZetaSoldier2FaceAndBodyData, this.modType.Static },
			{ ZetaRecoilMaterialTable, this.modType.Dynamic },
			{ ZetaPlayerParameters, this.modType.Dynamic },
			{ ZetaCommonMotionPackage, this.modType.Dynamic },
			{ ZetaMbmCommonSetting, this.modType.Static },
			{ ZetaEquipDevelopConstSetting, this.modType.Static },
			{ ZetaEquipDevelopFlowSetting, this.modType.Dynamic },
			{ ZetaWeaponPartsUiSetting, this.modType.Static },
			{ ZetaWeaponPartsCombinationSettings, this.modType.Static },
			{ ZetaPlayerParts, this.modType.Dynamic },
			{ ZetaBuddyParts, this.modType.Dynamic },
			{ ZetaVehicleParts, this.modType.Dynamic },
			{ ZetaMessages, this.modType.Dynamic }, --Load messages last!
		}
		--Iterate through mods
		local curReloadType = params.reloadType --Reload tables based on type 
		if curReloadType == nil then curReloadType = this.reloadType.Dynamic end --If no type is set, dynamic tables are reloaded		
		if not ( params.reloadFiles == false ) then --Reloading mod lua files
			local allModsEnabled = params.toggle --if nil, mods will load regardless
			if ( ZetaVar.IsZetaActive() == false ) then allModsEnabled = false end --If Zeta isn't active, don't reload mods.
			ZetaIndex.LoadAllModFiles(allModsEnabled)
		end	
		for x,luaTable in ipairs(ScriptTables)do   
			if luaTable ~= nil and next(luaTable) then
				for y,curReload in ipairs(curReloadType)do   
					if luaTable[2] == curReload then
						local loadedTable = this.TableReload(luaTable[1],params) --Loads table, and possibly compares old tables to them.
						if loadedTable == false then InfCore.Log( "["..this.modName.."][Error] Failed to reload table",false,true) end --Table failed to reload.
					end
				end
			end
		end
		if params.showMsg == true then TppUiCommand.AnnounceLogView( "["..this.modName.."] Reloaded all mods") end --Announce log message	
	end
end
function this.TableReload(module,params)
	if module ~= nil then 
		local success,result = pcall(module.Reload,params)
		if result ~= nil then return result
		else return success end
	end
	return false
end

--PCallDebug functions
function this.Update(currentChecks,currentTime,execChecks,execState) 
	if ZetaMission ~= nil then ZetaMission.Update() end
	if ZetaPlayerParts ~= nil then ZetaPlayerParts.Update() end 
	if ZetaBuddyParts ~= nil then ZetaBuddyParts.Update() end 	
	ZetaIndex.SafeFuncInGame("Update",currentChecks,currentTime,execChecks,execState) 
end

--CallOnModule functions
function this.OnAllocate(missionTable)
	if ZetaMission ~= nil then ZetaMission.OnAllocate(missionTable) end
	if ZetaDemoBlockList ~= nil then ZetaDemoBlockList.OnAllocate(missionTable) end
	ZetaIndex.SafeFuncInGame("OnAllocate",missionTable) 
end
function this.OnMissionCanStart() 
	if TppMission.IsHelicopterSpace(vars.missionCode)then this.ReloadMods({force=true}) end
	ZetaIndex.SafeFuncInGame("OnMissionCanStart",this) 
end
function this.PostAllModulesLoad(isReload)
	if isReload == true then this.ReloadMods({force=true})  --On reloads, reload only dynamic mods
	else this.ReloadMods({reloadType=this.reloadType.All,force=true,reloadFiles=false}) end --On init, reload all, including const
	--TppUiCommand.AnnounceLogDelayTime(0)
	--TppUiCommand.AnnounceLogView(this.modName.." r"..this.modVersion) --Announce Zeta at start up
	ZetaIndex.SafeFuncInGame("PostAllModulesLoad",isReload) 
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
	ZetaMessages.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
	ZetaIndex.SafeFuncInGame("OnMessage",sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
end
function this.DeclareSVars() 
	if ZetaVar ~= nil then return ZetaVar.ReloadSvars() end
	return nil
end
function this.AddMissionPacks(missionCode,packPaths)
	local newMissionPacks = ZetaIndex.ModGet("AddMissionPacks", missionCode)
	if newMissionPacks ~= nil and next(newMissionPacks) then
		for i,missionPacks in ipairs(newMissionPacks)do
			if missionPacks ~= nil and next(missionPacks) then
				for t,pack in ipairs(missionPacks)do
					packPaths[#packPaths+1]=pack
				end	
			end
		end		
	end
end
function this.OnRestoreSvars() ZetaIndex.SafeFuncInGame("OnRestoreSvars",this) end
function this.OnAllocateTop(missionTable) ZetaIndex.SafeFuncInGame("OnAllocateTop",missionTable) end
function this.OnInitialize(missionTable) ZetaIndex.SafeFuncInGame("OnInitialize",missionTable) end
function this.OnReload(missionTable) ZetaIndex.SafeFuncInGame("OnReload",missionTable ) end
function this.OnLoad(nextMissionCode,currentMissionCode) ZetaIndex.SafeFuncInGame("OnLoad",nextMissionCode,currentMissionCode) end
function this.OnGameStart() ZetaIndex.SafeFuncInGame("OnGameStart",this) end
function this.OnStartTitle() ZetaIndex.SafeFuncInGame("OnStartTitle",this) end
function this.SetUpEnemy(missionTable) ZetaIndex.SafeFuncInGame("SetUpEnemy",missionTable ) end
function this.PreMissionLoad(missionId,currentMissionId) ZetaIndex.SafeFuncInGame("PreMissionLoad",missionId,currentMissionId) end
function this.MissionPrepare() ZetaIndex.SafeFuncInGame("MissionPrepare",this)end
function this.Init(missionTable) ZetaIndex.SafeFuncInGame("Init",missionTable ) end

return this