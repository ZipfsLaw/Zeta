--ZetaBuddyParts.lua
--Description: Handles IHHook's buddy override system
local this={
	buddyInfos = {
		{ id="horse",var="buddyHorseType",func="SetBuddyHorsePartsFpkPath",index=1},
		{ id="dog",var="buddyDogEquipType",func="SetBuddyDogPartsFpkPath",index=2},
		{ id="quiet",var="buddyQuietCostumeType",func="SetBuddyQuietPartsFpkPath",index=3},
		{ id="walker",var=nil, func="SetBuddyWalkerGearPartsFpkPath",index=4},
	},
	buddyEqpInfos = {
		{id="quietWeapon",var="buddyQuietEquipType",func="SetBuddyQuietWeaponFpkPath",index=1},
		{id="walkerGearArm",var="buddyGearArmType",func="SetBuddyWalkerGearArmFpkPath",index=2},
		{id="walkerGearHead",var="buddyGearHeadType",func="SetBuddyWalkerGearHeadFpkPath",index=3},
		{id="walkerGearWeapon",var="buddyGearMainWPType",func="SetBuddyWalkerGearWeaponFpkPath",index=4},
	}
}

function this.Reload()	
	--Clear override
	if IhkBuddy ~= nil then
		if this.buddyParts ~= nil and next(this.buddyParts) then IhkBuddy.SetOverrideBuddySystem(false) end
		if this.buddyEqpParts ~= nil and next(this.buddyEqpParts) then IhkBuddy.SetOverrideBuddyEquipmentSystem(false) end
	end
	
	--Clear certain tables
	this.buddyParts = {}	
	this.buddyEqpParts = {}			
	this.currentType = {}
	this.currentEqpType = {}	
	this.currentType.buddy = -1
	this.currentType.sortieBuddy = -1
	ZetaUtil.SetupParts(this.currentType, this.buddyInfos, true )	
	ZetaUtil.SetupParts(this.currentEqpType, this.buddyEqpParts, true )	

	--Custom buddy parts
	local newParts = ZetaIndex.ModTables("LoadBuddyParts", this) 
	local newEqpParts = ZetaIndex.ModTables("LoadBuddyEquipment", this) 
	if newParts ~= nil and next(newParts) then this.buddyParts = newParts end	
	if newEqpParts ~= nil and next(newEqpParts) then this.buddyEqpParts = newEqpParts end	
end

function this.Update()
	if this.currentType ~= nil then
		--Applies on buddy type change and when it's safe/unsafe to override
		if this.currentType.buddy ~= vars.buddyType --Did our buddy change?
		or this.currentType.sortieBuddy ~= vars.sortieBuddyType --Did the buddy we'll get in sortie change?
		or ZetaUtil.HasPartChanged(this.currentType, this.buddyInfos) == true then --Did any of our parts change?
			local currentParts = {}
			if this.buddyParts ~= nil and next(this.buddyParts) then
				for i,partsList in ipairs(this.buddyParts)do
					local buddyVar = this.GetPartsVar( ZetaUtil.GetPartValue(partsList, "BuddyType", 1), this.buddyInfos )
					if buddyVar ~= nil and next(buddyVar) then --We have a buddy, right?
						if vars.buddyType == buddyVar.index then --Does it match?
							local activePart = this.IsPartActive(buddyVar.index, partsList,"CostumeType",this.buddyInfos) --Are those parts active?
							if activePart ~= nil then currentParts[buddyVar.id] = activePart end
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
				for i,buddyVar in ipairs(this.buddyInfos)do
					local buddyFunc = IhkBuddy[buddyVar.func]
					if buddyFunc ~= nil then
						if canOverride == true then
							if currentParts[buddyVar.id] ~= nil then buddyFunc( currentParts[buddyVar.id] ) else buddyFunc( "" ) end
						else buddyFunc( "" ) end
					end
				end
			end		
			--Save new part vars
			this.currentType.buddy = vars.buddyType
			this.currentType.sortieBuddy = vars.sortieBuddyType 
			ZetaUtil.SetupParts(this.currentType, this.buddyInfos )	
		end
	end
	
	if this.currentEqpType ~= nil then
		--Applies on buddy equipment change and when it's safe/unsafe to override
		if ZetaUtil.HasPartChanged(this.currentEqpType, this.buddyEqpParts) == true then --Did any of the buddy's eqp's change?
			local currentParts = {}
			if this.buddyEqpParts ~= nil and next(this.buddyEqpParts) then
				for i,partsList in ipairs(this.buddyEqpParts)do
					local eqpVar = this.GetPartsVar( ZetaUtil.GetPartValue(partsList, "BuddyEqpType", 1), this.buddyEqpInfos)
					if eqpVar ~= nil then
						local activePart = this.IsPartActive(eqpVar.index, partsList, "BuddyEqpSubType", this.buddyEqpInfos)
						if activePart ~= nil then currentParts[eqpVar.id] = activePart end
					end
				end
			end	
			local canOverride = false;
			if currentParts ~= nil and next(currentParts) then canOverride = true end	
			--If any parts were found, apply them when their target parts are active
			if IhkBuddy ~= nil then
				IhkBuddy.SetOverrideBuddyEquipmentSystem(canOverride)
				for i,buddyEqpVar in ipairs(this.buddyEqpInfos)do
					local buddyEqpFunc = IhkBuddy[buddyEqpVar.func]
					if buddyEqpFunc ~= nil then
						if canOverride == true then
							if currentParts[buddyEqpVar.id] ~= nil then buddyEqpFunc( currentParts[buddyEqpVar.id] ) else buddyEqpFunc( "" ) end
						else buddyEqpFunc("") end
					end
				end
			end		
			ZetaUtil.SetupParts(this.currentEqpType, this.buddyEqpInfos ) --Save new part vars
		end
	end
end
--Part Management
function this.GetPartsVar( type, infosTable )
	local typeAlts = ZetaUtil.GetAltStrings(type)
	if infosTable ~= nil and next(infosTable) then
		for x, altType in ipairs(typeAlts) do
			for y, bVar in ipairs(infosTable) do
				if altType == bVar.index --Does it match the index?
				or altType == bVar.id --Does it match the key name?
				or altType == bVar.var then --Does it match the id name? ( its vars.* counterpart )
					return bVar --Return buddy value
				end
			end
		end
	end
	return nil
end
function this.IsPartActive(partType, partsList, buddyPartVar, infosTable)
	local newPartType = ZetaUtil.GetPartValue(partsList, buddyPartVar, 2)
	for i, bVar in ipairs(infosTable) do
		if bVar.var == nil then return fpkPath end --No var? Return regardless. DWalker doesn't have a var to use ( yet )
		if bVar.index == partType then --Does buddy type match?
			if newPartType == vars[bVar.var] then return ZetaUtil.GetPartValue(partsList, "FpkPath", 3) end --Does outfit var match? Return buddy part
		end
	end
	return nil
end
return this