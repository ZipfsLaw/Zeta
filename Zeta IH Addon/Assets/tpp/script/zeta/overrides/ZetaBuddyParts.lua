--ZetaBuddyParts.lua
--Description: Handles IHHook's buddy override system
local this={
	buddyInfos = {
		{type="horse", func="SetBuddyHorsePartsFpkPath"},
		{type="dog", func="SetBuddyDogPartsFpkPath"},
		{type="quiet", func="SetBuddyQuietPartsFpkPath"},
		{type="walker", func="SetBuddyWalkerGearPartsFpkPath"},
	},
	buddyEqpInfos = {
		{type="quietWeapon", func="SetBuddyQuietWeaponFpkPath"},
		{type="walkerGearArm", func="SetBuddyWalkerGearArmFpkPath"},
		{type="walkerGearHead", func="SetBuddyWalkerGearHeadFpkPath"},
		{type="walkerGearWeapon", func="SetBuddyWalkerGearWeaponFpkPath"},
	}
}

function this.Reload()	
	local orderedList = {}
	local orderedListEquip = {}
	
	local newParts = ZetaIndex.ModGet("LoadBuddyParts", this) 
	if newParts ~= nil and next(newParts) then
		for x,partsList in ipairs(newParts)do
			if partsList ~= nil and next(partsList) then
				for y,parts in ipairs(partsList)do
					table.insert( orderedList, parts )
				end
			end
		end		
	end
	
	local newEqpParts = ZetaIndex.ModGet("LoadBuddyEquipment", this) 
	if newEqpParts ~= nil and next(newEqpParts) then
		for x,partsList in ipairs(newEqpParts)do
			if partsList ~= nil and next(partsList) then
				for y,parts in ipairs(partsList)do
					table.insert( orderedListEquip, parts )
				end
			end
		end		
	end
	
	--Clear override
	if IhkBuddy ~= nil then
		if this.buddyParts ~= nil and next(this.buddyParts) then IhkBuddy.SetOverrideBuddySystem(false) end
		if this.buddyEqpParts ~= nil and next(this.buddyEqpParts) then IhkBuddy.SetOverrideBuddyEquipmentSystem(false) end
	end
	
	--Clear certain tables
	this.buddyParts = {}	
	this.buddyEqpParts = {}					
	this.currentType = { 
		dog = -1,
		horse = -1,
		quiet = -1,
		buddy = -1,
		sortieBuddy = -1,
	}
	this.currentEqpType = { 
		quietWeapon = -1,
		walkerGearArm = -1,
		walkerGearHead = -1,
		walkerGearWeapon = -1,
	}

	--Custom buddy parts
	if orderedList ~= nil and next(orderedList) then this.buddyParts = orderedList end	
	if orderedListEquip ~= nil and next(orderedListEquip) then this.buddyEqpParts = orderedListEquip end	
end

