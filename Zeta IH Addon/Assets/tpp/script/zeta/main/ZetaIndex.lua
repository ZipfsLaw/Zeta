--ZetaIndex.lua
--Description: Indexes lua files in modDir, gathers their mod information, organizes their load order, and whether or not they're enabled
local this={
	modDir = "zeta",
	luaModsFiles = {},
	luaMods = {},
	loadorder = {},
	enabledMods = {},
	modInfos = {},
}
local InfCore=InfCore
local InfMain=InfMain
local InfUtil=InfUtil
local ZetaCore=ZetaCore

--Mod Manager
function this.LoadAllModFiles(forceAllMods)
	this.luaModsFiles = {}
	this.luaMods = {}
	this.loadorder = {}
	this.enabledMods = {}
	this.modInfos = {}

	--load lua files when we need them.
	if this.luaModsFiles == nil or not next(this.luaModsFiles) then
		local tempModFiles=InfCore.GetFileList(InfCore.files[this.modDir],".lua")	
		if tempModFiles == nil or not next(tempModFiles) then
			return nil
		end
		for i,fileName in ipairs(tempModFiles)do 
			this.AddModInfo(fileName)
		end
	end

	--If forceAllMods is false, only load mod information
	if forceAllMods == false then return nil end
	
	--Load any mod that returns
	if this.luaModsFiles ~= nil and next(this.luaModsFiles) then	
		if this.luaMods == nil or not next(this.luaMods) then
			--Load mods in order
			if this.loadorder ~= nil and next(this.loadorder) then
				for x,order in ipairs(this.loadorder)do 
					if order ~= nil and next(order) then
						for y,fileName in ipairs(order)do 
							if fileName ~= nil then
								if forceAllMods == true or this.IsModEnabled(fileName) > 0 then
									this.AddLuaMod(fileName)
								end
							end
						end
					end
				end
			end	
		end
	end
end

function this.AddLuaMod(fileName)
	local module=InfCore.LoadSimpleModule(InfCore.paths[this.modDir],fileName)
	if module==nil then
		InfCore.Log(ZetaCore.modName..": "..fileName.." can not be loaded. Check the file for errors!",true,true)
	else
		module.zetaUniqueName = InfUtil.StripExt(fileName) --Add a unique name variable
		table.insert(this.luaMods,module)
	end
end

function this.AddModInfo(fileName)
	local module=InfCore.LoadSimpleModule(InfCore.paths[this.modDir],fileName)
	if module~=nil then
		local isModEnabled = 1 --1 is enabled. 0 is disabled.
		local isModDisabledByDefault = module.modDisabledByDefault
		if isModDisabledByDefault ~= nil then 
			if isModDisabledByDefault == true then isModEnabled = 0 end 
		end

		--Mod Enabled, Mod name, description, categories, authors, and if disabled by default
		local newModInfo = {
			fileName = fileName,
			zetaUniqueName = InfUtil.StripExt(fileName),
			modName = module.modName,
			modDesc = module.modDesc,
			modCategory = module.modCategory,
			modAuthor = module.modAuthor,
			modDisabledByDefault = isModDisabledByDefault,
			isZetaModule = module.isZetaModule,
		}
		if newModInfo ~= nil and next(newModInfo) then table.insert(this.modInfos,newModInfo) end

		--Checks ivars for settings
		if Ivars ~= nil then
			local modName = InfUtil.StripExt(fileName)
			local modValue = Ivars["Zeta"..modName]
			local modLoadOrder = Ivars["ZetaOrder"..modName]		
			--Mod Toggle
			if modValue ~= nil then
				if modValue:Get() > 0 then
					this.SetModEnabled( fileName, modValue:Get() ) 
				end
			else
				this.SetModEnabled( fileName, isModEnabled )
			end
			--Load Order
			if modLoadOrder ~= nil then
				if modLoadOrder:Get() > 0 then
					this.SetModLoadOrder( fileName, modLoadOrder:Get(), isZetaModule ) 
				end
			else
				this.SetModLoadOrder( fileName, 1, isZetaModule )
			end
		end
	
		--Keep files listed by themselves
		table.insert(this.luaModsFiles, fileName)
	end--if module
