--ZetaPlayerParts.lua
--Description: Handles IHHook's player parts override system
local this={
	selectInfos={ --Selectors for LoadPlayerParts()
		{ id="type", var="playerType", table=PlayerType }, --Snake, Avatar, DD Male and Female
		{ id="partsType", var="playerPartsType", table=PlayerPartsType }, --Outfits
		{ id="camoType", var="playerCamoType", table=PlayerCamoType }, --Camo Fatigues
		{ id="handEquip", var="handEquip", table=nil }, --Bionic Hand
		{ id="faceId", var="playerFaceId", table=nil }, --Soldier Faces
		{ id="faceEquipId", var="playerFaceEquipId", table=nil }, --Headgear, such as helmets and balaclavas
	},
	playerInfos={ --IHHook functions for each LoadPlayerParts() parameter
		body={fpk="SetPlayerPartsFpkPath", parts="SetPlayerPartsPartsPath", fv2="SetSkinToneFv2Path", index=2},
		head={active="SetUseHeadForPlayerParts", fpk="SetSnakeFaceFpkPath", fv2="SetSnakeFaceFv2Path", index=3},
		hand={active="SetUseBionicHandForPlayerParts", fpk="SetBionicHandFpkPath", fv2="SetBionicHandFv2Path", index=4},
		camo={active="SetUseCamoForPlayerParts", fpk="SetPlayerCamoFpkPath", fv2="SetPlayerCamoFv2Path", index=5},
	},
	fileTypes={"fpk","fv2","parts"}, --For keyless tables
}
function this.Reload()	
	--Clear override
	if this.newPlayerParts ~= nil and next(this.newPlayerParts) then
		if IhkCharacter ~= nil then IhkCharacter.SetOverrideCharacterSystem(false) end	
	end
	--Custom player parts
	this.playerParts = {}		
	local newParts = ZetaIndex.ModTables("LoadPlayerParts", this) --Acquire LoadPlayerPart infos
	if newParts ~= nil and next(newParts) then this.playerParts = newParts end	
	--Clear values		
	this.newPlayerParts = {}
	this.currentType = {}
	ZetaUtil.SetupParts(this.currentType, this.selectInfos, true )	
end
--Refreshes player parts when any update.
function this.Refresh()
	if this.prevPlayerVars == nil then
		this.prevPlayerVars = { --Save current player type, temporarily switch to another player part. Prevent module from updating
			{id="playerType",val=vars.playerType},
			{id="playerPartsType",val=vars.playerPartsType},
			{id="playerCamoType",val=vars.playerCamoType},
			{id="playerFaceId",val=vars.playerFaceId},
			{id="playerFaceEquipId",val=vars.playerFaceEquipId},
		}
		local prevType = 0
		if vars.playerCamoType == 0 then prevType = 1 end	
		vars.playerCamoType = prevType	
	else
		for i,playerVar in ipairs(this.prevPlayerVars)do vars[playerVar.id] = playerVar.val end
		this.prevPlayerVars = nil --Clear previous player vars so player parts can override
	end
end
--Don't override when init
function this.CanOverridePlayerParts()
	if vars.missionCode<=5 then	return false end --Don't let parts override during boot process
	--TODO: Add whitelist that protects custom locations/missions from Zeta overriding their set player parts
	return true
