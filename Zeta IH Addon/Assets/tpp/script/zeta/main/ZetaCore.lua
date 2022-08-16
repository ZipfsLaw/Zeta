--ZetaCore.lua
--Description: Manages script tables, merging vanilla and mod content together.
local this={
	updateOutsideGame=true,
	modType = {
		Dynamic = 1,
		DevFlow = 2,
		GR = 3,
	},
	reloadType = {
		All = { 1, 2, 3},
		GROnly = {3},
	},
}
--params
--toggle: Enables or disables all mods
--force: If enabled, will toggle even when saving or loading
--reloadFiles: If disabled, mod files won't be reloaded.
--noRefresh:  If enabled, won't get updates online
--showMsg:  If enabled, shows announcelog msg
--reloadType: Decides which mods to reload. See enum above
function this.ReloadMods(setParams)
	local params = {} --Reload parameters
	if setParams ~= nil then params = setParams end
	
	if TppScriptVars.IsSavingOrLoading() == false or params.force == true then
		local ScriptTables = {
			{ ZetaGrInit, this.modType.GR },
			{ ZetaMessages, this.modType.Dynamic },
			{ ZetaCommonPackList, this.modType.Dynamic },
			{ ZetaMissionList, this.modType.Dynamic },
			{ ZetaEquipIdTable, this.modType.Dynamic },
			{ ZetaEquipParameters, this.modType.Dynamic },
			{ ZetaEquipMotionDataForChimera, this.modType.Dynamic },
			{ ZetaChimeraPartsPackageTable, this.modType.Dynamic },
			{ ZetaEquipParameterTables, this.modType.Dynamic },
			{ ZetaDamageParameterTables, this.modType.Dynamic },
			{ ZetaEquipMotionData, this.modType.Dynamic },
			{ ZetaRecoilMaterialTable, this.modType.Dynamic },
			{ ZetaPlayerParameters, this.modType.Dynamic },
			{ ZetaCommonMotionPackage, this.modType.Dynamic },
			{ ZetaEquipDevelopFlowSetting, this.modType.DevFlow },
			{ ZetaPlayerParts, this.modType.Dynamic },
			{ ZetaBuddyParts, this.modType.Dynamic },
			{ ZetaVehicleParts, this.modType.Dynamic },
		}
		
		if not ( params.reloadFiles == false ) then --Reloading mod lua files
			local allModsEnabled = params.toggle --if nil, mods will load regardless
			if ( ZetaVar.IsZetaActive() == false ) then allModsEnabled = false end --If Zeta isn't active, don't reload mods.
			ZetaIndex.LoadAllModFiles(allModsEnabled) 
		end
	
		local curReloadType = params.reloadType --Reload tables based on type ( if none, all are reloaded )
		if curReloadType == nil then curReloadType = this.reloadType.All end		

		--Announce log message
		local msg = ZetaIndex.debugModName..": Reloading all mods"	
	
		--Iterate through mods
		for x,luaTable in ipairs(ScriptTables)do   
			if luaTable ~= nil and next(luaTable) then
				local tableScript = luaTable[1]
				local tableType = luaTable[2]
				for y,curReload in ipairs(curReloadType)do   
					if tableType == curReload then
						if tableType == this.modType.DevFlow then --Returns if it has modifications, and if online weapons need a patch				
							local refresh = this.CompareReload(tableScript)
							if refresh == nil then
								InfCore.Log(ZetaIndex.debugModName..": Failed to compare and reload table",false,true)
							elseif refresh[1] == true then
								if not (params.noRefresh == true) then --Acquires updates from Konami server
									if refresh[2] == true then
										if ZetaVar.IsProtectingDevFlow() == true then
											TppServerManager.StartLogin()
											msg = msg.." and acquiring updates from Konami TPP server"
										end
									end
								end
							end
						elseif this.TableReload(tableScript) == false then --Reload tables
							InfCore.Log(ZetaIndex.debugModName..": Failed to reload table",false,true)
						end
					end
				end
			end
		end
		if params.showMsg == true then TppUiCommand.AnnounceLogView(msg) end
	end
end

function this.TableReload(module)
	if module ~= nil then
		module.Reload()
		return true
	end
	return false
end
function this.CompareReload(module)
	if module ~= nil then return module.Reload() end
	return nil
end

--Passthroughs
function this.Update(currentChecks,currentTime,execChecks,execState) 
	if ZetaMission ~= nil then ZetaMission.Update() end
	if ZetaPlayerParts ~= nil then ZetaPlayerParts.Update() end 
	if ZetaBuddyParts ~= nil then ZetaBuddyParts.Update() end 	
	ZetaIndex.SafeFuncInGame("Update",currentChecks,currentTime,execChecks,execState) 
end

function this.OnAllocate(missionTable)
	if ZetaMission ~= nil then ZetaMission.OnAllocate(missionTable) end
	if ZetaDemoBlockList ~= nil then ZetaDemoBlockList.OnAllocate(missionTable) end

	ZetaIndex.SafeFuncInGame("OnAllocate",missionTable) 
end

function this.AddMissionPacks(missionCode,packPaths) 
	--ZetaIndex.SafeFuncInGame("AddMissionPacks",missionCode,packPaths)
	local newMissionPacks = ZetaIndex.SafeGet("AddMissionPacks", missionCode) 
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

function this.OnAllocateTop(missionTable) ZetaIndex.SafeFuncInGame("OnAllocateTop",missionTable) end
function this.OnInitialize(missionTable) ZetaIndex.SafeFuncInGame("OnInitialize",missionTable) end
function this.OnReload(missionTable) ZetaIndex.SafeFuncInGame("OnReload",missionTable ) end
function this.OnLoad(nextMissionCode,currentMissionCode) ZetaIndex.SafeFuncInGame("OnLoad",nextMissionCode,currentMissionCode) end

function this.OnGameStart() ZetaIndex.SafeFuncInGame("OnGameStart",this) end
function this.OnStartTitle() ZetaIndex.SafeFuncInGame("OnStartTitle",this) end
function this.SetUpEnemy(missionTable) ZetaIndex.SafeFuncInGame("SetUpEnemy",missionTable ) end

function this.MissionPrepare() ZetaIndex.SafeFuncInGame("MissionPrepare",this)end
function this.PreMissionLoad(missionId,currentMissionId) ZetaIndex.SafeFuncInGame("PreMissionLoad",missionId,currentMissionId) end
function this.OnMissionCanStart() 
	if TppMission.IsHelicopterSpace(vars.missionCode)then this.LoadLibraries() end
	ZetaIndex.SafeFuncInGame("OnMissionCanStart",this) 
end

function this.DeclareSVars() 
	if ZetaVar ~= nil then return ZetaVar.ReloadSvars() end
	return nil
end
function this.OnRestoreSvars() ZetaIndex.SafeFuncInGame("OnRestoreSvars",this) end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
	ZetaMessages.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
	ZetaIndex.SafeFuncInGame("OnMessage",sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
end

function this.Init(missionTable)
	ZetaIndex.SafeFuncInGame("Init",missionTable ) 
	--ZetaMessages.Init(missionTable) 	
end

function this.PostAllModulesLoad(isReload)
	if isReload then
		this.LoadLibraries()
	end	
end

function this.LoadLibraries()
	this.ReloadMods({force=true}) 
end

return this