--ZetaMission.lua
--Description: Manages allocation of mod assets, mods in FOB.
local this={
	allModsDisabledForFOB = false,
}
local InfMain=InfMain
local ZetaCore=ZetaCore

--Online Mission
function this.IsOnline()
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
	
	return false
end

function this.IsOnlineMission(missionCode)
	if InfMain.IsOnlineMission(missionCode) or TppMission.IsFOBMission(missionCode) then
		return true
	end
	return false
end

--When FOB is active, all Zeta mods are disabled. On return to ACC, all of the original toggled mods are reloaded.
function this.Update()
	if ZetaVar.IsZetaActive() == true then
		local isMissionOnline = this.IsOnline()
		local isProtectingFOB = ZetaVar.IsProtectingFOB() 
		local isProtectingFOBChimeras = ZetaVar.IsProtectingFOBChimeras() 
		if isMissionOnline ~= this.allModsDisabledForFOB then
			if isMissionOnline == true then
				if isProtectingFOBChimeras == true then this.ToggleCustomizedWeapons(false) end
				if isProtectingFOB == true then
					ZetaCore.ReloadMods({toggle=false})
					TppUiCommand.AnnounceLogView(ZetaCore.modName..": Mods temporarily disabled for FOB")
				end
			else
				if InfMain.IsHelicopterSpace(vars.missionCode) == true then
					if isProtectingFOB == true then ZetaCore.ReloadMods({toggle=true}) end
					if isProtectingFOBChimeras == true then this.ToggleCustomizedWeapons(true) end
				end
			end
			this.allModsDisabledForFOB = isMissionOnline
		end
	end
end

--Temporarily removes all customized weapons from sortie prep. Currently equiped customized weapons are not temporarily removed. ( yet )
local maxParts = 288
function this.ToggleCustomizedWeapons(toggle)
	if toggle == false then
		this.tempPresetChimeraPart={}
		for i = 0,maxParts-1,1 do 
			this.tempPresetChimeraPart[i] = vars.userPresetChimeraParts[i]
			vars.userPresetChimeraParts[i] = 0
		end
		TppUiCommand.AnnounceLogView(ZetaCore.modName..": Customized weapons temporarily disabled for FOB")
	else
		for i = 0,maxParts-1,1 do vars.userPresetChimeraParts[i] = this.tempPresetChimeraPart[i] end
		this.tempPresetChimeraPart={}
	end
end

--Load equip fpks
function this.LoadModBlock() 	
	if TppEquip.RequestLoadToEquipMissionBlock then
		local orderedList = {}
		local newEquips = ZetaIndex.SafeGet("LoadModBlock", this)
		if newEquips ~= nil and next(newEquips) then
			for i,equipList in ipairs(newEquips)do
				if equipList ~= nil and next(equipList) then
					for t,equip in ipairs(equipList)do
						table.insert(orderedList, equip )
					end	
				end
			end		
		end
		if orderedList ~= nil and next(orderedList) then
			TppEquip.RequestLoadToEquipMissionBlock(orderedList)
		end
	end
end

function this.OnAllocate(missionTable)
	if TppScriptVars.IsSavingOrLoading() == false and vars.missionCode>5 then		
		if missionTable.enemy then
			this.LoadModBlock()
		end
	end
end

return this