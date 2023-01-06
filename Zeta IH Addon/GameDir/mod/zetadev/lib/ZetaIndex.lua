--ZetaIndex.lua
--Description: Indexes lua files, gathers their mod information, organizes their load order, and whether or not they're enabled
local this={
	luaModsFiles = {},
	luaMods = {},
	loadorder = {},
	enabledMods = {},
}
local InfCore=InfCore
local InfMain=InfMain
local InfUtil=InfUtil
local ZetaCore=ZetaCore

--Mod Manager
--Purpose: Loads all lua files in the "MGS_TPP\mod\zeta" folder, registers them in order.
function this.LoadAllModFiles(forceAllMods)
	this.luaModsFiles = {}
	this.luaMods = {}
	this.loadorder = {}
	this.enabledMods = {}
	local tempModFiles=InfCore.GetFileList(InfCore.files[ZetaDef.modFolder],".lua") --Retrieve all Zeta mods
	if tempModFiles == nil or not next(tempModFiles) then return nil end --No files found? Stop here.
	for i,fileName in ipairs(tempModFiles)do this.LoadZetaModule(fileName) end --Loads Zeta module
	if forceAllMods == false then return nil end --If forceAllMods is false, only register zeta modules
	if this.luaModsFiles ~= nil and next(this.luaModsFiles) then --Load mods in proper order
		if this.luaMods == nil or not next(this.luaMods) then
			if this.loadorder ~= nil and next(this.loadorder) then
				for x,order in ipairs(this.loadorder)do 
					if order ~= nil and next(order) then
						for y,fileName in ipairs(order)do 
							if fileName ~= nil then
								if forceAllMods == true or this.IsModEnabled(fileName) > 0 then
									this.RegisterZetaModule(fileName) --Adds Zeta module in order
								end
							end
						end
					end
				end
			end	
		end
	end
end
--Purpose: Loads module, sets up its Ivars, makes various adjustments, inserts loaded module into luaModfiles.
function this.LoadZetaModule(fileName) 
	local zetaModule=InfCore.LoadSimpleModule(InfCore.paths[ZetaDef.modFolder],fileName)
	if zetaModule~=nil then
		zetaModule.zetaUniqueName = InfUtil.StripExt(fileName) --Keep fileName inside Zeta module.
		if zetaModule.modName == nil then zetaModule.modName = zetaModule.zetaUniqueName end --Use file name as mod name if there isn't one.
		if zetaModule.modDesc == nil then zetaModule.modDesc = ZetaDef.settingOptionLabel..zetaModule.zetaUniqueName end --If missing mod description.
		if zetaModule.ZVar == nil then --Purpose: Gets IVars more easily.
			zetaModule.ZVar = function(varName, params) 
				local curModule = zetaModule
				if params ~= nil then 
					if params.module ~= nil then curModule = params.module end --ZVar: Has additional param for another module
				end
				return ZetaVar.GetModIvar(curModule, varName, params) 
			end 
		end
		local isModEnabled = 1 --1 is enabled. 0 is disabled.
		local modLoadOrder = 1 --Is set to 1 if no modLoadOrder is found.
		if zetaModule.modDisabledByDefault == true then isModEnabled = 0 end -- Some mods are not enabled by default.
		if zetaModule.modLoadOrder == true then modLoadOrder = zetaModule.modLoadOrder end
		this.SetModEnabled( fileName, ZetaVar.Ivar({ivar=ZetaDef.modActiveName..zetaModule.zetaUniqueName,default=isModEnabled,evars=true}) ) --Mod Toggle
		this.SetModLoadOrder( fileName, ZetaVar.Ivar({ivar=ZetaDef.loadOrderName..zetaModule.zetaUniqueName,default=modLoadOrder,evars=true}), zetaModule.isZetaModule ) --Load Order
		this.luaModsFiles[fileName] = zetaModule --Added load module
	else ZetaCore.Log(ZetaDef.errorLoadMsg,fileName) end
end
---Purpose: Adds Zeta module based on given order.
function this.RegisterZetaModule(fileName) 
	local zetaModule = this.luaModsFiles[fileName] --Gets Zeta module that was loaded earlier.
	if zetaModule ~= nil then
		if zetaModule.modFunction ~= nil then --Runs function when mod is loaded.
			if type(zetaModule.modFunction) == "function" then zetaModule.modFunction() end 
		end 
		table.insert(this.luaMods,zetaModule) 
	end
end
function this.SafeLoadAllModFiles(...) --Doesn't reload files if they've been loaded already
	if this.luaModsFiles == nil or not next(this.luaModsFiles) then this.LoadAllModFiles(...)end
end
--Manages what mods run 
function this.IsModEnabled(fileName)
	if fileName ~= nil then
		if this.enabledMods ~= nil and next(this.enabledMods) then
			for i,mod in ipairs(this.enabledMods)do 
				if mod == fileName then
					return i
				end
			end
		end
	end
	return 0
