--ZetaVar.lua
--Description: Has functions for certain Zeta settings, handling SVars, and variables meant to be kept between soft reloads.
local this={
	ZSvars = {}, --Zeta Saved Variables
	SanityChecks = {}, --Table to sanity check functions
	globalVars = {}, --Global vars between Zeta mods
	defaultValues = {}, --Keep default values for Ivars
}
--Zeta General Settings
function this.IsZetaActive() return ( this.Ivar({ivar=ZetaDef.settingsName.."ZetaActive",default=1,evars=true}) > 0 ) end
function this.IsProtectingFOB() return ( this.Ivar({ivar=ZetaDef.settingsName.."UseZetaInFOB",default=0,evars=true}) < 1 ) end
function this.IsProtectingFOBChimeras() return ( this.Ivar({ivar=ZetaDef.settingsName.."UseCustomizedWeaponsInFOB",default=0,evars=true}) < 1 ) end
function this.IsZetaInDevMode() return ( this.Ivar({ivar=ZetaDef.settingsName.."InDevMode",default=0,evars=true}) > 0 ) end
--Zeta Saved Variables
function this.DevCst(varName) return this.ZSvar({var="DevCst."..varName,val=ZetaEquipDevelopConstSetting.CreateUniqueID()}) end --Returns a saved unique Dev Cst ID.
function this.EQP(varName) return this.ZSvar({var="EQP."..varName,val=this.Enum(TppEquip,"EQP_"..varName,{"EQP"},"EQP")}) end --Returns a saved unique Equip ID
function this.UniqueStaffID(varName) return this.ZSvar({var="UniqueStaff."..varName,val=ZetaMbmCommonSetting.CreateUniqueID(varName)}) end --Returns a saved unique staff ID
--Zeta Enums
function this.WP(varName)return this.Enum(TppEquip,"WP_"..varName,{"WP"})end --Weapon
function this.RC(varName)return this.Enum(TppEquip,"RC_"..varName,{"RC"})end --Receiver
function this.BA(varName)return this.Enum(TppEquip,"BA_"..varName,{"BA"})end --Barrel
function this.AM(varName)return this.Enum(TppEquip,"AM_"..varName,{"AM"})end --Ammo
function this.SK(varName)return this.Enum(TppEquip,"SK_"..varName,{"SK"})end --Stock
function this.MZ(varName)return this.Enum(TppEquip,"MZ_"..varName,{"MZ"})end --Muzzle
function this.MO(varName)return this.Enum(TppEquip,"MO_"..varName,{"MO"})end --Muzzle Option
function this.ST(varName)return this.Enum(TppEquip,"ST_"..varName,{"ST"})end --Sight
function this.LT(varName)return this.Enum(TppEquip,"LT_"..varName,{"LT","LS"})end --Flashlights
function this.LS(varName)return this.Enum(TppEquip,"LS_"..varName,{"LT","LS"})end --Lasersights
function this.UB(varName)return this.Enum(TppEquip,"UB_"..varName,{"UB"})end --Underbarrel
function this.BL(varName)return this.Enum(TppEquip,"BL_"..varName,{"BL"})end --Bullet
function this.ATK(varName)return this.Enum(TppDamage,"ATK_"..varName,{"ATK"})end --Attack
function this.DevFlow(varName) --Dev Flow
	local devIndex = ZetaUtil.GetIndex({index = ZetaEquipDevelopConstSetting.equipDevTableCst,targets=this.DevCst(varName),selectors="p00"}) 
	if devIndex ~= nil then return devIndex-1 end
	return nil
end 
function this.RCSB(rcId) return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsBase,3) end --receiverParamSetsBase
function this.RCSW(rcId) return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsWobbling,4) end --receiverParamSetsWobbling
function this.RCSSys(rcId) return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsSystem,5) end --receiverParamSetsSystem
function this.RCSSound(rcId) return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsSound,6) end --receiverParamSetsSound
function this.BAS(baId) return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.barrel,targets=baId},ZetaEquipParameters.equipParameters.barrelParamSetsBase,2) end --barrelParamSetsBase
function this.BuddyQuiet(varName)return this.Enum(this.globalVars,varName,{"BuddyQuiet"})end --Quiet Var
function this.BuddyDog(varName)return this.Enum(this.globalVars,varName,{"BuddyDog"})end --Dog Var
function this.BuddyHorse(varName)return this.Enum(this.globalVars,varName,{"BuddyHorse"})end --Horse Var
function this.BuddyWalker(varName)return this.Enum(this.globalVars,varName,{"BuddyWalker"})end --Walker Var

--Zeta IVars
--ivar: The defined variable for the Ivar
--evars: If no ivars are found, fallback to Evars
--get: Returns Ivar instead of value if set to false.
--default: The default value for the Ivar
function this.Ivar(params)
	if Ivars ~= nil then --Checks ivars for settings
		local modValue = Ivars[params.ivar]
		if params.get == false then return modValue end
		if modValue ~= nil then return modValue:Get() end
	end
	if params.evars == true then --Check for evars as fallback
		if evars ~= nil then
			local modValue = evars[params.ivar]
			if modValue ~= nil then return modValue end
		end
	end
	return this.defaultValues[params.ivar] or params.default or 0 --If all else fails, use default value provided or 0
end
--zetaModule: The Zeta module itself
--optionName: The defined variable for the Ivar
--params: 
---default: The default value for the Ivar
---get: Returns Ivar instead of value if set to false.
function this.GetModIvar(zetaModule, optionName, params)  
	local newParams = params or {}
	newParams.ivar=ZetaDef.customSettingsName..zetaModule.zetaUniqueName..optionName --Zeta unique option name
	newParams.evars=true
	return this.Ivar(newParams) 
