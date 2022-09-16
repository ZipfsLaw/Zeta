--ZetaPlayerParts.lua
--Description: Handles IHHook's player parts override system
local this={}

function this.Reload()	
	local orderedList = {}
	local newParts = ZetaIndex.ModGet("LoadPlayerParts", this) 
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
	if ZetaSoldier2FaceAndBodyData ~= nil then
		if ZetaSoldier2FaceAndBodyData.isLoading == true then return false end
	end
	--TODO: Add whitelist that protects custom locations/missions from Zeta overriding their set player parts
	return true
end

function this.Update()
	local safeOverride = this.CanOverridePlayerParts()
	
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
			local newParts = {
				player = {"","",""},
				head = {false,"",""},
				hand = {false,"",""},
				camo = {false,"",""},
			}
			if newOverride == true then
				if this.playerParts ~= nil and next(this.playerParts) then								
					if this.newPlayerParts ~= nil and next(this.newPlayerParts) then						
						for i,partsList in ipairs(this.newPlayerParts)do
							--Player parts
							local playerPart = ZetaUtil.GetPartValue(partsList, "Parts", 2)
							if playerPart ~= nil then
								if next(playerPart) then
									if playerPart[1] ~= nil then newParts.player.fpk = playerPart[1] end 	
									if playerPart[2] ~= nil then newParts.player.parts = playerPart[2] end 
									if playerPart[3] ~= nil then newParts.player.fv2 = playerPart[3] end
								end
							end				
							local headPart = ZetaUtil.GetPartValue(partsList, "Head", 3) --Head
							local handPart = ZetaUtil.GetPartValue(partsList, "Hand", 4)--Bionic arm/Left arm
							local camoPart = ZetaUtil.GetPartValue(partsList, "Camo", 5)--Camo
							this.SetPartValue(headPart,newParts.head)
							this.SetPartValue(handPart,newParts.hand)
							this.SetPartValue(camoPart,newParts.camo)
						end	
					end
				end					
			end
			
			--Overrides current parts
			if newOverride == false then IhkCharacter.SetOverrideCharacterSystem(newOverride) end	
			--Set before all for validation!
			IhkCharacter.SetPlayerTypeForPartsType(vars.playerType)
			IhkCharacter.SetPlayerPartsTypeForPartsType(vars.playerPartsType)						
			--Body
			IhkCharacter.SetPlayerPartsFpkPath(newParts.player.fpk) 	
			IhkCharacter.SetPlayerPartsPartsPath(newParts.player.parts) 
			IhkCharacter.SetSkinToneFv2Path(newParts.player.fv2)
			--Head
			IhkCharacter.SetUseHeadForPlayerParts(newParts.head.active)
			IhkCharacter.SetSnakeFaceFpkPath(newParts.head.fpk)
			IhkCharacter.SetSnakeFaceFv2Path(newParts.head.fv2)
			--Bionic hand
			IhkCharacter.SetUseBionicHandForPlayerParts(newParts.hand.active)
			IhkCharacter.SetBionicHandFpkPath(newParts.hand.fpk)
			IhkCharacter.SetBionicHandFv2Path(newParts.hand.fv2)
			--Camo
			IhkCharacter.SetUseCamoForPlayerParts(newParts.camo.active)
			IhkCharacter.SetPlayerCamoFpkPath(newParts.camo.fpk)
			IhkCharacter.SetPlayerCamoFv2Path(newParts.camo.fv2)
			--Overrides current parts
			if newOverride == true then IhkCharacter.SetOverrideCharacterSystem(newOverride) end				
			if safeOverride == true then
				this.curPlayerType = vars.playerType
				this.curPlayerPartsType = vars.playerPartsType
				this.curPlayerFaceId = vars.playerFaceId
				this.curPlayerFaceEquipId = vars.playerFaceEquipId
				this.curPlayerCamoType = vars.playerCamoType 			
				this.ReloadPlayerPartsSafe()
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
			local playerSelect = ZetaUtil.GetPartValue(partsList, "Select", 1) 
			if playerSelect ~= nil then
				local curParts = {
					playerSelect, 
					ZetaUtil.GetPartValue(partsList, "Parts", 2),
					ZetaUtil.GetPartValue(partsList, "Head", 3),
					ZetaUtil.GetPartValue(partsList, "Hand", 4),
					ZetaUtil.GetPartValue(partsList, "Camo", 5),
				}
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
						if playerType == PlayerType[playerSelect] or --Is it a player type?
						playerPartsType == PlayerPartsType[playerSelect] or --Is it a player part type?
						playerCamoType == PlayerCamoType[playerSelect] then --Is it a player camo type?
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

function this.ReloadPlayerPartsSafe()
	local function changeParts()
		--Save current player type, temporarily switch to another player part. Prevent module from updating
		this.prevPlayerTypeSafe = vars.playerCamoType
		local newPlayerType = 0
		if this.prevPlayerTypeSafe == 0 then newPlayerType = 1 end	
		vars.playerCamoType = newPlayerType	
		for i=0,5,1 do coroutine.yield() end
		--Switch back to previous player type. Allow module to update.
		vars.playerCamoType = this.prevPlayerTypeSafe
		this.prevPlayerTypeSafe = nil
	end
	do
		local co=coroutine.create(changeParts)
		repeat
			local ok,ret=coroutine.resume(co)
			if not ok then error(ret) end
		until coroutine.status(co)=="dead"
	end
end

function this.SetPartValue(partValue,newValue)
	if partValue ~= nil then			
		if type(partValue) == "table" then
			if next(partValue) then
				newValue.active = true
				if partValue[1] ~= nil then newValue.fpk = partValue[1] end
				if partValue[2] ~= nil then newValue.fv2 = partValue[2] end
			end
		else 
			newValue.active = partValue 
			newValue.fpk = ""
			newValue.fv2 = ""
		end
	end
end

return this