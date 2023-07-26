--ZetaPlayerParts.lua
--Description: Handles IHHook's player parts override system
--Example:
--[[
	--Adding the following function to your Zeta script will allow it to override player parts when they are requested, such during sortie or mod reloads.
	--LoadPlayerParts() overrides requested player parts assets return whenever the following variables change: vars.playerType, vars.playerPartsType, vars.playerCamoType, vars.handEquip, vars.playerFaceId, vars.playerFaceEquipId
	function this.LoadPlayerParts()
		return{			
			{ --Venom Snake w/ Scarf, using Olive Drab Camo
				player={type="SNAKE",partsType="NORMAL_SCARF",camoType="OLIVEDRAB"}, --Represents vars that must match in order to replace active player parts
				body={ --Overrides primary player parts.
					fpk="/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk",
    				parts="/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts",
					fv2="/Assets/tpp/fova/chara/sna/sna0_main1_def_v00.fv2",
				},
				head={ --Overrides attached head part.
					fpk="/Assets/tpp/pack/player/fova/plfova_sna0_face0_v00.fpk",
   					fv2="/Assets/tpp/fova/chara/sna/sna0_face0_v00.fv2",
				},
				hand={ --Overrides bionic arm.
					fpk="/Assets/tpp/pack/player/fova/plfova_sna0_arm0_v00.fpk",
					fv2="/Assets/tpp/fova/chara/sna/sna0_arm0_v00.fv2"
				},
				camo={ --Overrides active camo
					fpk="/Assets/tpp/pack/player/fova/plfova_sna0_main1_c00.fpk",
    				fv2="/Assets/tpp/fova/chara/sna/sna0_main1_c00.fv2",
				},
			},
			{ --Sneaking Suit DD Male
				player={type="DD_MALE",partsType="SNEAKING_SUIT"}, --Can also apply to specific handEquips, faceIds, and faceEquipIds ( bionic arms, staff faces, headgear )
				body={
					fpk="/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk",
    				parts="/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts",
					fv2="/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2",
				},
				head=true, --If true, it will render the part's head as normal. If false, it won't render the head.
				hand=false, --If false, a bionic arm won't render. If true, it will render the bionic arm that Snake/Avatar is wearing.
				camo=false, --If false, it will disable the camo. If true, it will render the selected camo type.
				func=function() --Useful for when you want to execute a function when player parts are changed to this.
					TppUiCommand.AnnounceLogView( "Playing as DD male wearing a DD Sneaking Suit") 
				end, 
			},
		}
	end
]]
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
	reloadSanityTimer = 10, --Parts load for at least 10 frames.
}
--Purpose: Can be used to reload player parts based on current mod settings!
function this.Reload()	
	--Clear values		
	this.newPlayerParts = {}
	this.currentType = {}
	this.safeOverrideActive = nil
	--Gather player parts
	this.playerParts = {}		
	local newParts = ZetaIndex.ModTables("LoadPlayerParts", this) --Acquire LoadPlayerPart infos
	if newParts ~= nil and next(newParts) then this.playerParts = newParts end	
	--Load player parts
	ZetaUtil.SetupParts(this.currentType, this.selectInfos, true )	
	this.Update()
	this.Refresh()
end
--Refreshes player parts when any update.
function this.Refresh()
	if this.loadPlayerPartsCounter == nil then this.loadPlayerPartsCounter = 0 --Reset reload timer
	elseif this.loadPlayerPartsCounter < this.reloadSanityTimer then this.loadPlayerPartsCounter = this.loadPlayerPartsCounter + 1
	elseif this.prevPlayerVars == nil then --Existing previous player vars indicates where in the middle of a refresh.
		this.prevPlayerVars = { --Save current player type, temporarily switch to another player part. Prevent module from updating
			{id="playerType",val=vars.playerType},
			{id="playerPartsType",val=vars.playerPartsType},
			{id="playerCamoType",val=vars.playerCamoType},
			{id="playerFaceId",val=vars.playerFaceId},
			{id="playerFaceEquipId",val=vars.playerFaceEquipId},
		}
		local prevType = 0
		if vars.playerCamoType == 0 then prevType = 1 end	
		vars.playerCamoType = prevType --Temporarily switch var to trigger reload.
	elseif PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, } then
		for i,playerVar in ipairs(this.prevPlayerVars)do vars[playerVar.id] = playerVar.val end
		this.prevPlayerVars = nil --Clear previous player vars so player parts can override
		this.loadPlayerPartsCounter = nil --Clear parts reload timer
	end 
end
--Don't override when init
function this.CanOverridePlayerParts()
	if vars.missionCode<=5 then	return false end --Don't let parts override during boot process
	--TODO: Add whitelist that protects custom locations/missions from Zeta overriding their set player parts
	return true
end
function this.Update()
	if IhkCharacter == nil then	return nil end --IhkCharacter is missing
	local safeOverride = this.CanOverridePlayerParts()--Applies on player part change and when it's safe/unsafe to override
	if safeOverride == true then --Refresh parts 
		if this.prevPlayerVars ~= nil or this.loadPlayerPartsCounter ~= nil then 
			this.Refresh()
			return nil
		end
	end
	if this.safeOverrideActive == safeOverride and safeOverride == false then return nil end --If safe override changes, it'll toggle parts. Otherwise, if it hasn't and is false, don't update.
	if ZetaUtil.HasPartChanged(this.currentType, this.selectInfos) == false then return nil end --If returned parts or safe override is the same, don't override.
	ZetaIndex.SafeFuncInGame("OnPlayerPartsChange",this.currentType) --Passdown previous player vars.
	local newParts = {} --Setup player part info table
	local newOverride = false
	if safeOverride == true then
		local getCurrentParts = this.GetCurrentPartsList(this.playerParts) --If any parts were found, apply them when their target parts are active
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
		for xKey,xVal in pairs(this.playerInfos)do --Override player parts	
			for yKey,yVal in pairs(xVal)do 
				if yKey ~= "index" then 
					if IhkCharacter[yVal] ~= nil then IhkCharacter[yVal](newParts[xKey][yKey]) end
				end
			end
		end
	end
	if newOverride == true then IhkCharacter.SetOverrideCharacterSystem(newOverride) end --Toggles override system			
	if safeOverride == true then ZetaUtil.SetupParts(this.currentType, this.selectInfos ) end --Sets current info to vars
	this.safeOverrideActive = safeOverride
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
				for x,fileType in ipairs(this.fileTypes)do --Iterates through file types
					if oldValue[fileType] ~= nil then newValue[fileType] = oldValue[fileType] end
				end
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