end
--TPP SVars
--Purpose: Useful for mission specific save variables. 
function this.ReloadSvars()
	local newSVars = {}	
	if ( ZetaVar.IsZetaActive() == true ) then newSVars = ZetaIndex.ModTables("DeclareSVars", this) end
	return TppSequence.MakeSVarsTable(newSVars)
end
--TPP Enums
--Purpose: Retrieves unique IDs for various enumerations.
function this.Enum(enumTable,varName,enumPrefixes,enumZSvar)
    local newEnum = enumTable[varName] 
    if newEnum ~= nil then return newEnum end
    local lastValue = -1
    for k,v in pairs(enumTable)do --Look for last value
		if enumPrefixes ~= nil and next(enumPrefixes) then --Enum has multiple prefixes.
			for i,varType in ipairs(enumPrefixes)do
				local subString = string.sub(k,1,string.len(varType))
				if subString == varType then
					if lastValue < v then lastValue = v end
				end 
			end
		elseif lastValue < v then lastValue = v end --If there's no prefixes, check the enums highest value
    end
    enumTable[varName] = lastValue + 1 --After last value found
	if enumZSvar ~= nil then --If it's a ZSVar, try to find a unique ID 
		while( this.HasZSvarInTable(enumZSvar,enumTable[varName]) == true ) do enumTable[varName] = enumTable[varName] + 1 end
	end
	if this.IsZetaInDevMode() == true then ZetaCore.Log(enumTable[varName],{"ZetaVar",varName},false) end
    return enumTable[varName] 
end
--ZetaSvars
--Purpose: Keeps Zeta Svars separate from IVars
function this.ExportZetaSvars()
	local svarModule = ZetaUtil.ImportFileAsTable({fileName = ZetaDef.modSvarSave,})
	if svarModule ~= nil and next(svarModule) then 
		ZetaUtil.ExportTableToFile{ --Exported previously saved ZetaSvars as PrevZetaSvars
			fileName = ZetaDef.modPrevSvarSave,
			filePurpose = "Contains previously saved variables for Zeta mods.",
			fileVars = svarModule,
		}
	end
	ZetaUtil.ExportTableToFile{ --Saves current ZetaSvar
		fileName = ZetaDef.modSvarSave,
		filePurpose = "Contains saved variables for Zeta mods.",
		fileVars = this.ZSvars,
	}
	ZetaCore.Log("Exported "..ZetaDef.modSvarSave,"ZetaVar",false) 	
end
function this.ImportZetaSvars()--Imports current Svars
	local svarModule = ZetaUtil.ImportFileAsTable({fileName = ZetaDef.modSvarSave,})
	if svarModule ~= nil and next(svarModule) then this.ZSvars = svarModule end
	ZetaCore.Log("Imported "..ZetaDef.modSvarSave,"ZetaVar",false) 	
end
function this.ZSvar(params) --Get or set ZSvar
	local loadedZSvar = ZetaUtil.StringToTable(params.var, this.ZSvars) --Find ZSvar
	if loadedZSvar ~= nil then --Found ZSvar? Don't overwrite it.
		if type(loadedZSvar) ~= "table" or next(loadedZSvar) then return loadedZSvar end--Always return ZSVars if it isn't a table. Only return tables if they have any entries
	end 
	if params.val ~= nil then return ZetaUtil.StringToTable(params.var, this.ZSvars, params.val) end --No ZSvar? Save one if we have a value
	return nil
end
function this.HasZSvarInTable(svarName, svarVal)
	local svarsTable = ZetaUtil.StringToTable(svarName, this.ZSvars) --Find ZSvar
	if svarsTable ~= nil and next(svarsTable) then --Found ZSvar? Don't overwrite it.
		for name,val in pairs(svarsTable)do
			if val == svarVal then return true end
		end
	end
	return false
end
--Zeta Sanity Checks for ZSvars 
--Purpose: If any ZSvars are obsolete, certain player preferences must be reset.
--New items and staff don't trigger sanity checks as the player hasn't had the chance to select them.
--This is done to prevent any crashes, infinite loads, or bugs.
function this.StartSanityCheck(params)
	local newZSVars = {}
	if this.ZSvars ~= nil and next(this.ZSvars) then
		if this.ZSvars[params.id] ~= nil and next(this.ZSvars[params.id]) then
			for key,val in pairs(this.ZSvars[params.id]) do 
				if params.contains(val) == true then newZSVars[key] = val --If it contains the key, keep it.
				elseif this.SanityChecks[params.id] == nil and params.reset ~= nil then this.SanityChecks[params.id] = params.reset end --Add sanity check func 
			end
		end
	end
	this.ZSvars[params.id] = newZSVars --Set new ZSvars that remove the old ones.
end
function this.EndSanityChecks() --Saves corrected MB data, returns to ACC
	if this.SanityChecks ~= nil and next(this.SanityChecks) then
		ZetaCore.Log("Running Sanity Checks","ZetaVar",false) 	
		for key,val in pairs(this.SanityChecks) do val() end
		this.SanityChecks = {} --Reset sanity checks
		ZetaCore.Log("Removing obsolete ZSvars...","ZetaVar",false) 	
		ZetaCore.Log("Returning to ACC...","ZetaVar",false) 	
		ZetaCore.Log("Saving game config...","ZetaVar",false) 	
		TppSave.VarSaveMbMangement() --Saves certain vars
		TppSave.VarSave(40050,true) --Motherbase's ACC
		TppSave.VarSaveOnRetry() 
		TppSave.SaveGameData()
		InfMain.abortToAcc = true
	end
end
--Zeta Global Vars
function this.GetVar(varname)
	if this.globalVars ~= nil and next(this.globalVars) then
		if this.globalVars[varname] ~= nil then return this.globalVars[varname] end
	end
	return nil
end
return this