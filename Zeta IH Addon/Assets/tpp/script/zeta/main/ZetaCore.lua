--ZetaCore.lua
--Description: Manages script tables, merging vanilla and mod content together.
local this={
	--Module Info
	modName="Zeta",
	modVersion=1,
	updateOutsideGame=true,
	--Reload Params
	queueReload = {
		params = nil,
		time = 0,
	},
	modType = {
		Dynamic = 1,
		DevFlow = 2,
		Graphics = 3,
		Boot = 4,
	},
	reloadType = {
		Boot = { 1, 2, 3, 4 },
		All = { 1, 2, 3 },
		Graphics = {3},
	},
}

--params
--toggle: Enables or disables all mods
--force: If enabled, will toggle even when saving or loading
--showMsg:  If enabled, shows announcelog msg
--nextTime: If set, will change the cooldown timer for mod reloads.
--noRefresh:  If enabled, won't get updates online
--reloadFiles: If disabled, mod files won't be reloaded.
--reloadNow: Reloads mods without timer
--reloadType: Decides which mods to reload. See enum above
function this.ReloadMods(setParams) 
	local params = setParams --Reload parameters
	if params == nil then params = {} end
	if params.nextTime == nil then params.nextTime = 1 end
	if params.reloadNow == true then this.RebuildTables(params) 
	elseif this.queueReload.params == nil then this.queueReload.params = params end
end
function this.RebuildTables(params) --Rebuilds tables
	if TppScriptVars.IsSavingOrLoading() == false or params.force == true then
		--Reloadable tables
		local ScriptTables = {
			{ ZetaSoldier2FaceAndBodyData, this.modType.Boot },
			{ ZetaGrInit, this.modType.Graphics },
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
		--Iterate through mods
		if not ( params.reloadFiles == false ) then --Reloading mod lua files
			local allModsEnabled = params.toggle --if nil, mods will load regardless
			if ( ZetaVar.IsZetaActive() == false ) then allModsEnabled = false end --If Zeta isn't active, don't reload mods.
			ZetaIndex.LoadAllModFiles(allModsEnabled) 
		end
		local curReloadType = params.reloadType --Reload tables based on type 
		if curReloadType == nil then curReloadType = this.reloadType.All end --If no type is set, all tables are reloaded		
		local msg = this.modName..": Reloading all mods"--Announce log message	
		for x,luaTable in ipairs(ScriptTables)do   
			if luaTable ~= nil and next(luaTable) then
				local tableScript = luaTable[1]
				local tableType = luaTable[2]
				for y,curReload in ipairs(curReloadType)do   
					if tableType == curReload then
						local loadedTable = this.TableReload(tableScript) --Loads table, and possibly compares old tables to them.
						if loadedTable == false then InfCore.Log(this.modName..": Failed to reload table",false,true) --Table failed to reload.
						elseif tableType == this.modType.DevFlow then --Returns if it has modifications, and if online weapons need a patch				
							if loadedTable.DevFlowUpdated == true then --Did dev flow update?
								if not (params.noRefresh == true) then --Get updates from Konami server when we reload?
									if loadedTable.NeedsOnlinePatch == true then --Do we need an online patch?
										if ZetaVar.IsProtectingDevFlow() == true then --Does the player want the patch?
											TppServerManager.StartLogin() --Player logs in, downloads patch.
											msg = msg.." and acquiring updates from Konami TPP server" --Message updates
										end
									end
								end
							end
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
		local success,result = pcall(module.Reload)
		if success == false then InfCore.Log(ZetaCore.modName..": "..funcName,true,true) end
		if result ~= nil then return result
		else return success end
	end
	return false
end
function this.ReloadThink(currentTime)
	if this.queueReload.params ~= nil then 
		if ( this.queueReload.time < currentTime ) or this.queueReload.params.reloadNow == true then --Cooldown on reload		
			this.RebuildTables(this.queueReload.params, currentTime) 
			this.queueReload = {
				time = currentTime + this.queueReload.params.nextTime,
				params = nil,
			}
		end
	end
end
function this.LoadLibraries() this.ReloadMods({reloadType=this.reloadType.Boot,reloadNow=true,force=true}) end
function this.PostAllModulesLoad(isReload)
	if isReload then this.ReloadMods({force=true}) end
	--TppUiCommand.AnnounceLogDelayTime(0)
	--TppUiCommand.AnnounceLogView(this.modName.." r"..this.modVersion) --Announce Zeta at start up
end
function this.OnMissionCanStart() 
	if TppMission.IsHelicopterSpace(vars.missionCode)then this.ReloadMods({force=true}) end
	ZetaIndex.SafeFuncInGame("OnMissionCanStart",this) 
end

--Passthroughs
function this.Update(currentChecks,currentTime,execChecks,execState) 
	this.ReloadThink(currentTime) --For delayed mod reloads
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

function this.OnAllocateTop(missionTable) ZetaIndex.SafeFuncInGame("OnAllocateTop",missionTable) end
function this.OnInitialize(missionTable) ZetaIndex.SafeFuncInGame("OnInitialize",missionTable) end
function this.OnReload(missionTable) ZetaIndex.SafeFuncInGame("OnReload",missionTable ) end
function this.OnLoad(nextMissionCode,currentMissionCode) ZetaIndex.SafeFuncInGame("OnLoad",nextMissionCode,currentMissionCode) end
function this.OnGameStart() ZetaIndex.SafeFuncInGame("OnGameStart",this) end
function this.OnStartTitle() ZetaIndex.SafeFuncInGame("OnStartTitle",this) end
function this.SetUpEnemy(missionTable) ZetaIndex.SafeFuncInGame("SetUpEnemy",missionTable ) end
function this.MissionPrepare() ZetaIndex.SafeFuncInGame("MissionPrepare",this)end
function this.PreMissionLoad(missionId,currentMissionId) ZetaIndex.SafeFuncInGame("PreMissionLoad",missionId,currentMissionId) end

return this