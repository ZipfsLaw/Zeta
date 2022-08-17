--ZetaPlayerParts.lua
--Description: Handles IHHook's player parts override system
local this={}

function this.Reload()	
	local orderedList = {}
	local newParts = ZetaIndex.SafeGet("LoadPlayerParts", this) 
	if newParts ~= nil and next(newParts) then
		for x,partsList in ipairs(newParts)do
			if partsList ~= nil and next(partsList) then
				for y,parts in ipairs(partsList)do
					table.insert( orderedList, parts )
				end
			end
		end		
	end
	
	--Clear override
	if this.newPlayerParts ~= nil and next(this.newPlayerParts) then
		if IhkCharacter ~= nil then
			IhkCharacter.SetOverrideCharacterSystem(false)
		end	
	end
	
	--Clear certain tables
	this.playerParts = {}				
	this.curPlayerType = {}
	this.curPlayerPartsType = {}
	this.newPlayerParts = {}

	--Custom player parts
	if orderedList ~= nil and next(orderedList) then
		this.playerParts = orderedList
	end	
end

--Don't override when init
function this.CanOverridePlayerParts()
	if vars.missionCode<=5 then	return false end
	return true
end

function this.Update()
	local safeOverride = this.CanOverridePlayerParts()
	
	--Refresh parts 
	if safeOverride == true then
		if this.prevPlayerTypeSafe ~= nil then 
			this.ReloadPlayerPartsSafe(false)
			return nil
		end
	end
	
	--Applies on player part change and when it's safe/unsafe to override
	if this.curPlayerType ~= vars.playerType 
	or this.curPlayerPartsType ~= vars.playerPartsType 
	or this.curPlayerFaceId ~= vars.playerFaceId 
	or this.curPlayerFaceEquipId ~= vars.playerFaceEquipId 
	or this.curPlayerCamoType ~= vars.playerCamoType 
	or this.safeOverrideActive ~= safeOverride then	
		--If any parts were found, apply them when their target parts are active
		if IhkCharacter ~= nil then
			local newOverride = false	
			local getCurrentParts = this.GetCurrentPartsList(this.playerParts)
			if getCurrentParts ~= nil and next(getCurrentParts) then
				this.newPlayerParts = getCurrentParts
				newOverride = safeOverride --Override when it's safe
			end
			local usePlayer = {"","",""}
			local useHead = {false,"",""}
			local useHand = {false,"",""}	
			local useCamo = {false,"",""}

			if newOverride == true then
				if this.playerParts ~= nil and next(this.playerParts) then								
					if this.newPlayerParts ~= nil and next(this.newPlayerParts) then						
						for i,partsList in ipairs(this.newPlayerParts)do
							--Player parts
							local playerPart = partsList[1]
							if playerPart ~= nil then
								if next(playerPart) then
									if playerPart[1] ~= nil then usePlayer[1] = playerPart[1] end 	
									if playerPart[2] ~= nil then usePlayer[2] = playerPart[2] end 
									if playerPart[3] ~= nil then usePlayer[3] = playerPart[3] end
								end
							end
							
							--Head
							local headPart = partsList[2]
							if headPart ~= nil then
								if type(headPart) == "table" then
									if next(headPart) then
										useHead[1] = true
										if headPart[1] ~= nil then useHead[2] = headPart[1] end
										if headPart[2] ~= nil then useHead[3] = headPart[2] end
									end
								else 
									useHead[1] = headPart 
									useHead[2] = ""
									useHead[3] = ""
								end
							end
							
							--Bionic arm/Left arm
							local handPart = partsList[3]
							if handPart ~= nil then			
								if type(handPart) == "table" then
									if next(handPart) then
										useHand[1] = true
										if handPart[1] ~= nil then useHand[2] = handPart[1] end
										if handPart[2] ~= nil then useHand[3] = handPart[2] end
									end
								else 
									useHand[1] = handPart 
									useHand[2] = ""
									useHand[3] = ""
								end
							end

							--Camo
							local camoPart = partsList[4]
							if camoPart ~= nil then			
								if type(camoPart) == "table" then
									if next(camoPart) then
										useCamo[1] = true
										if camoPart[1] ~= nil then useCamo[2] = camoPart[1] end
										if camoPart[2] ~= nil then useCamo[3] = camoPart[2] end
									end
								else 
									useCamo[1] = camoPart 
									useCamo[2] = ""
									useCamo[3] = ""
								end
							end
						end	
					end
				end					
			end
			
			--Set before all for validation!
			IhkCharacter.SetPlayerTypeForPartsType(vars.playerType)
			IhkCharacter.SetPlayerPartsTypeForPartsType(vars.playerPartsType)
			
			--Overrides current parts
			if newOverride == false then
				IhkCharacter.SetOverrideCharacterSystem(newOverride) 
			end
							
			--Body
			IhkCharacter.SetPlayerPartsFpkPath(usePlayer[1]) 	
			IhkCharacter.SetPlayerPartsPartsPath(usePlayer[2]) 
			IhkCharacter.SetSkinToneFv2Path(usePlayer[3])

			--Head
			IhkCharacter.SetUseHeadForPlayerParts(useHead[1])
			IhkCharacter.SetSnakeFaceFpkPath(useHead[2])
			IhkCharacter.SetSnakeFaceFv2Path(useHead[3])

			--Bionic hand
			IhkCharacter.SetUseBionicHandForPlayerParts(useHand[1])
			IhkCharacter.SetBionicHandFpkPath(useHand[2])
			IhkCharacter.SetBionicHandFv2Path(useHand[3])

			--Camo
			IhkCharacter.SetUseCamoForPlayerParts(useCamo[1])
			IhkCharacter.SetPlayerCamoFpkPath(useCamo[2])
			IhkCharacter.SetPlayerCamoFv2Path(useCamo[3])

			--Overrides current parts
			if newOverride == true then
				IhkCharacter.SetOverrideCharacterSystem(newOverride) 
			end				
			if safeOverride == true then
				this.curPlayerType = vars.playerType
				this.curPlayerPartsType = vars.playerPartsType
				this.curPlayerFaceId = vars.playerFaceId
				this.curPlayerFaceEquipId = vars.playerFaceEquipId
				this.curPlayerCamoType = vars.playerCamoType 			
				this.ReloadPlayerPartsSafe(true)
			end
			
			this.safeOverrideActive = safeOverride
		end
	end
