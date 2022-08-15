--ZetaIndex.lua
--Description: Indexes lua files in modDir, gathers their mod information, organizes their load order, and whether or not they're enabled
local this={
	debugModName = "Zeta",
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
		InfCore.Log(this.debugModName..": "..fileName.." can not be loaded. Check the file for errors!",true,true)
	else
		module["zetaUniqueName"] = InfUtil.StripExt(fileName) --Add a unique name variable
		table.insert(this.luaMods,module)
	end--if module
end

function this.AddModInfo(fileName)
	--Additional mod info
	local isModEnabled = 1 --1 is enabled. 0 is disabled.
	local module=InfCore.LoadSimpleModule(InfCore.paths[this.modDir],fileName)
	if module~=nil then
		--Mod name, description, categories, authors, and if disabled by default
		local modName = module["modName"]
		local modDesc = module["modDesc"]
		local modCategory = module["modCategory"]
		local modAuthor = module["modAuthor"]
		local modDisabledByDefault = module["modDisabledByDefault"]
		local isZetaModule = module["isZetaModule"]

		local ret = {}
		if fileName ~= nil then ret["fileName"] = fileName end	
		if modName ~= nil then ret["modName"] = modName end	
		if modDesc ~= nil then ret["modDesc"] = modDesc end		
		if modCategory ~= nil then ret["modCategory"] = modCategory end	
		if modAuthor ~= nil then ret["modAuthor"] = modAuthor end			
		if modDisabledByDefault ~= nil then 
			if modDisabledByDefault == true then isModEnabled = 0 end 
			ret["modDisabledByDefault"] = modDisabledByDefault 
		end
		if isZetaModule ~= nil then ret["isZetaModule"] = isZetaModule end
		if ret ~= nil and next(ret) then 
			table.insert(this.modInfos,ret)
		end

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

function this.GetModInfo(fileName)
	if fileName ~= nil then
		if this.modInfos ~= nil and next(this.modInfos) then
			for i,file in ipairs(this.modInfos)do 
				if file ~= nil then
					if file["fileName"] == fileName then
						local ret = { 
							modName = file["modName"], 
							modDesc = file["modDesc"], 
							modCategory = file["modCategory"], 
							modAuthor = file["modAuthor"], 
							modDisabledByDefault = file["modDisabledByDefault"] 
						}
						return ret
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
								local ret = {x,y}
								return ret
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
				InfCore.Log(this.debugModName..": "..funcName.." can not be loaded. Check the file for errors!",true,true)
			elseif luaMod[funcName] ~= nil then
				pcall(luaMod[funcName],...)
				--InfCore.Log(this.debugModName..": "..funcName,true,true)
			end--if module
		end--for TTL files
	end
end
function this.ModGet(funcName,...)
	local retTab = {}
	if this.luaMods ~= nil and next(this.luaMods) then
		for i,luaMod in ipairs(this.luaMods)do   
			if luaMod==nil then
				InfCore.Log(this.debugModName..": "..funcName.." can not be loaded. Check the file for errors!",true,true)
			elseif luaMod[funcName] ~= nil then
				--Add return values to table, combine later
				local getValue = luaMod[funcName](...)
				if getValue ~= nil then table.insert( retTab, getValue ) end
			end--if module
		end--for TTL files
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
				--Add to count
				retCount = retCount + 1
			end--if module
		end--for TTL files
	end	
	return retCount
end

--Wrappers for mod calls
function this.SafeFunc(funcName,...)
	this.ModFunction(funcName,...)
end
function this.SafeFuncInGame(funcName,...)
	if vars.missionCode<=5 then
		return nil
	end	
	if InfMain ~= nil then
		if InfMain.IsOnlineMission(vars.missionCode)then
			return nil
		end
	end	
	this.ModFunction(funcName,...)
end
function this.SafeGet(funcName,...)
	local success,result = pcall(this.ModGet,funcName,...)
	if success == true then 
		return result
	end	
	return nil
end
function this.SafeForceFunc(funcName,...)
	this.LoadAllModFiles(true)
	this.ModFunction(funcName,...)
	this.LoadAllModFiles()
end
function this.SafeCount(funcName)
	local success,result = pcall(this.ModCount,funcName)
	if success == true then 
		return result
	end	
	return nil
end

return this