end
function this.SetModEnabled(fileName, set )
	if fileName ~= nil then
		local eMIndex = this.IsModEnabled(fileName)
		if eMIndex > 0 then
			if set <= 0 then --If it exists, check if it needs to be removed
				if this.enabledMods ~= nil and next(this.enabledMods) then
					table.remove(this.enabledMods, eMIndex )
				end
			end
		elseif set >= 1 then
			table.insert(this.enabledMods, fileName ) --If it doesn't, check if it should be added
		end
	end
end
--Mod load order
function this.IsInOrder(fileName)
	if fileName ~= nil then
		if this.loadorder ~= nil and next(this.loadorder) then
			for x,order in ipairs(this.loadorder)do 
				if order ~= nil and next(order) then
					for y,mod in ipairs(order)do 
						if mod ~= nil then
							if mod==fileName then
								return {x,y}
							end
						end
					end
				end
			end
		end
	end
	return nil
end
function this.SetModLoadOrder(fileName, set, start)
	if fileName ~= nil then
		if this.loadorder[set] == nil then
			this.loadorder[set] = {}
		end		
		--Does it exist? Remove it first
		local mlIndex = this.IsInOrder(fileName)
		if mlIndex ~= nil then
			local order = mlIndex[1]
			local mod = mlIndex[2]			
			if this.loadorder ~= nil and next(this.loadorder) then
				table.remove(this.loadorder[order], mod )
			end
		end
		--Add if it's above zero
		if set > 0 then
			if start == true then
				table.insert(this.loadorder[set], 1, fileName )
			else
				table.insert(this.loadorder[set], fileName )
			end
		end
	end
end

--Callback functions
function this.ModCallback(params,...) --Purpose: Acts as the callback to Zeta mods
	local retVal = nil
	if params == nil then return nil end
	if params.exec ~= nil then retVal = params.exec(retVal) end --Inits value
	if this.luaMods ~= nil and next(this.luaMods) then
		for i,luaMod in ipairs(this.luaMods)do   
			if luaMod==nil then
				ZetaCore.Log(ZetaDef.errorLoadMsg,{"Error",params.name}) 
			elseif luaMod[params.name] ~= nil then
				local success,result = pcall(luaMod[params.name],...)
				if success == false then 
					local fullFunc = params.name
					if luaMod.zetaUniqueName ~= nil then fullFunc = luaMod.zetaUniqueName.."."..params.name end
					ZetaCore.Log(fullFunc,"Error") 
				elseif result ~= nil then 
					if params.exec ~= nil then retVal = params.exec(retVal, result, luaMod) end --Add return values to table, combine later
				end 
			end
		end
	end
	if retVal ~= nil then return retVal end --If there's value, return it.
end
function this.ModFunction(funcName,...) this.ModCallback({name=funcName},...) end --Purpose: Executes function in all Zeta mods.
function this.SafeFuncInGame(funcName,...) --Purpose: Safely executes function in all Zeta mods.
	if vars.missionCode<=5 then return nil end --Don't run if the game's just starting
	if ZetaVar ~= nil and ZetaMission ~= nil then --Are other libraries loaded?
		if ZetaVar.IsProtectingFOB() and ZetaMission.IsOnline() then return nil end --Don't run if Zeta's disabled for FOB
	end
	this.ModCallback({name=funcName},...)
end
function this.ModReturn(funcName,...) return this.ModCallback({name=funcName},...) end --Purpose: Returns single value from all mods.
function this.ModTables(funcName,...) --Purpose: Returns tables from all Zeta mods and sorts them out in a single table
	return this.ModCallback(
	{exec=function(retVal, result) 
		if retVal == nil then retVal = {} end
		if result ~= nil and next(result) then
			for i,entry in pairs(result)do table.insert( retVal, entry ) end	
		end 
		return retVal
	end,name=funcName},...) 
end
function this.ModGet(funcName,...) --Purpose: Returns tables from all Zeta mods
	return this.ModCallback({exec=function(retVal, result) 
		if retVal == nil then retVal = {} end
		if result ~= nil and next(result) then table.insert( retVal, result ) end
		return retVal
	end,name=funcName},...) 
end
function this.ModGetWithModules(funcName,...) --Purpose: return tables from all Zeta mods, as well as the module they come from.
	return this.ModCallback({exec=function(retVal, result, luaMod) 
		if retVal == nil then retVal = {} end
		if result ~= nil and next(result) then
			for i,entry in pairs(result)do table.insert( retVal, { results = entry, module = luaMod } )  end	
		end 
		return retVal
	end,name=funcName},...) 
end
function this.ModFuncCount(funcName,...) --Purpose: Counting how many mods have a specific function.
	return this.ModCallback({exec=function(retVal, result) 
		if retVal == nil then retVal = 0 end
		return retVal + 1 
	end,name=funcName},...) 
end
return this