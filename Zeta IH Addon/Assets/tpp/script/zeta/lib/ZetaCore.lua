--ZetaCore.lua
--Description: Manages script tables, merging vanilla and mod content together.
local this={
	updateOutsideGame=true,
	--Reload Params
	ModType = {
		Static = 1, --Const Tables
		Dynamic = 2, --Reloadable Tables 
		Graphics = 3, --Graphics Tables
		PostInit = 4, --Reload Tables after TPP Init
	},
	ReloadType = {
		All = { 1, 2, 3 }, --Excludes PostInit
		Dynamic = { 2, 3, 4 }, --Excluses Static
		Static = { 1 }, --Only runs Static mods
		Graphics = { 3 }, --Only runs Graphic mods
	},
}
local modType = this.ModType
local reloadType = this.ReloadType

--params
--toggle: If false, all mods are disabled. If true, it reloads all mods regardless of settings.
--force: If enabled, will toggle even when saving or loading.
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
			{ ZetaGrInit, modType.Graphics },
			{ ZetaCommonPackList, modType.Dynamic },
			{ ZetaMissionList, modType.Dynamic },
			{ ZetaEquipIdTable, modType.PostInit }, --Run after init
			{ ZetaEquipParameters, modType.Dynamic },
			{ ZetaEquipMotionDataForChimera, modType.Dynamic },
			{ ZetaChimeraPartsPackageTable, modType.Dynamic },
			{ ZetaEquipParameterTables, modType.Dynamic },
			{ ZetaDamageParameterTables, modType.Dynamic },
			{ ZetaEquipMotionData, modType.Dynamic },
			{ ZetaSoldier2FaceAndBodyData, modType.Static },
			{ ZetaRecoilMaterialTable, modType.Dynamic },
			{ ZetaPlayerParameters, modType.Dynamic },
			{ ZetaCommonMotionPackage, modType.Dynamic },
			{ ZetaMbmCommonSetting, modType.Static },
			{ ZetaEquipDevelopConstSetting, modType.Static },
			{ ZetaEquipDevelopFlowSetting, modType.Dynamic },
			{ ZetaWeaponPartsUiSetting, modType.Static },
			{ ZetaWeaponPartsCombinationSettings, modType.Static },
			{ ZetaPlayerParts, modType.Dynamic },
			{ ZetaBuddyParts, modType.Dynamic },
			{ ZetaVehicleParts, modType.Dynamic },
			{ ZetaMessages, modType.Dynamic }, --Load messages last!
		}
		--Iterate through mods	
		if not ( params.reloadFiles == false ) then --Reloading mod lua files
			local allModsEnabled = params.toggle --if nil, mods will load regardless
			if ( ZetaVar.IsZetaActive() == false ) then allModsEnabled = false end --If Zeta isn't active, don't reload mods.
			ZetaIndex.LoadAllModFiles(allModsEnabled)
		end	
		local curReloadType = params.reloadType --Reload tables based on type 
		if curReloadType == nil then curReloadType = reloadType.Dynamic end --If no type is set, dynamic tables are reloaded	
		for x,luaTable in ipairs(ScriptTables)do   
			if luaTable ~= nil and next(luaTable) then
				for y,curReload in ipairs(curReloadType)do   
					if luaTable[2] == curReload then
						local loadedTable = this.TableReload(luaTable[1],params) --Loads table, and possibly compares old tables to them.
						if loadedTable == false then InfCore.Log( "["..ZetaDef.modName.."][Error] Failed to reload table",false,true) end --Table failed to reload.
					end
				end
			end
		end
		if params.showMsg == true then TppUiCommand.AnnounceLogView( "["..ZetaDef.modName.."] Reloaded all mods") end --Announce log message	
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
	if ZetaUtil ~= nil then ZetaUtil.Update() end
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
	if TppMission.IsHelicopterSpace(vars.missionCode)then 
		this.ReloadMods({force=true}) 
		TppUiCommand.AnnounceLogDelayTime(0)
		TppUiCommand.AnnounceLogView(ZetaDef.modName.." r"..ZetaDef.modVersion.." "..ZetaDef.modIntroText) --Announce Zeta at start up
	end
	ZetaIndex.SafeFuncInGame("OnMissionCanStart",this) 
end
function this.PostAllModulesLoad(isReload)
	if this.isLoaded == true then this.ReloadMods({force=true}) else 
		this.ReloadMods({reloadType=reloadType.All,force=true,reloadFiles=false}) 
		this.isLoaded = true --To prevent reloading any constant tables.
	end
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
	local newMissionPacks = ZetaIndex.ModTables("AddMissionPacks", missionCode)
	if newMissionPacks ~= nil and next(newMissionPacks) then
		for t,pack in ipairs(newMissionPacks)do
			packPaths[#packPaths+1]=pack
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