end
function this.Update()
	local safeOverride = this.CanOverridePlayerParts()--Applies on player part change and when it's safe/unsafe to override
	if safeOverride == true then --Refresh parts 
		if this.prevPlayerVars ~= nil then 
			this.Refresh()
			return nil
		end
	end
	if ZetaUtil.HasPartChanged(this.currentType, this.selectInfos) == true --Did any of our parts change?
	or this.safeOverrideActive ~= safeOverride then	
		--If any parts were found, apply them when their target parts are active
		if IhkCharacter ~= nil then	
			ZetaIndex.SafeFuncInGame("OnPlayerPartsChange",this.currentType) --Passdown previous player vars.
			local newParts = {} --Setup player part info table
			local newOverride = false
			if safeOverride == true then
				local getCurrentParts = this.GetCurrentPartsList(this.playerParts)
				if getCurrentParts ~= nil and next(getCurrentParts) then
					this.newPlayerParts = getCurrentParts
					newOverride = safeOverride --Override when it's safe
				end
				for pKey,pVal in pairs(this.playerInfos)do --Uses playerInfos table to set parameters.
					if pVal.index == 2 then newParts[pKey] = {"","",""} --Body uses .parts file.
					else newParts[pKey] = {false,"",""} end --Other params have an "active" boolean
				end
				if newOverride == true then --There are parts to use and it is safe to override current player parts
					if this.playerParts ~= nil and next(this.playerParts) then --Do we have any mods that override player parts at all?		
						if this.newPlayerParts ~= nil and next(this.newPlayerParts) then --Do we have override parts?			
							for i,partsList in ipairs(this.newPlayerParts)do --Iterate through override parts
								for pKey,pVal in pairs(this.playerInfos)do this.SetPartValue(ZetaUtil.GetPartValue(partsList,pKey,pVal.index),newParts[pKey]) end
								if partsList.func ~= nil then partsList.func() end --Fire Player Parts On Change Func
							end	
						end
					end		
				end			
			end
			if newOverride == false then IhkCharacter.SetOverrideCharacterSystem(newOverride) end --Toggles override system
			--Set before all for validation!
			IhkCharacter.SetPlayerTypeForPartsType(vars.playerType)
			IhkCharacter.SetPlayerPartsTypeForPartsType(vars.playerPartsType)				
			if newParts ~= nil and next(newParts)then
				--Override player parts	
				for xKey,xVal in pairs(this.playerInfos)do 
					for yKey,yVal in pairs(xVal)do 
						if yKey ~= "index" then 
							if IhkCharacter[yVal] ~= nil then IhkCharacter[yVal](newParts[xKey][yKey]) end
						end
					end
				end
			end
			if newOverride == true then IhkCharacter.SetOverrideCharacterSystem(newOverride) end --Toggles override system			
			if safeOverride == true then
				ZetaUtil.SetupParts(this.currentType, this.selectInfos ) --Sets current info to vars
				this.Refresh()
			end		
			this.safeOverrideActive = safeOverride
		end
	end
end
function this.GetCurrentPartsList(newPlayerParts)
	local playerPartsList = {}
	if newPlayerParts ~= nil and next(newPlayerParts) then
		local playerType = vars.playerType
		local playerPartsType = vars.playerPartsType
		local playerCamoType = vars.playerCamoType 
		for i,partsList in ipairs(newPlayerParts)do
			local playerSelect = ZetaUtil.GetPartValue(partsList, "Player", 1) 
			if playerSelect ~= nil then
				local typePS = type(playerSelect)
				local curParts = {Player=playerSelect,} --Add player select info and its parts
				curParts.func = ZetaUtil.GetPartValue(partsList, "Func") --Adds On Change Func from info. Doesn't use an index.
				for pKey,pVal in pairs(this.playerInfos)do curParts[pKey] = ZetaUtil.GetPartValue(partsList,pKey,pVal.index) end	
				if typePS == "table" then --matches with table { PlayerType, PlayerPartsType, PlayerCamoType, playerFaceId, playerFaceEquipId }
					if this.IsPlayerUsingParts(playerSelect) == true then table.insert(playerPartsList,curParts) end
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
	if playerPartsList ~= nil and next(playerPartsList) then return playerPartsList end
	return nil
end
--Looks for both keys and indexes
function this.IsPlayerUsingParts(playerSelect)
	for i,selectInfo in ipairs(this.selectInfos)do
		local newVal = ZetaUtil.GetPartValue(playerSelect, selectInfo.id, i)
		if newVal ~= nil then --Nils are wildcards
			local curVal = vars[selectInfo.var] --Get current value
			if selectInfo.table ~= nil then newVal = selectInfo.table[newVal] end --If there's a table, find values in table.
			if newVal ~= curVal then return false end --A part doesn't match?
		end
	end	
	return true --All parts match or some wildcards exist
end
function this.SetPartValue(oldValue,newValue)
	if oldValue ~= nil then			
		if type(oldValue) == "table" then
			if next(oldValue) then
				newValue.active = true
				for i=1,3,1 do --Resolves fpk, fv2, parts file path order by matching strings
					local partValue = oldValue[i] 
					if partValue ~= nil then --If it's nil, skip
						for x,fileType in ipairs(this.fileTypes)do --Iterates through file types
							if string.match( partValue, "."..fileType ) then newValue[fileType] = partValue end
						end
					end
				end
			end
		else --Are there no parts? 
			newValue.active = oldValue --Toggles part
			for x,fileType in ipairs(this.fileTypes)do newValue[fileType] = "" end --Empties part path
		end
	end
end
return this