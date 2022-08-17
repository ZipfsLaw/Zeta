--ZetaVar.lua
--Description: Has functions for certain Zeta settings, handling SVars, and variables meant to be kept between soft reloads.
local this={
	Vars = {}, --Keep Mod Vars safe through reloads
	settingsVarName = "ZetaSetting",
}

--Persistent Vars
function this.GetVar(varname)
	local vars = this.Vars
	if vars ~= nil and next(vars) then
		if vars[varname] ~= nil then
			return vars[varname]
		end
	end
	return nil
end

--Zeta IVars
--selIvar: The defined variable for the Ivar
--default: The default value for the Ivar
--useEvars: If no ivars are found, fallback to Evars
function this.GetIvar(selIvar,default,useEvars)
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[selIvar]
		if modValue ~= nil then
			return modValue:Get()
		end
	end
	
	--Check for evars as fallback
	if useEvars == true then
		if evars ~= nil then
			local modValue = evars[selIvar]
			if modValue ~= nil then
				return modValue
			end
		end
	end
	
	--If all else fails, use default value provided
	if default ~= nil then
		return default
	end
	return 0
end
--modInfo: The Zeta module itself
--optionName: The defined variable for the Ivar
--default: The default value for the Ivar
--altHelp: The English string for the mod menu's description
--subMenu: If defined, will look into the submenu
function this.GetModIvar(modInfo, optionName, default, subMenu)
	local itemName = "ZetaCustomSetting"..modInfo.zetaUniqueName..optionName
	if subMenu ~= nil then 
		itemName = "ZetaCustomSetting"..modInfo.zetaUniqueName..subMenu..optionName
	end
	return this.GetIvar(itemName, default)
end

--SVars
function this.ReloadSvars()
	local orderedList = {}	
	if ( ZetaVar.IsZetaActive() == true ) then
		local newSVars = ZetaIndex.SafeGet("DeclareSVars", this) 
		if newSVars ~= nil and next(newSVars) then
			for x,svarList in ipairs(newSVars)do
				if svarList ~= nil and next(svarList) then
					for y,modSvars in ipairs(svarList)do
						table.insert( orderedList, modSvars )
					end
				end
			end		
		end
	end
	return TppSequence.MakeSVarsTable(orderedList)
end

--Zeta General Settings
function this.IsZetaActive()
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[this.settingsVarName.."ZetaActive"]
		if modValue ~= nil then
			if modValue:Get() > 0 then
				return true
			end
		end
	end
	return false
end

function this.IsProtectingDevFlow()
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[this.settingsVarName.."AcquireUpdates"]
		if modValue ~= nil then
			if modValue:Get() > 0 then
				return true
			end
		end
	end
	return false
end

function this.IsProtectingFOB()
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[this.settingsVarName.."UseZetaInFOB"]
		if modValue ~= nil then
			if modValue:Get() < 1 then
				return true
			end
		end
	end
	return false
end

function this.IsProtectingFOBChimeras()
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[this.settingsVarName.."UseCustomizedWeaponsInFOB"]
		if modValue ~= nil then
			if modValue:Get() < 1 then
				return true
			end
		end
	end
	return false
end

return this