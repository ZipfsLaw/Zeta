--ZetaMission.lua
--Description: Handles FOB protection, allocating mod content.
local this={}

--Don't allow players to use mods online
function this.Update()
	if ZetaVar.IsProtectingFOB() == true then
		local isMissionOnline = this.IsOnline()
		if isMissionOnline ~= this.allModsDisabledForFOB then
			if ZetaVar.IsZetaActive() == true then
				if isMissionOnline == true then
					ZetaCore.ReloadMods({toggle=false})
					TppUiCommand.AnnounceLogView(ZetaIndex.debugModName..": Mods temporarily disabled for FOB")--DEBUG
				elseif isMissionOnline == false then
					if InfMain.IsHelicopterSpace(vars.missionCode) == true then
						ZetaCore.ReloadMods({toggle=true})
					end
				end
			end
			this.allModsDisabledForFOB = isMissionOnline
		end
	end
end

--Load equip fpks
function this.LoadModBlock() 	
	if TppEquip.RequestLoadToEquipMissionBlock then
		local orderedList = {}
		local newEquips = ZetaIndex.SafeGet("LoadModBlock", this) --ZetaIndex.ModGet("LoadModBlock") 
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

--Online Mission
this.allModsDisabledForFOB = false
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

return this