end

--Returns module based on filename provided
function this.GetModInfo(fileName)
	if fileName ~= nil then
		if this.modInfos ~= nil and next(this.modInfos) then
			for i,file in ipairs(this.modInfos)do 
				if file ~= nil then
					if file.fileName == fileName then
						return { 
							modName = file.modName, 
							modDesc = file.modDesc, 
							modCategory = file.modCategory, 
							modAuthor = file.modAuthor,
							modDisabledByDefault = file.modDisabledByDefault 
						}
					end
				end
			end
		end
	end
	return nil
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
			--If it exists, check if it needs to be removed
			if set <= 0 then
				if this.enabledMods ~= nil and next(this.enabledMods) then
					table.remove(this.enabledMods, eMIndex )
				end
			end
		elseif set >= 1 then
			--If it doesn't, check if it should be added
			table.insert(this.enabledMods, fileName )
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

--Allow mods to init their own functions. Pass through the file calling it as gamemodule
function this.ModFunction(funcName,...)
	if this.luaMods ~= nil and next(this.luaMods) then
		for i,luaMod in ipairs(this.luaMods)do   
			if luaMod==nil then
				InfCore.Log(ZetaCore.modName..": "..funcName.." can not be loaded. Check the file for errors!",true,true)
			elseif luaMod[funcName] ~= nil then
				local success,result = pcall(luaMod[funcName],...)
				if success == false then InfCore.Log(ZetaCore.modName..": "..funcName.."<>"..result,true,true) end	
			end
		end
	end
end
function this.SafeFuncInGame(funcName,...)
	if vars.missionCode<=5 then return nil end	
	if InfMain ~= nil then
		if InfMain.IsOnlineMission(vars.missionCode)then
			return nil
		end
	end	
	this.ModFunction(funcName,...)
end
function this.ModGet(funcName,...)
	local retTab = {}
	if this.luaMods ~= nil and next(this.luaMods) then
		for i,luaMod in ipairs(this.luaMods)do   
			if luaMod==nil then
				InfCore.Log(ZetaCore.modName..": "..funcName.." can not be loaded. Check the file for errors!",true,true)
			elseif luaMod[funcName] ~= nil then
				local success,result = pcall(luaMod[funcName],...)
				if success == false then InfCore.Log(ZetaCore.modName.." Error: "..funcName,true,true)
				elseif result ~= nil then table.insert( retTab, result ) end --Add return values to table, combine later
			end
		end
	end	
	return retTab
end
function this.ModGetWithModules(funcName,...)
	local retTab = {}
	if this.luaMods ~= nil and next(this.luaMods) then
		for i,luaMod in ipairs(this.luaMods)do   
			if luaMod==nil then
				InfCore.Log(ZetaCore.modName..": "..funcName.." can not be loaded. Check the file for errors!",true,true)
			elseif luaMod[funcName] ~= nil then
				local success,result = pcall(luaMod[funcName],...)
				if success == false then 
					InfCore.Log(ZetaCore.modName.." Error: "..funcName,true,true)				
				elseif result ~= nil then 
					local newEntry = { 
						results = result, 
						module = luaMod,
					}
					table.insert( retTab,newEntry ) 
				end
			end
		end
	end	
	return retTab
end
function this.ModCount(funcName)
	local retCount = 0
	if this.luaMods ~= nil and next(this.luaMods) then
		for i,luaMod in ipairs(this.luaMods)do   
			if luaMod==nil then
				InfCore.Log(this.debugModName..": "..funcName.." can not be loaded. Check the file for errors!",true,true)
			elseif luaMod[funcName] ~= nil then
				retCount = retCount + 1
			end
		end
	end	
	return retCount
end
function this.SafeCount(funcName)
	local success,result = pcall(this.ModCount,funcName)
	if success == true then 
		return result
	end	
	return nil
end

return this