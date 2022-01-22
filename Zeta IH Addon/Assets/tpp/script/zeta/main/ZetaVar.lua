--ZetaVar.lua
local this={}
this.Vars = {} --Keep Mod Vars safe through reloads

function this.GetVar(varname)
	local vars = this.Vars
	if vars ~= nil and next(vars) then
		if vars[varname] ~= nil then
			return vars[varname]
		end
	end
	return nil
end

function this.ReloadSvars()
	local orderedList = {}	
	if ( ZetaVar.AreAllModsEnabled() == true ) then
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

this.settingsVarName = "ZetaSetting"
function this.IsProtectingDevFlow()
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[this.settingsVarName.."DevFlowProtection"]
		if modValue ~= nil then
			if modValue:Get() > 0 then
				return true
			end
		end
	end
	return false
end

function this.AreAllModsEnabled()
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[this.settingsVarName.."SetAllMods"]
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
		local modValue = Ivars[this.settingsVarName.."FOBProtection"]
		if modValue ~= nil then
			if modValue:Get() > 0 then
				return true
			end
		end
	end
	return false
end

return this