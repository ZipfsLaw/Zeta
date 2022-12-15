--ZetaUtil.lua
--Description: Adds functions that help index lua tables.
local this={}
--Purpose: Indexes elements of tables using the selecting parameter(s), which is often an ID or string
--index: Table to find targets in
--targets: Identifying parameter(s), or table containing keys with identifying parameter(s)
--selectors: Keys containing selecting parameter(s)
function this.GetIndex( params )
	for i,index in pairs(params.index) do
		if this.IsIndexUsable(index) then
			local foundElement = this.GetElement(index, params.selectors)
			if foundElement ~= nil then
				if this.DoesIndexMatch( foundElement, params.targets ) then return i end
			end
		end
	end
	return nil--Error
end
--Purpose: Checks if table entry can be indexed
function this.IsIndexUsable( key )
	if key == nil then return false end --Nil key, or table format that might have nothing
	local tempKey = key
	local typeKey = type(tempKey)
	if typeKey == "table" then
		if tempKey == {} or tempKey == {""} then return false end	
		return true
	end	
	if typeKey == "number" then 
		if tempKey<=1 then return false end 
	end
	if typeKey == "string" then 
		if tempKey == "" then return false end 		
	end
	return true
end
--Purpose: Compares indexing parameter(s)
function this.DoesIndexMatch( ids, targets )
	if ids==targets then return true end
	if type(ids) == "string" and type(targets) == "string" then 
		if string.match( ids, targets ) then return true end 
	end
	if type(ids) == "table" and type(targets) == "table" then
		if next(ids) and next(targets) then
			for x,id in pairs(ids)do
				local foundCondition = false
				for y,target in pairs(targets)do
					if x == y then
						if this.DoesIndexMatch( id, target ) == true then foundCondition = true end
					end
				end
				if foundCondition == false then return false end
			end
			return true
		end
	end
	return false
end
--Purpose: Gets indexing parameter(s)
function this.GetElement(entry,selectors)
	if type(entry) == "table" then 
		if selectors ~= nil then
			if type(selectors) == "table" then 
				if next(selectors) then
					local ret = {}
					for i,selector in ipairs(selectors)do 
						if entry[selector] ~= nil then ret[selector] = entry[selector] end
					end
					return ret
				end
			elseif entry[selectors] ~= nil then return entry[selectors] end
		end
		if entry[1] ~= nil then return entry[1] end
	end
	return entry
end
--Table Merging
--Purpose: Merges tables based on unique parameters, or IDs.
function this.MergeTables( oldTables, newTables, firstIndex )
	if newTables ~= nil and next(newTables) then
		local newIndex = 1
		if firstIndex ~= nil then newIndex = firstIndex end
		for i,subTables in ipairs(newTables) do --Tables returned by all mods
			if subTables ~= nil and next(subTables) then
				if this.isArray(subTables) then --Merge a single table
					if newIndex == true then oldTables = this.MergeTablesByIndex(oldTables, subTables) --If true, then merge by index
					else oldTables = this.MergeTablesByParameter(oldTables, subTables, newIndex) end --Otherwise, merge based on params
				else --Merge multiple tables ( with multiple indentifying parameters )
					for key,newTable in pairs(subTables)do
						if newTable ~= nil and next(newTable) then
							if oldTables[key] ~= nil and next(oldTables[key]) then
								local keyIndex = newIndex
								if type(keyIndex) == "table" then
									if next(keyIndex) then 
										if keyIndex[key] ~= nil then keyIndex = newIndex[key] end 
									end
								end
								if keyIndex == true then oldTables[key] = this.MergeTablesByIndex(oldTables[key], newTable) --If true, then merge by key
								else oldTables[key] = this.MergeTablesByParameter(oldTables[key], newTable, keyIndex) end --Otherwise, merge based on params
							end
						end
					end
				end
			end
		end
	end
	return oldTables
end
function this.MergeTablesByParameter(oldTable, newTable, firstIndex)
	if oldTable ~= nil and next(oldTable) and newTable ~= nil and next(newTable) then
		for x,subTable in pairs(newTable) do --Parameter tables
			if subTable ~= nil then
				if type(subTable) == "table" then --Make sure its a table
					if next(subTable) then
						local id = subTable["sIndex"] --Look for "sIndex" for manual indexing. If one is found, use it. Otherwise, find indentifying param.
						if id ~= nil then subTable["sIndex"] = nil else id = this.GetIndex({index=oldTable,targets=subTable,selectors=firstIndex}) end
						if id ~= nil and oldTable[id] ~= nil then --If ID is nil and entry in table is nil, skip
							for y,value in pairs(subTable) do --Values in a table
								if value ~= nil then oldTable[id][y] = value end --Don't update if nil value
							end
						else table.insert(oldTable,subTable) end --Add entries if unfound
					end
				end
			end
		end
	end
	return oldTable
end
function this.MergeTablesByIndex(t1, t2) --Merges based on keys
	for k, v in pairs(t2) do
		if type(v) == 'table' then t1[k] = this.MergeTablesByIndex(t1[k], t2[k]) else t1[k] = v end
	end
	return t1