end

function this.GetCurrentPartsList(newPlayerParts)
	local playerPartsList = {}
	local playerType = vars.playerType
	local playerPartsType = vars.playerPartsType
	local playerCamoType = vars.playerCamoType 
	if newPlayerParts ~= nil and next(newPlayerParts) then
		for i,partsList in ipairs(newPlayerParts)do
			local playerSelect = partsList[1]
			if playerSelect ~= nil then
				local curParts = { partsList[2], partsList[3], partsList[4],partsList[5],partsList[6] }
				local typePS = type(playerSelect)		
				if typePS == "table" then --matches with table { PlayerType, PlayerPartsType, PlayerCamoType }
					if next(playerSelect) then
						if playerType == PlayerType[playerSelect[1]] then --Player Type
							if playerPartsType == PlayerPartsType[playerSelect[2]] --Player Parts Type
							or playerSelect[2] == nil then --can be nil so it always applies 
								if playerCamoType == PlayerCamoType[playerSelect[3]] --Player Camo Type
								or playerSelect[3] == nil then --can be nil so it always applies 
									table.insert(playerPartsList,curParts)
								end
							end
						end
					end
				elseif typePS == "string" then --Match with type in general
					if playerSelect ~= "" then
						if playerType == PlayerType[playerSelect] then --Is it a player type?
							table.insert(playerPartsList,curParts)
						elseif playerPartsType == PlayerPartsType[playerSelect] then --Is it a player part type?
							table.insert(playerPartsList,curParts)
						elseif playerCamoType == PlayerCamoType[playerSelect] then --Is it a player camo type?
							table.insert(playerPartsList,curParts)
						end
					end
				end
			end
		end
	end	
	if playerPartsList ~= nil then
		if next(playerPartsList) then
			return playerPartsList
		end
	end	
	return nil
end

function this.ReloadPlayerPartsSafe(toggle)
	if toggle == true then
		--Save current player type, temporarily switch to another player part. Prevent module from updating
		this.prevPlayerTypeSafe = vars.playerCamoType
		local newPlayerType = 0
		if this.prevPlayerTypeSafe == 0 then newPlayerType = 1 end	
		vars.playerCamoType = newPlayerType	
	else
		--Switch back to previous player type. Allow module to update.
		vars.playerCamoType = this.prevPlayerTypeSafe
		this.prevPlayerTypeSafe = nil
	end
end

return this