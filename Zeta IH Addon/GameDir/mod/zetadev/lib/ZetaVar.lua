--ZetaVar.lua
--Description: Has functions for certain Zeta settings, handling SVars, and variables meant to be kept between soft reloads.
local this={
	globalVars = {}, --Global vars between Zeta mods
}

--Global Vars
function this.GetVar(varname)
	if this.globalVars ~= nil and next(this.globalVars) then
		if this.globalVars[varname] ~= nil then
			return this.globalVars[varname]
		end
	end
	return nil
end

--Zeta IVars
--selIvar: The defined variable for the Ivar
--default: The default value for the Ivar
--useEvars: If no ivars are found, fallback to Evars
function this.GetIvar(selIvar,default,useEvars)
	if Ivars ~= nil then --Checks ivars for settings
		local modValue = Ivars[selIvar]
		if modValue ~= nil then return modValue:Get() end
	end
	if useEvars == true then --Check for evars as fallback
		if evars ~= nil then
			local modValue = evars[selIvar]
			if modValue ~= nil then return modValue end
		end
	end
	if default ~= nil then return default end --If all else fails, use default value provided
	return 0
end
--zetaModule: The Zeta module itself
--optionName: The defined variable for the Ivar
--default: The default value for the Ivar
function this.GetModIvar(zetaModule, optionName, default) return this.GetIvar(ZetaDef.customSettingsName..zetaModule.zetaUniqueName..optionName, default) end

--SVars
function this.ReloadSvars()
	local newSVars = {}	
	if ( ZetaVar.IsZetaActive() == true ) then newSVars = ZetaIndex.ModTables("DeclareSVars", this) end
	return TppSequence.MakeSVarsTable(newSVars)
end

--Zeta General Settings
function this.IsZetaActive()
	local modValue = this.GetIvar(ZetaDef.settingsName.."ZetaActive",1,true)
	if modValue > 0 then return true end
	return false
end
function this.IsProtectingDevFlow()
	local modValue = this.GetIvar(ZetaDef.settingsName.."AcquireUpdates",1,true)
	if modValue > 0 then return true end
	return false
end
function this.IsProtectingFOB()
	local modValue = this.GetIvar(ZetaDef.settingsName.."UseZetaInFOB",0,true)
	if modValue < 1 then return true end
	return false
end
function this.IsProtectingFOBChimeras()
	local modValue = this.GetIvar(ZetaDef.settingsName.."UseCustomizedWeaponsInFOB",0,true)
	if modValue < 1 then return true end
	return false
end

--TPP Enums
--Purpose: Retrieves unique IDs for various enumerations.
function this.Enum(enumTable,varType,varName)
	local fullVarName = varName
	if varType ~= nil then fullVarName = varType.."_"..varName end
    local newEnum = enumTable[fullVarName] 
    if newEnum ~= nil then return newEnum end
    local lastValue = -1
    for k,v in pairs(enumTable)do
		if varType ~= nil then
			local subString = string.sub(k,1,string.len(varType))
			if subString == varType then
				if lastValue < v then lastValue = v end
			end 
		elseif lastValue < v then lastValue = v end
    end
    enumTable[fullVarName] = lastValue + 1
    InfCore.Log(fullVarName..": "..enumTable[fullVarName], true, true )
    return enumTable[fullVarName] 
end
function this.EQP(varName)return this.Enum(TppEquip,"EQP",varName)end
function this.CreateDevCst()
	local startID = 1000 --Start at 1000.
	if this.lastCstID ~= nil then startID = this.lastCstID end --Start from the last assigned cst ID
	local cstDev = ZetaEquipDevelopConstSetting.equipDevTableCst --Develop Const Table
	for x=startID,50000,1 do --Up to 50000 since we'll definitely find a unique dev cst ID
		local isUnique = function() 
			for y,entry in ipairs(cstDev)do
				if entry["p00"] == x then return false end
			end
			return true
		end
		if isUnique() == true then --If it's unique, use it. 
			this.lastCstID = x + 1 --Add one so the next cst ID doesn't start on an already used ID
			return x --Return unique Dst Const ID
		end
	end
	return startID --If all else fails, use the next possible ID
end
function this.DevCst(varName) --Returns a unique Dev Cst ID.
	local newCstID = this.CreateDevCst()
	if varName ~= nil then
		if this.DevCstFlow == nil then this.DevCstFlow = {} end
		this.DevCstFlow[varName] = newCstID
	end
	return newCstID
end
function this.DevFlow(varName) --Uses DevCst entry to find DevFlow index 
	if this.DevCstFlow ~= nil and next( this.DevCstFlow) then
		if this.DevCstFlow[varName] ~= nil then return ZetaUtil.GetIndex(this.DevCstFlow[varName], ZetaEquipDevelopConstSetting.equipDevTableCst, "p00") - 1 end 
	end
	return ZetaUtil.GetIndex(this.EQP(varName), ZetaEquipDevelopConstSetting.equipDevTableCst, "p01") - 1 --No var name? Must have already been created. Use EQP ID!
end
function this.WP(varName)return this.Enum(TppEquip,"WP",varName)end --Weapon
function this.RC(varName)return this.Enum(TppEquip,"RC",varName)end --Receiver
function this.BA(varName)return this.Enum(TppEquip,"BA",varName)end --Barrel
function this.AM(varName)return this.Enum(TppEquip,"AM",varName)end --Ammo
function this.SK(varName)return this.Enum(TppEquip,"SK",varName)end --Stock
function this.MZ(varName)return this.Enum(TppEquip,"MZ",varName)end --Muzzle
function this.MO(varName)return this.Enum(TppEquip,"MO",varName)end --Muzzle Option
function this.ST(varName)return this.Enum(TppEquip,"ST",varName)end --Sight
function this.UB(varName)return this.Enum(TppEquip,"UB",varName)end --Underbarrel
function this.BL(varName)return this.Enum(TppEquip,"BL",varName)end --Bullet
function this.ATK(varName)return this.Enum(TppDamage,"ATK",varName)end --Attack
function this.BuddyQuiet(varName)return this.Enum(this.globalVars,"BuddyQuiet",varName)end --Quiet
function this.BuddyDog(varName)return this.Enum(this.globalVars,"BuddyDog",varName)end --Dog
function this.BuddyHorse(varName)return this.Enum(this.globalVars,"BuddyHorse",varName)end --Horse
function this.BuddyWalker(varName)return this.Enum(this.globalVars,"BuddyWalker",varName)end --Walker

return this