--ZetaVar.lua
--Description: Has functions for certain Zeta settings, handling SVars, and variables meant to be kept between soft reloads.
local this={
	globalVars = {}, --Global vars between Zeta mods
	ZSvar = {},
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
--ivar: The defined variable for the Ivar
--default: The default value for the Ivar
--evars: If no ivars are found, fallback to Evars
--get: Returns Ivar instead of value if set to false.
function this.GetIvar(params)
	if Ivars ~= nil then --Checks ivars for settings
		local modValue = Ivars[params.ivar]
		if modValue ~= nil then 
			if params.get == false then return modValue end
			return modValue:Get() 
		end
	end
	if params.evars == true then --Check for evars as fallback
		if evars ~= nil then
			local modValue = evars[params.ivar]
			if modValue ~= nil then return modValue end
		end
	end
	if params.default ~= nil then return params.default end --If all else fails, use default value provided
	return 0
end
--zetaModule: The Zeta module itself
--optionName: The defined variable for the Ivar
--default: The default value for the Ivar
--get: Returns Ivar instead of value if set to false.
function this.ModOptionName(zetaModule, optionName) return ZetaDef.customSettingsName..zetaModule.zetaUniqueName..optionName end
function this.GetModIvar(zetaModule, optionName, defaultVal, getBool) return 
	this.GetIvar({ivar=this.ModOptionName(zetaModule, optionName),default=defaultVal,get=getBool}) 
end

--SVars
function this.ReloadSvars()
	local newSVars = {}	
	if ( ZetaVar.IsZetaActive() == true ) then newSVars = ZetaIndex.ModTables("DeclareSVars", this) end
	return TppSequence.MakeSVarsTable(newSVars)
end

--Zeta General Settings
function this.IsZetaActive() return ( this.GetIvar({ivar=ZetaDef.settingsName.."ZetaActive",default=1,evars=true}) > 0 ) end
function this.IsProtectingDevFlow() return ( this.GetIvar({ivar=ZetaDef.settingsName.."AcquireUpdates",default=1,evars=true}) > 0 ) end
function this.IsProtectingFOB() return ( this.GetIvar({ivar=ZetaDef.settingsName.."UseZetaInFOB",default=0,evars=true}) < 1 ) end
function this.IsProtectingFOBChimeras() return ( this.GetIvar({ivar=ZetaDef.settingsName.."UseCustomizedWeaponsInFOB",default=0,evars=true}) < 1 ) end

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
function this.EQP(varName)return this.Enum(TppEquip,"EQP",varName)end
function this.CreateDevCst()
	local startID = 52000 --Start at 52000. Otherwise, it could potentially mess up the order of weapons.
	for cstID=startID,65534,1 do --Up to 65534 since we'll definitely find a unique dev cst ID
		if ZetaEquipDevelopConstSetting.ContainsID(cstID) == false then --If it's unique, use it. 
			this.lastCstID = cstID + 1 --Add one so the next cst ID doesn't start on an already used ID
			return cstID --Return unique Dst Const ID
		end
	end
	return startID --If all else fails, use the next possible ID
end
function this.DevCst(varName) --Returns a unique Dev Cst ID.
	local svarName = "DevCst"..varName
	if this.ZSvar ~= nil and next(this.ZSvar) then --Use saved DevCst
		if this.ZSvar[svarName] ~= nil then return this.ZSvar[svarName] end 
	end
	this.ZSvar[svarName] = this.CreateDevCst() --No saved Cst ID? Create one.
	return this.ZSvar[svarName]
end
function this.DevFlow(varName) --Uses DevCst entry to find DevFlow index 
	local svarName = "DevCst"..varName
	if this.ZSvar ~= nil and next(this.ZSvar) then --Use saved DevCst
		if this.ZSvar[svarName] ~= nil then return ZetaUtil.GetIndex(this.ZSvar[svarName], ZetaEquipDevelopConstSetting.equipDevTableCst, "p00") - 1 end 
	end
	return ZetaUtil.GetIndex(this.EQP(varName), ZetaEquipDevelopConstSetting.equipDevTableCst, "p01") - 1 --No var name? Must have already been created. Use EQP ID!
end
--ZetaSvars
--Purpose: Keeps Zeta Svars separate from IVars
function this.ExportZetaSvars()
	local svarModule = ZetaUtil.ImportFileAsTable({fileName = "ZetaSvar.lua",})
	if svarModule ~= nil and next(svarModule) then 
		ZetaUtil.ExportTableToFile({ --Exported previously saved ZetaSvars as PrevZetaSvars
			fileName = "PrevZetaSvar.lua",
			filePurpose = "Contains previously saved variables for Zeta mods.",
			fileVars = svarModule,
		})
	end
	ZetaUtil.ExportTableToFile({ --Saves current ZetaSvar
		fileName = "ZetaSvar.lua",
		filePurpose = "Contains saved variables for Zeta mods.",
		fileVars = this.ZSvar,
	})
end
function this.ImportZetaSvars()--Imports current Svars
	local svarModule = ZetaUtil.ImportFileAsTable({fileName = "ZetaSvar.lua",})
	if svarModule ~= nil and next(svarModule) then this.ZSvar = svarModule end
end
return this