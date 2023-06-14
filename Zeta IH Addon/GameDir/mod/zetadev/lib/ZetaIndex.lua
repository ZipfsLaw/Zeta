--ZetaIndex.lua
--Description: Indexes lua files, gathers their mod information, organizes their load order, and whether or not they're enabled
local this={
	luaModsFiles = {},
	luaMods = {},
	loadOrder = {},
	enabledMods = {},
	blockRebuilding = false,
}
local InfCore=InfCore
local InfMain=InfMain
local InfUtil=InfUtil
local ZetaCore=ZetaCore

--Mod Manager
--Purpose: Loads all lua files in the "MGS_TPP\mod\zeta" folder, registers them in order.
--toggle: If false, all mods are disabled regardless of settings.
--refreshFileList: If true, will refresh file list. If false, any newly created files won't be indexed.
--reloadFiles: If true, will reload all zeta modules. If false, will skip loading zeta modules.
function this.RebuildIndex(indexParams)
	if this.blockRebuilding == true then return nil end --Prevents rebuilding index when it's unnecessary ( ApplyProfiles )
	this.luaMods = {}
	this.loadOrder = {}
	this.enabledMods = {}
	if indexParams == nil then indexParams = {} end
	if ZetaVar.IsZetaActive() == false or indexParams.toggle == false then return nil end --When Zeta is disabled, or mods are disabled by force.
	if indexParams.reloadFiles ~= false then --Unless set false, it will always load Zeta modules.
		this.luaModsFiles = {} --Clear loaded modules if reloading
		InfCore.PCallDebug(InfCore.RefreshFileList) --Refresh file list before reloading mods
		local tempModFiles=InfCore.GetFileList(InfCore.files[ZetaDef.modFolder],".lua") --Retrieve all Zeta mods
		if tempModFiles ~= nil and next(tempModFiles) then 
			for i,fileName in ipairs(tempModFiles)do 
				local zetaModule=InfCore.LoadSimpleModule(InfCore.paths[ZetaDef.modFolder],fileName)
				if zetaModule~=nil then 
					zetaModule.zetaUniqueName = InfUtil.StripExt(fileName) --Keep fileName inside Zeta module.
					this.luaModsFiles[zetaModule.zetaUniqueName] = zetaModule --Added load module 
				else ZetaCore.Log(ZetaDef.errorLoadMsg,fileName) end --logged an error trying
			end 
		end
	end
	if this.luaModsFiles ~= nil and next(this.luaModsFiles) then --Load mods in proper order
		if this.luaMods == nil or not next(this.luaMods) then
			for fileName,zetaModule in pairs(this.luaModsFiles)do this.RegisterZetaModule(fileName,zetaModule,indexParams) end --Registers Zeta modules
			if this.luaMods ~= nil and next(this.luaMods) then
				if this.loadOrder ~= nil and next(this.loadOrder) then table.sort(this.luaMods, function(a,b) return this.GetModLoadOrder(a.zetaUniqueName) < this.GetModLoadOrder(b.zetaUniqueName) end) end --Sorts loaded modules by load order
			end
		end
	end
	if ZetaUI ~= nil then ZetaUI.ReloadMenu(false) end --Refresh menu items on reload as well
end
--Purpose: Loads module, sets up its Ivars, makes various adjustments, inserts loaded module into luaModfiles.
function this.RegisterZetaModule(fileName,zetaModule,indexParams) 
	if zetaModule~=nil then
		if zetaModule.modName == nil then zetaModule.modName = fileName end --Use file name as mod name if there isn't one.
		if zetaModule.modDesc == nil then zetaModule.modDesc = ZetaDef.settingOptionLabel..fileName end --If missing mod description.
		--Purpose: ZVars are IVars that keep the var names unique enough to avoid conflict
		if zetaModule.ZVar == nil then 
			zetaModule.ZVar = function(varName, params) 
				local curModule = zetaModule
				if params ~= nil then 
					if params.module ~= nil then curModule = params.module end --ZVar: Has additional param for another module
				end
				return ZetaVar.GetModIvar(curModule, varName, params) 
			end 
		end
		if zetaModule.ZetaModuleInit ~= nil then --Runs function when mod is loaded.
			if type(zetaModule.ZetaModuleInit) == "function" then zetaModule.ZetaModuleInit() end 
		end 
		local isModEnabled = 1 --1 is enabled. 0 is disabled.
		local modLoadOrder = zetaModule.modLoadOrder or 1 --Is set to 1 if no modLoadOrder is found.
		if zetaModule.modDisabledByDefault == true then isModEnabled = 0 end -- Some mods are not enabled by default.
		this.SetModEnabled( fileName, ZetaVar.Ivar{ivar=ZetaDef.modActiveName..fileName,default=isModEnabled,evars=true} ) --Mod Toggle
		this.SetModLoadOrder( fileName, ZetaVar.Ivar{ivar=ZetaDef.loadOrderName..fileName,default=modLoadOrder,evars=true}, zetaModule.isZetaModule ) --Load Order
		if indexParams.toggle == true or this.IsModEnabled(fileName) == true then table.insert(this.luaMods,zetaModule) end --Is this mod enabled or all mods forced enabled? 
	end
end
function this.SafeRebuildIndex(...) --Doesn't reload files if they've been loaded already
	if this.luaModsFiles == nil or not next(this.luaModsFiles) then this.RebuildIndex(...)end
end
--Purpose: These functions manage what mods are enabled in Zeta
function this.IsModEnabled(fileName)
	if fileName ~= nil then
		if this.enabledMods ~= nil and next(this.enabledMods) then return this.enabledMods[fileName] end
	end
	return false
end
function this.SetModEnabled(fileName, set )
	if fileName ~= nil then
		local isActive = true
		if set == 0 then isActive = false end
		this.enabledMods[fileName] = isActive
	end
end
--Purpose: These functions manage the execution order of mods
function this.GetModLoadOrder(fileName)
	if fileName ~= nil then
		if this.loadOrder ~= nil and next(this.loadOrder) and this.loadOrder[fileName] ~= nil then return this.loadOrder[fileName] end
	end
	return 0
end
function this.SetModLoadOrder(fileName, set, start)
	if fileName ~= nil then 
		local newOrder = set
		if start == true then newOrder = set - 1 end 
		this.loadOrder[fileName] = newOrder 
	end
end
--Purpose: Script callback functions for Zeta mods.
function this.ModCallback(params,...) 
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
function this.ModReturn(funcName,...) return this.ModCallback({exec=function(retVal) return retVal end,name=funcName},...) end --Purpose: Returns single value from all mods.
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