function this.Update()
	if this.currentType ~= nil then
		--Applies on buddy type change and when it's safe/unsafe to override
		if this.currentType.horse ~= vars.buddyHorseType 
		or this.currentType.dog ~= vars.buddyDogEquipType 
		or this.currentType.quiet ~= vars.buddyQuietCostumeType 
		or this.currentType.buddy ~= vars.buddyType 
		or this.currentType.sortieBuddy ~= vars.sortieBuddyType then	
			local currentParts = {}
			if this.buddyParts ~= nil then
				if next(this.buddyParts) then
					for i,partsList in ipairs(this.buddyParts)do
						local buddyType = this.BuddyStringToInt( ZetaUtil.GetPartValue(partsList, "BuddyType", 1) )
						local activePart = this.IsPartActive(buddyType, partsList)
						if activePart ~= nil then
							if vars.buddyType == buddyType then
								currentParts[this.buddyInfos[buddyType].type] = activePart
							end
						end
					end
				end
			end	
			local canOverride = false;
			if currentParts ~= nil and next(currentParts) then canOverride = true end
			--If any parts were found, apply them when their target parts are active
			if IhkBuddy ~= nil then
				IhkBuddy.SetBuddyTypeForPartsType(vars.buddyType)
				IhkBuddy.SetOverrideBuddySystem(canOverride)
				if canOverride == true then
					for i,buddyInfo in ipairs(this.buddyInfos)do
						local buddyFunc = IhkBuddy[buddyInfo.func]
						if currentParts[buddyInfo.type] ~= nil then buddyFunc( currentParts[buddyInfo.type] ) else buddyFunc( "" ) end
					end
				else
					for i,buddyInfo in ipairs(this.buddyInfos)do IhkBuddy[buddyInfo.func]("") end
				end
			end		
			this.currentType = {
				horse = vars.buddyHorseType,
				dog = vars.buddyDogEquipType, 
				quiet = vars.buddyQuietCostumeType,
				buddy = vars.buddyType,
				sortieBuddy = vars.sortieBuddyType, 
			}
		end
	end
	
	if this.currentEqpType ~= nil then
		--Applies on buddy equipment change and when it's safe/unsafe to override
		if this.currentEqpType.quietWeapon ~= vars.buddyQuietEquipType
		or this.currentEqpType.walkerGearArm ~= vars.buddyGearArmType 
		or this.currentEqpType.walkerGearHead ~= vars.buddyGearHeadType  
		or this.currentEqpType.walkerGearWeapon ~= vars.buddyGearMainWPType then	
			local currentParts = {}
			if this.buddyEqpParts ~= nil then
				if next(this.buddyEqpParts) then
					for i,partsList in ipairs(this.buddyEqpParts)do
						local eqpType = this.BuddyEquipmentStringToInt( ZetaUtil.GetPartValue(partsList, "BuddyEqpType", 1) )			
						local activePart = this.IsEquipmentActive(eqpType, partsList)
						if activePart ~= nil then currentParts[this.buddyEqpInfos[eqpType].type] = activePart end
					end
				end
			end	
			local canOverride = false;
			if currentParts ~= nil and next(currentParts) then
				canOverride = true
			end	
			--If any parts were found, apply them when their target parts are active
			if IhkBuddy ~= nil then
				IhkBuddy.SetOverrideBuddyEquipmentSystem(canOverride)
				if canOverride == true then
					for i,buddyEqpInfo in ipairs(this.buddyEqpInfos)do
						local buddyEqpFunc = IhkBuddy[buddyEqpInfo.func]
						if currentParts[buddyEqpInfo.type] ~= nil then buddyEqpFunc( currentParts[buddyEqpInfo.type] ) else buddyEqpFunc( "" ) end
					end
				else
					for i,buddyEqpInfo in ipairs(this.buddyEqpInfos)do IhkBuddy[buddyEqpInfo.func]("") end
				end
			end		
			this.currentEqpType = {
				quietWeapon = vars.buddyQuietEquipType,
				walkerGearArm = vars.buddyGearArmType,
				walkerGearHead = vars.buddyGearHeadType,
				walkerGearWeapon = vars.buddyGearMainWPType,
			}
		end
	end
end

function this.IsPartActive(buddyType, partsList)
	local costumeType = ZetaUtil.GetPartValue(partsList, "CostumeType", 2)
	local fpkPath = ZetaUtil.GetPartValue(partsList, "FpkPath", 3)
	local varToCheck = nil
	if buddyType == 1 then varToCheck = vars.buddyHorseType
	elseif buddyType == 2 then varToCheck = vars.buddyDogEquipType
	elseif buddyType == 3 then varToCheck = vars.buddyQuietCostumeType
	elseif buddyType == 4 then return fpkPath
	end
	if varToCheck ~= nil then
		if costumeType == varToCheck then
			return fpkPath
		end
	end
	return nil
end

function this.IsEquipmentActive(eqpType, partsList)
	local buddyEqpType = ZetaUtil.GetPartValue(partsList, "BuddyEqpSubType", 2)
	local varToCheck = nil
	if eqpType == 1 then varToCheck = vars.buddyQuietEquipType
	elseif eqpType == 2 then varToCheck = vars.buddyGearArmType
	elseif eqpType == 3 then varToCheck = vars.buddyGearHeadType
	elseif eqpType == 4 then varToCheck = vars.buddyGearMainWPType
	end
	if varToCheck ~= nil then
		if buddyEqpType == varToCheck then
			return ZetaUtil.GetPartValue(partsList, "FpkPath", 3) --fpkPath
		end
	end
	return nil
end

--Buddy type and costume
function this.BuddyStringToInt( buddyType )
	if type(buddyType) == "number" then return buddyType end
	local newType = 0
	if buddyType == "Horse" then newType = 1
	elseif buddyType == "Dog" then newType = 2
	elseif buddyType == "Quiet" then newType = 3
	elseif buddyType == "WalkerGear" then newType = 4
	end
	return newType
end

--Buddy Equipment
function this.BuddyEquipmentStringToInt( eqpType )
	if type(eqpType) == "number" then return eqpType end
	local newType = 0
	if eqpType == "QuietWeapon" then newType = 1
	elseif eqpType == "WalkerGearArm" then newType = 2
	elseif eqpType == "WalkerGearHead" then newType = 3
	elseif eqpType == "WalkerGearWeapon" then newType = 4
	end
	return newType
end

return this