end
--Purpose: Returns indexes of modified and additional entries
function this.CompareIndexes(t1, t2)
	local linesChanges = {} --Compare lines found in both tables
	if t1 ~= nil and t2 ~= nil then
		for i,index in ipairs(t1) do
			local lineChanged = false
			if i > #t2 then lineChanged = true
			else
				for key,value in pairs(index) do 
					local opp = t2[i][key]
					if opp ~= nil then
						if value ~= opp then lineChanged = true end
					end
				end
			end		
			if lineChanged == true then table.insert(linesChanges,i) end
		end
	end	
	if #t1 < #t2 then --Add additional lines if new table is bigger
		for i=#t1+1,#t2,1 do table.insert(linesChanges,i) end
	end
	if linesChanges ~= nil and next(linesChanges) then return linesChanges end	
	return nil --Return nil when no changes are found
end
--Usage: Remove keys from entries of a table
--tbl: Table to trim
--inc: Table contain strings matching keys
function this.TrimTables(tbl, inc)
	local newTables = {}
	for x, w in ipairs(tbl) do
		for k, v in pairs(w) do
			for y, z in ipairs(inc) do
				if k == z then newTables[k] = v end
			end
		end
	end
	return newTables
end

function this.RemoveDuplicates(tbl, reverse)
    local newTable = {}
	if tbl ~= nil and next(tbl) then
		local hasEntry = {} --Keeps track of unique entries
		local processEntry = function(entry)
			if entry ~= nil then
				if hasEntry[entry] == nil then
					hasEntry[entry] = 1
					table.insert(newTable, entry)
				end
			end
		end
		if reverse == true then --Descending order
			for i=1,#tbl,1 do processEntry( tbl[i] ) end 
		else --Ascending order
			for i, entry in ipairs(tbl) do processEntry(entry) end
		end 
	end
    return newTable
end
--Param Lookup Utils
function this.GetParamSetIndex(params,targetTable,firstIndex)  
	local indexOf = ZetaUtil.GetIndex(params)
	if indexOf ~= nil then
		local indexSet = params.index[indexOf] 
		if indexSet ~= nil and next(indexSet) then 
			local indexParams = indexSet[firstIndex]
			if indexParams ~= nil then return indexParams+1 end
		end
	end
	return #targetTable --If all else fails, add to index
end
function this.VarsToTable(funcVars,selVars)
	local ret={}
	local i = 0
	while( vars[funcVars][i] ~= nil )do
		ret[i] = vars[funcVars][i]
		if selVars ~= nil then
			local newVal = selVars
			if type(selVars) == "table" then
				if next(selVars)then newVal = selVars[i] end
			end
			vars[funcVars][i] = newVal
		end
		i=i+1
	end
	return ret
end
--Purpose: Retrieves entry from a table using another table entry.
--search: Table to search for indexing param
--target: Table to get entry with indexing param
--index: The index of the param to return
--copy: Copies index to add manual index 
function this.GetEntryFromTable(params)
    if params ~= nil and next(params) then
        if params.search ~= nil and params.target ~= nil then
			local newSourceTable = params.search --Index search table.
			if params.index ~= nil then newSourceTable = params.search[params.index] end
			if params.copy == true then
				if type(newSourceTable) == "number" then
					local copyOfOppIndex = this.CopyFrom(params.target[newSourceTable+1])
					if copyOfOppIndex ~= nil then 
						table.insert(copyOfOppIndex, 1, newSourceTable)
						return copyOfOppIndex 
					end
				end
			else
				local indexOfParam = this.GetIndex({index=params.target,targets=newSourceTable,})
				if indexOfParam ~= nil then return params.target[indexOfParam] end
			end
        end
    end
    return {} --Return empty table
end
--String Utils
function this.firstToLower(str) return (str:gsub("^%u", string.lower)) end --Lowercases first letter of string if its upper
function this.firstToUpper(str) return (str:gsub("^%l", string.upper)) end --Uppercases first letter of string if its lower
function this.GetAltStrings(str) --Provides a list of alt strings to iterate through.
	local altStrings = {
		str, --Use the key first,
		this.firstToLower(str), --First letter lowercase ( TestKey -> testKey )
		this.firstToUpper(str), --First letter uppercase ( testKey -> TestKey )
		string.lower(str), --All letters lowercase ( TestKey -> testkey )
		string.upper(str), --All letters uppercase ( TestKey -> TESTKEY )
	}
	return altStrings
