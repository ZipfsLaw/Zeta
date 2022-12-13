--ZetaVar.lua
--Description: Has functions for certain Zeta settings, handling SVars, and variables meant to be kept between soft reloads.
local this={
	globalVars = {}, --Global vars between Zeta mods
	ZSvars = {}, --Zeta Saved Variables
	SanityChecks = {} --Contain flags for what to reset
}
--Zeta General Settings
function this.IsZetaActive() return ( this.Ivar({ivar=ZetaDef.settingsName.."ZetaActive",default=1,evars=true}) > 0 ) end
function this.IsProtectingFOB() return ( this.Ivar({ivar=ZetaDef.settingsName.."UseZetaInFOB",default=0,evars=true}) < 1 ) end
function this.IsProtectingFOBChimeras() return ( this.Ivar({ivar=ZetaDef.settingsName.."UseCustomizedWeaponsInFOB",default=0,evars=true}) < 1 ) end
--Zeta Saved Variables
function this.DevCst(varName) return this.ZSvar({var="Dev."..varName..".Cst",val=ZetaEquipDevelopConstSetting.CreateUniqueID()}) end --Returns a saved unique Dev Cst ID.
function this.DevFlow(varName) return this.ZSvar({var="Dev."..varName..".Flw",val=ZetaEquipDevelopFlowSetting.CreateUniqueID()}) end  --Returns a saved Dev Flow index
function this.UniqueStaffID(varName) return this.ZSvar({var="UniqueStaff"..varName,val=ZetaMbmCommonSetting.CreateUniqueID(varName)}) end --Returns a saved unique staff ID
--Zeta Weapon Enums
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
function this.EQP(varName)return this.Enum(TppEquip,"EQP",varName)end --Equip ID
--Zeta Paramset
function this.RCSB(rcId)  
	return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsBase,3)
end --Receiver
function this.RCSW(rcId) 
	return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsWobbling,4)
end --Receiver
function this.RCSSys(rcId) 
	return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsSystem,5)
end --Receiver
function this.RCSSound(rcId) 
	return ZetaUtil.GetParamSetIndex({index=ZetaEquipParameters.equipParameters.receiver,targets=rcId},ZetaEquipParameters.equipParameters.receiverParamSetsSound,6)
end --Receiver
--Unused/WIP Enums
function this.BuddyQuiet(varName)return this.Enum(this.globalVars,"BuddyQuiet",varName)end --Quiet
function this.BuddyDog(varName)return this.Enum(this.globalVars,"BuddyDog",varName)end --Dog
function this.BuddyHorse(varName)return this.Enum(this.globalVars,"BuddyHorse",varName)end --Horse
function this.BuddyWalker(varName)return this.Enum(this.globalVars,"BuddyWalker",varName)end --Walker

--Zeta IVars
--ivar: The defined variable for the Ivar
--default: The default value for the Ivar
--evars: If no ivars are found, fallback to Evars
--get: Returns Ivar instead of value if set to false.
function this.Ivar(params)
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
--params: 
---default: The default value for the Ivar
---get: Returns Ivar instead of value if set to false.
function this.GetModIvar(zetaModule, optionName, params)  
	local newParams = params
	if params ~= nil then newParams = {} end
	newParams.ivar=ZetaDef.customSettingsName..zetaModule.zetaUniqueName..optionName --Zeta unique option name
	newParams.evars=true
	return this.Ivar(newParams) 
end
--TPP SVars
function this.ReloadSvars()
	local newSVars = {}	
	if ( ZetaVar.IsZetaActive() == true ) then newSVars = ZetaIndex.ModTables("DeclareSVars", this) end
	return TppSequence.MakeSVarsTable(newSVars)
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
--ZetaSvars
--Purpose: Keeps Zeta Svars separate from IVars
function this.Update() --Purpose: Anytime TPP saves data, ZSVars are exported.
	if this.ZSvars ~= nil and next(this.ZSvars) then --Should be loaded first.
		if TppSave.IsSaving() == true then this.ZSvarsState = true elseif this.ZSvarsState == true then --If it was loading/saving, but no longer is, export and reset ZSVar state.
			this.ExportZetaSvars()
			this.ZSvarsState = nil
		end
	end
end
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
		fileVars = this.ZSvars,
	})
	InfCore.Log( "["..ZetaDef.modName.."][ZetaVar] Exported ZetaSvar.lua",false,true)
end
function this.ImportZetaSvars()--Imports current Svars
	local svarModule = ZetaUtil.ImportFileAsTable({fileName = "ZetaSvar.lua",})
	if svarModule ~= nil and next(svarModule) then this.ZSvars = svarModule end
	InfCore.Log( "["..ZetaDef.modName.."][ZetaVar] Imported ZetaSvar.lua",false,true)
end
function this.ZSvar(params) --Get or set ZSvar
	local loadedZSvar = ZetaUtil.StringToTable(params.var, this.ZSvars) --Find ZSvar
	if loadedZSvar ~= nil then --Found ZSvar? Don't overwrite it.
		if type(loadedZSvar) ~= "table" or next(loadedZSvar) then return loadedZSvar end--Always return ZSVars if it isn't a table. Only return tables if they have any entries
	end 
	if params.val ~= nil then return ZetaUtil.StringToTable(params.var, this.ZSvars, params.val) end --No ZSvar? Save one if we have a value
	return nil
end
--Zeta Sanity Checks for ZSvars 
--Purpose: If any ZSvars are obsolete, certain player preferences must have to be reset.
--New items and staff don't trigger sanity checks as the player hasn't had the choice to select them.
--This is done to prevent any crashes, infinite loads, or bugs.
function this.StartSanityCheck(params)
	local newZSVars = {}
	if ZetaVar.ZSvars ~= nil and next(ZetaVar.ZSvars) then
		if ZetaVar.ZSvars[params.id] ~= nil and next(ZetaVar.ZSvars[params.id]) then
			for key,val in pairs(ZetaVar.ZSvars[params.id]) do 
				local newVal = val
				if params.subId ~= nil then newVal = val[params.subId] end --Use a parameter within it instead.
				if params.contains(newVal) == true then newZSVars[key] = val --If it contains the key, keep it.
				elseif this.SanityChecks[params.id] == nil then this.SanityChecks[params.id] = params.reset end --Add sanity check func 
			end
		end
	end
	this.ZSvars[params.id] = newZSVars --Set new ZSvars that remove the old ones.
end
function this.EndSanityChecks()
	if this.SanityChecks ~= nil and next(this.SanityChecks) then
		InfCore.Log("["..ZetaDef.modName.."][ZetaVar] Running Sanity Checks",false,true)	
		for key,val in pairs(this.SanityChecks) do val() end
		this.SanityChecks = {} --Reset sanity checks
		--Saves corrected MB data, returns to ACC
		InfCore.Log("["..ZetaDef.modName.."][ZetaVar] Some ZSVars are obsolete!",false,true)
		InfCore.Log("["..ZetaDef.modName.."][ZetaVar] Returning to ACC...",false,true)
		InfCore.Log("["..ZetaDef.modName.."][ZetaVar] Saving game config...",false,true)	
		TppSave.VarSaveMbMangement()
		TppSave.VarSave(40050,true)
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