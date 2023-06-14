--ZetaMission.lua
--Description: Manages allocation of mod assets, mods in FOB.
local this={
	allModsDisabledForFOB = false,
}
--When FOB is active, all Zeta mods are disabled. On return to ACC, all of the original toggled mods are reloaded.
function this.Update()
	if ZetaVar.IsZetaActive() == false then return nil end --Don't run when Zeta is disabled.
	local isMissionOnline = this.IsOnline()
	local isProtectingFOB = ZetaVar.IsProtectingFOB() 
	local isProtectingFOBChimeras = ZetaVar.IsProtectingFOBChimeras() 
	if isMissionOnline ~= this.allModsDisabledForFOB then
		if isMissionOnline == true then
			if isProtectingFOBChimeras == true then ZetaPlayer.ToggleCustomizedWeapons(false) end
			if isProtectingFOB == true then
				ZetaCore.ReloadMods{toggle=false} --Disables all mods
				TppUiCommand.AnnounceLogView(ZetaDef.modName..": Mods temporarily disabled for FOB")
			end
		elseif InfMain ~= nil then
			if InfMain.IsHelicopterSpace(vars.missionCode) == true then
				if isProtectingFOB == true then ZetaCore.ReloadMods() end --Reloads all mods
				if isProtectingFOBChimeras == true then ZetaPlayer.ToggleCustomizedWeapons(true) end
			end
		end 
		this.allModsDisabledForFOB = isMissionOnline
	end
end
function this.OnAllocate(missionTable)
	if TppScriptVars.IsSavingOrLoading() == false and vars.missionCode>5 then		
		if missionTable.enemy then this.LoadModBlock() end
	end
end
--Certain weapons that are not deployed with the player, or retrieved by supply drops, can't be equiped without using the following function.
--It is worth nothing that you can't request loads for all equips. It is recommended to only load equips necessary for your mod.
--Usage: In the event you wish to switch to a weapon that wasn't obtained through natural means described above.
function this.LoadModBlock() 	
	if TppEquip.RequestLoadToEquipMissionBlock then
		local newEquips = ZetaIndex.ModTables("LoadModBlock", this)
		if newEquips ~= nil and next(newEquips) then TppEquip.RequestLoadToEquipMissionBlock(newEquips) end
	end
end
--Online Mission
function this.IsOnline()
	if gvars ~= nil and TppMission ~= nil and TppServerManager ~= nil then
		if vars.missionCode>5 then		
			if this.IsOnlineMission(vars.missionCode) 
			or this.IsOnlineMission(TppMission.GetNextMissionCodeForEmergency()) 
			or this.IsOnlineMission(TppMission.GetNextMissionCodeForMissionClear()) 
			or this.IsOnlineMission(gvars.title_nextMissionCode) 
			or TppServerManager.FobIsSneak() 
			or vars.fobIsPlaceMode >= 1 then
				return true
			end
		end	
	end
	return false
end
function this.IsOnlineMission(missionCode)
	if InfMain ~= nil then
		if InfMain.IsOnlineMission(missionCode) or TppMission.IsFOBMission(missionCode) then
			return true
		end
	end
	return false
end
return this