end
--Purpose: Creates nested tables, sets values
--keyNames: A string that can be broken up into tables ( splits at '.' )
--parentTable: Root table to create nested tables within.
--set: Sets the value for the latest table returned.
function this.StringToTable(keyNames, parentTable, set)
	if parentTable == nil then parentTable = {} end
	if type(keyNames) == "string" then --Is this still a string? Split it.
		return this.StringToTable(InfCore.Split(keyNames,"."), parentTable, set) 
	end 
	local tab = keyNames[1] --Get first key in table
	if parentTable[tab] == nil then parentTable[tab] = {} end --Create tables
	if #keyNames == 1 and set ~= nil then parentTable[tab] = set end --Set the last table
	table.remove(keyNames,1) --Remove from keyNames
	if keyNames ~= nil and next(keyNames) then --Are there more tables? 
		return this.StringToTable(keyNames, parentTable[tab], set) 
	end
	return parentTable[tab] --Return value
end
--Purpose: Exports tables to string
--tvars: Tables to export to.
--tabs: Keeps track of tabbed characters
--ret: Table to add strings to.
function this.TableToString(tvars, tabs, ret)
	for tvar,tval in pairs(tvars)do 
		if type(tval) == "table" then
			ret[#ret+1] = tabs..tvar.."={"
			this.TableToString(tval,tabs.."\t",ret)
			ret[#ret+1] = tabs.."},"
		else ret[#ret+1] = tabs..tvar.."="..tval.."," end
	end
end
--Purpose: Exports tables as lua modules to the ZetaGen folder
--fileName: The lua file name you wish to save it as
--filePurpose: The comment describing what the purpose of it is.
--fileVars: The table that is meant to be exported.
function this.ExportTableToFile(params)
	if params == nil then return nil end 
    local ret = {
        "--"..params.fileName,
		"--Purpose: "..params.filePurpose,
        "return {",
    }
	this.TableToString(params.fileVars,"\t",ret)
    ret[#ret+1] = "}"
    local fileName=InfCore.paths[ZetaDef.modDevFolder].."/"..ZetaDef.modGenFolder.."/"..params.fileName
    InfCore.WriteStringTable(fileName,ret) 
end
--Purpose: Imports loadable moadules as tables from the ZetaGen folder.
--fileName: The lua file name you wish to import.
function this.ImportFileAsTable(params)
	if params == nil then return nil end 
	local svarModule=InfCore.LoadSimpleModule(InfCore.paths[ZetaDef.modDevFolder]..ZetaDef.modGenFolder.."/",params.fileName)
	return svarModule
end
--Parts Utils
--Purpose: Player and Buddy parts
function this.SetupParts(curType, infosTable, init )
	for i, bVar in ipairs(infosTable) do
		if bVar.var ~= nil then 
			if init == true then curType[bVar.id] = nil
			else curType[bVar.id] = vars[bVar.var] end
		end
	end
end
function this.GetPartValue( entry, key, index ) --Provides fallbacks for key name
	if key ~= nil then
		local altKeys = this.GetAltStrings(key) 
		for i, altKey in ipairs(altKeys) do --Iterate through alt versions of the key
			if altKey ~= nil then 
				if entry[altKey] ~= nil then return entry[altKey] end
			end 
		end
	end
	return entry[index] --If all else fails, return index
end
function this.HasPartChanged(curType, infosTable)
	for i, bVar in ipairs(infosTable) do
		if bVar.var ~= nil then
			if curType[bVar.id] ~= vars[bVar.var] then return true end
		end
	end
	return false
end
--NMC
--https://stackoverflow.com/a/6080274
function this.isArray(t)
	local i = 0
	for _ in pairs(t) do
		i = i + 1
		if t[i] == nil then return false end
	end
	return true
end
--https://gist.github.com/cpeosphoros/0aa286c6b39c1e452d9aa15d7537ac95
function this.CopyFrom(value, cache, promises, copies)
	cache    = cache    or {}
	promises = promises or {}
	copies   = copies   or {}
	local copy
    if type(value) == 'table' then
		if(cache[value]) then
			copy = cache[value]
		else
			promises[value] = promises[value] or {}
			copy = {}
			for k, v in next, value, nil do
				local nKey   = promises[k] or this.CopyFrom(k, cache, promises, copies)
				local nValue = promises[v] or this.CopyFrom(v, cache, promises, copies)
				copies[nKey]   = type(k) == "table" and k or nil
				copies[nValue] = type(v) == "table" and v or nil
				copy[nKey] = nValue
			end
			local mt = getmetatable(value)
			if mt then
				setmetatable(copy, mt.__immutable and mt or this.CopyFrom(mt, cache, promises, copies))
			end
			cache[value]    = copy
		end
    else -- number, string, boolean, etc
        copy = value
    end
	for k, v in pairs(copies) do
		if k == cache[v] then
			copies[k] = nil
		end
	end
	local function correctRec(tbl)
		if type(tbl) ~= "table" then return tbl end
		if copies[tbl] and cache[copies[tbl]] then
			return cache[copies[tbl]]
		end
		local new = {}
		for k, v in pairs(tbl) do
			local oldK = k
			k, v = correctRec(k), correctRec(v)
			if k ~= oldK then
				tbl[oldK] = nil
				new[k] = v
			else
				tbl[k] = v
			end
		end
		for k, v in pairs(new) do
			tbl[k] = v
		end
		return tbl
	end
	correctRec(copy)
    return copy
end
return this