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
this.ScriptTables = {
	{ name="ZetaNativeOverride", type=modType.Static },
	{ name="ZetaGr_init_dx11", type=modType.Graphics },
	{ name="ZetaCommonPackList", type=modType.Dynamic },
	{ name="ZetaMissionList", type=modType.Dynamic },
	{ name="ZetaEquipIdTable", type=modType.PostInit }, --Run after init
	{ name="ZetaEquipParameters", type=modType.Dynamic },
	{ name="ZetaEquipMotionDataForChimera", type=modType.Dynamic },
	{ name="ZetaChimeraPartsPackageTable", type=modType.Dynamic },
	{ name="ZetaEquipParameterTables", type=modType.Dynamic },
	{ name="ZetaDamageParameterTables", type=modType.Dynamic },
	{ name="ZetaEquipMotionData", type=modType.Dynamic },
	{ name="ZetaRecoilMaterialTable", type=modType.Dynamic },
	{ name="ZetaPlayerCallbackScript", type=modType.Dynamic },
	{ name="ZetaPlayerCamoParameters", type=modType.Dynamic },
	{ name="ZetaCommonMotionPackage", type=modType.Dynamic },
	{ name="ZetaMbmCommonSetting", type=modType.Static },
	{ name="ZetaMbmCommonSetting20BaseResSec", type=modType.Static },
	{ name="ZetaMbmCommonSetting30Deploy", type=modType.Static },
	{ name="ZetaMbmCommonSetting40RewardDeploy", type=modType.Static },
	{ name="ZetaMbmCommonSetting50RewardFob", type=modType.Static },
	{ name="ZetaMbmCommonSetting60DbPfLang", type=modType.Static },
	{ name="ZetaEquipDevelopConstSetting", type=modType.Static },
	{ name="ZetaEquipDevelopFlowSetting", type=modType.Dynamic },
	{ name="ZetaWeaponPartsUiSetting", type=modType.Static },
	{ name="ZetaWeaponPartsCombinationSettings", type=modType.Static },
	{ name="ZetaPlayerParts", type=modType.Dynamic },
	{ name="ZetaBuddyParts", type=modType.Dynamic },
	{ name="ZetaVehicleParts", type=modType.Dynamic },
	--Load last!
	{ name="ZetaIH", type=modType.Dynamic },
	{ name="ZetaMessages", type=modType.Static },
	{ name="ZetaHook", type=modType.Static },
}

--params
--force: If enabled, will toggle even when saving or loading.
--showMsg:  If enabled, shows announcelog msg
--noRefresh:  If enabled, won't get updates online
--reloadType: Decides which mods to reload. See enum above
function this.ReloadMods(params) --Iterate through mods	
	if params == nil then params = {} end
	if TppScriptVars.IsSavingOrLoading() == true or params.force == false then return nil end --If saving and loading, reload mods when "force" is true
	local curReloadType = params.reloadType --Reload tables based on type 
	if curReloadType == nil then curReloadType = reloadType.Dynamic end --If no type is set, dynamic tables are reloaded
	if curReloadType == reloadType.All then ZetaVar.ImportZetaSvars() end --Import ZSvars
	ZetaIndex.RebuildIndex(params) --Reload all Zeta module lua files ( or clear them depending on toggle param )
	for x,ScriptTable in ipairs(this.ScriptTables)do   
		if ScriptTable ~= nil and next(ScriptTable) then
			for y,curReload in ipairs(curReloadType)do   
				if ScriptTable.type == curReload then
					local luaTable = _G[ScriptTable.name]
					if luaTable ~= nil then
						local loadedTable = this.TableReload(luaTable,params) --Loads table, and possibly compares old tables to them.
						if loadedTable == false then ZetaCore.Log("Failed to reload table",{ScriptTable.name,"Error"},false) end --Table failed to reload.
					end
				end
			end
		end
	end
	if curReloadType == reloadType.All then ZetaVar.ExportZetaSvars() end --Export ZSvars
	if params.showMsg == true then TppUiCommand.AnnounceLogView( "["..ZetaDef.modName.."] Reloaded all mods") end --Announce log message	
end
function this.TableReload(module,params)
	if module ~= nil then 
		local success,result = pcall(module.Reload,params)
		if result ~= nil then return result
		else return success end
	end
	return false
end

--PCallDebug/CallOnModule functions
function this.Update(currentChecks,currentTime,execChecks,execState) 
	if ZetaMessages ~= nil then ZetaMessages.Update() end
	if ZetaMission ~= nil then ZetaMission.Update() end
	if ZetaPlayerParts ~= nil then ZetaPlayerParts.Update(currentChecks,currentTime) end 
	if ZetaBuddyParts ~= nil then ZetaBuddyParts.Update() end 	
	ZetaIndex.SafeFuncInGame("Update",currentChecks,currentTime,execChecks,execState) 
end
function this.OnAllocate(missionTable)
	if ZetaMission ~= nil then ZetaMission.OnAllocate(missionTable) end
	if ZetaDemoBlockList ~= nil then ZetaDemoBlockList.OnAllocate(missionTable) end
	ZetaIndex.SafeFuncInGame("OnAllocate",missionTable) 
end
function this.OnMissionCanStart() 
	if TppMission.IsHelicopterSpace(vars.missionCode)then 
		TppUiCommand.AnnounceLogDelayTime(0)
		TppUiCommand.AnnounceLogView(ZetaDef.modName.." r"..ZetaDef.modVersion.." "..ZetaDef.modIntroText) --Announce Zeta at start up
		this.ReloadMods({force=true,reloadFiles=false}) 
		ZetaVar.EndSanityChecks()
	end 
	ZetaIndex.SafeFuncInGame("OnMissionCanStart",this) 
end
function this.PostAllModulesLoad(isReload)
	if this.isLoaded == true then this.ReloadMods{force=true} else 
		this.ReloadMods{reloadType=reloadType.All,force=true,reloadFiles=false} 
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
function this.Log(logMsg,errorTypes, announceOnScreen) 
	local newErrorType = ""
	local newAnnounce = true
	if errorTypes ~= nil then
		if type(errorTypes) == "table" then
			if next(errorTypes) then
				for i,errorType in ipairs(errorTypes)do newErrorType = newErrorType.."["..errorType.."]" end	
			end
		else newErrorType = "["..errorTypes.."]" end
	end
	if announceOnScreen ~= nil then newAnnounce = announceOnScreen end
	InfCore.Log("["..ZetaDef.modName.."]"..newErrorType.." "..logMsg,newAnnounce,true) 
end

return this