--ZetaCore.lua
local this={}
this.updateOutsideGame=true 

--params
--toggle: Enables or disables all mods
--force: Will toggle even when saving or loading
--reloadFiles: will reload files entirely
--noRefresh: won't get updates online
--showMsg: shows announcelog msg
--reloadType: See enum below
this.modType = {
	Static = 1,
	Dynamic = 2,
	DevFlow = 3,
	GR = 4,
}
this.reloadType = {
	All = { 1, 2, 3, 4 },
	DynamicOnly = {2, 3, 4},
	StaticOnly = {1, 4},
	GROnly = {4},
}
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
			--{ ZetaEquipDevelopConstSetting, this.modType.Static },
			{ ZetaEquipDevelopFlowSetting, this.modType.DevFlow },
			--{ ZetaWeaponPartsCombinationSettings, this.modType.Static },
			{ ZetaPlayerParts, this.modType.Dynamic },
			{ ZetaBuddyParts, this.modType.Dynamic },
		}
		
		--Reload Tables ( if no type is found, only dynamic tables are reloaded )
		local curReloadType = params.reloadType
		if curReloadType == nil then curReloadType = this.reloadType.DynamicOnly end		
	
		--Enable or disable mods
		local toggle = params.toggle
		if toggle == nil then toggle = true end --No toggle param? Reload with mods on.
		if ( ZetaVar.AreAllModsEnabled() == false ) then toggle = false end
		
		--Reloading mods
		if toggle == true then
			if not ( params.reloadFiles == false ) then ZetaIndex.LoadAllModFiles() end
			
			--Init mods
			if curReloadType ~= this.reloadType.GROnly then	
				ZetaIndex.SafeFunc("ModStart", this ) 
			end
		end
	
		--Announce log message
		local msg = ZetaIndex.debugModName..": Reloading all mods"	
	
		--Iterate through mods
		for x,luaTable in ipairs(ScriptTables)do   
			if luaTable ~= nil and next(luaTable) then
				local tableScript = luaTable[1]
				local tableType = luaTable[2]
				for y,curReload in ipairs(curReloadType)do   
					if tableType == curReload then 
						--Reload tables
						if tableType == this.modType.DevFlow then
							--Returns if it has modifications, and if online weapons need a patch
							local refresh = this.CompareReload(tableScript,toggle)
							if refresh[1] == true then
								--TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)								
								--Acquires updates from konami server
								if not (params.noRefresh == true) then
									if refresh[2] == true then
										if ZetaVar.IsProtectingDevFlow() == true then
											TppServerManager.StartLogin()
											msg = msg.." and acquiring updates"
										end
									end
								end
							end
						elseif this.TableReload(tableScript,toggle) == false then
							InfCore.Log(ZetaIndex.debugModName..": Failed to reload table",false,true)
						end
					end
				end
			end
		end
		
		if params.showMsg == true then
			TppUiCommand.AnnounceLogView(msg)--DEBUG
		end
	end
end

function this.TableReload(module,toggle)
	if module ~= nil then
		module.Reload(toggle)
		return true
	end
	return false
end

function this.CompareReload(module,toggle)
	if module ~= nil then
		return module.Reload(toggle)
	end
	return {false,false}
end

function this.SetModsEnabled(i)
	this.ReloadMods({toggle=( i >= 1 ),force=true})
end

--Passthroughs
function this.Update(currentChecks,currentTime,execChecks,execState) 
	--Load mods and gather updates
	this.InitOnLogin()
	
	if ZetaMission ~= nil then
		ZetaMission.Update()
	end
	
	if ZetaPlayerParts ~= nil then
		ZetaPlayerParts.Update()
	end 
	
	if ZetaBuddyParts ~= nil then
		ZetaBuddyParts.Update()
	end 
	
	ZetaIndex.SafeFuncInGame("Update",currentChecks,currentTime,execChecks,execState) 
end

function this.Init(missionTable)
	--Init graphics ASAP
	this.ReloadMods({toggle=true,force=true,reloadType=this.reloadType.StaticOnly}) --All on boot
	ZetaIndex.SafeFuncInGame("Init",missionTable ) 
	--ZetaMessages.Init(missionTable) 	
end

function this.InitOnLogin()
	if this.startUpInit ~= true then
		if TppSequence.GetCurrentSequenceName() == "Seq_Demo_LogInKonamiServer" then
			this.ReloadMods({toggle=true,force=true,reloadMods=false,noRefresh=true})
			this.startUpInit = true 
		end	
	end
end

function this.ReloadGr()
	this.ReloadMods({toggle=true,force=true,reloadMods=false,reloadType=this.reloadType.GROnly})
end

function this.PostAllModulesLoad(isReload)
	if isReload then
		this.ReloadMods({toggle=true,force=true}) --Dynamic on module reload
	end	
end

function this.OnAllocate(missionTable)
	if ZetaMission ~= nil then
		ZetaMission.OnAllocate(missionTable)
	end
	if ZetaDemoBlockList ~= nil then
		ZetaDemoBlockList.OnAllocate(missionTable)
	end
	ZetaIndex.SafeFuncInGame("OnAllocate",missionTable) 
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
	ZetaMessages.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
	ZetaIndex.SafeFuncInGame("OnMessage",sender,messageId,arg0,arg1,arg2,arg3,strLogText) 
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

function this.DeclareSVars() 
	if ZetaVar ~= nil then return ZetaVar.ReloadSvars() end
	return nil
end
function this.OnRestoreSvars() ZetaIndex.SafeFuncInGame("OnRestoreSvars",this) end

function this.OnAllocateTop(missionTable) ZetaIndex.SafeFuncInGame("OnAllocateTop",missionTable) end
function this.OnInitialize(missionTable) ZetaIndex.SafeFuncInGame("OnInitialize",missionTable) end
function this.OnReload(missionTable) ZetaIndex.SafeFuncInGame("OnReload",missionTable ) end
function this.OnLoad(nextMissionCode,currentMissionCode) ZetaIndex.SafeFuncInGame("OnLoad",nextMissionCode,currentMissionCode) end

function this.OnGameStart() ZetaIndex.SafeFuncInGame("OnGameStart",this) end
function this.OnStartTitle() ZetaIndex.SafeFuncInGame("OnStartTitle",this) end
function this.SetUpEnemy(missionTable) ZetaIndex.SafeFuncInGame("SetUpEnemy",missionTable ) end

function this.MissionPrepare() ZetaIndex.SafeFuncInGame("MissionPrepare",this)end
--function this.AddMissionPacks(missionCode,packPaths) ZetaIndex.SafeFuncInGame("AddMissionPacks",missionCode,packPaths) end
function this.PreMissionLoad(missionId,currentMissionId) ZetaIndex.SafeFuncInGame("PreMissionLoad",missionId,currentMissionId) end
function this.OnMissionCanStart() ZetaIndex.SafeFuncInGame("OnMissionCanStart",this) end

return this