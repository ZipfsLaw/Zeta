--ZetaUtil.lua
--Description: Adds functions that help index lua tables.
local this={}
--Purpose: Indexes elements of tables using the selecting parameter(s), which is often an ID or string
--index: Table to find targets in
--targets: Identifying parameter(s), or table containing keys with identifying parameter(s)
--selectors: Keys containing selecting parameter(s)
function this.GetIndex( params )
	local targetElement = this.GetElement(params.targets, params.selectors) --Get parameters of target based on identifying parameter(s)
	if targetElement ~= nil then
		for i,index in pairs(params.index) do --Iterate through source to find target
			if this.IsIndexUsable(index) then --Is index entry valid? Can we compare/merge with it?
				local sourceElement = this.GetElement(index, params.selectors) --Get parameters of source based on identifying parameter(s)
				if sourceElement ~= nil then
					if this.DoesIndexMatch( sourceElement, targetElement, params.selectors ) then return i end --Compare found elements
				end
			end
		end
	end
	return nil--Error
end
--Purpose: Checks if table entry can be used for indexing
function this.IsIndexUsable( indexKey )
	if indexKey == nil then return false end --Nil key, or table format that might have nothing
	local typeKey = type(indexKey)
	if typeKey == "table" then
		if indexKey == {} or indexKey == {""} then return false end	
	elseif typeKey == "number" then 
		if indexKey<=1 then return false end 
	elseif typeKey == "string" then 
		if indexKey == "" then return false end 		
	end
	return true
end
--Purpose: Checks if two sets of parameter(s) match
function this.DoesIndexMatch( ids, targets, selectors )
	if ids==targets then return true end--Are the parameters equal?
	if selectors ~= nil and type(selectors) == "table" and next(selectors) then --Match multiple parameters based on specific keys ( selectors )
		for x,selector in pairs(selectors)do 
			if ids[selector] ~= nil and targets[selector] ~= nil then
				if this.DoesIndexMatch( ids[selector], targets[selector] ) == false then return false end --If either element is nil, it still won't match!
			end
		end
		return true
	end
	local idsTypeOf = type(ids) 
	local targetsTypeOf = type(targets) 
	if idsTypeOf == "string" and targetsTypeOf == "string" and string.match(ids,targets) then return true --Is there a partial string match? 
	elseif idsTypeOf == "table" and targetsTypeOf == "table" and next(ids) and next(targets) then --Multiple parameter matching, for matching tables of IDs
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
	return false
end
--Purpose: Get parameter(s) based on keys provided
function this.GetElement(entry,selectors)
	if type(entry) == "table" then 
		if selectors ~= nil then --Get elementes based on selector(s)
			if type(selectors) == "table" and next(selectors) then 
				local ret = {}
				for i,selector in ipairs(selectors)do 
					if entry[selector] ~= nil then ret[selector] = entry[selector] end
				end
				return ret --Return all values by selector(s)
			elseif entry[selectors] ~= nil then return entry[selectors] end --Return selectors index
		end
		if entry[1] ~= nil then return entry[1] end --Return first index
	end
	return entry --Return the entry itself
end
--Table Merging
--Purpose: Merges tables based on unique parameters, or IDs.
function this.MergeTables( oldTables, newTables, firstIndex )
	if newTables ~= nil and next(newTables) then
		local newIndex = firstIndex or 1 --If there's a firstIndex, use it instead.
		local hasNoSubTables = this.isArray(oldTables) --Does the table use keys?
		for i,subTables in ipairs(newTables) do --Tables returned by all mods
			if subTables ~= nil and next(subTables) then --Make sure those tables exist and contain entries
				if hasNoSubTables == true then oldTables = this.MergeTablesByParameter(oldTables, subTables, newIndex) else --Merge a single table			
					for key,newTable in pairs(subTables)do --Merge multiple tables ( with multiple indentifying parameters )
						if newTable ~= nil and next(newTable) then
							if oldTables[key] ~= nil and next(oldTables[key]) then
								local keyIndex = newIndex
								if type(keyIndex) == "table" and next(keyIndex) and keyIndex[key] ~= nil then keyIndex = newIndex[key] end 
								oldTables[key] = this.MergeTablesByParameter(oldTables[key], newTable, keyIndex) 
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
	if oldTable ~= nil and newTable ~= nil and next(oldTable) and next(newTable) then
		if firstIndex == true then return this.MergeTablesByIndex(oldTable, newTable) end --If firstIndex true, then merge by key
		for x,subTable in pairs(newTable) do --Otherwise, merge tables based on parameters
			if subTable ~= nil then
				if type(subTable) == "table" and next(subTable)  then --Make sure its a table
					--Merging options
					local id = subTable["sIndex"] --If set, will used the provided index instead of searching.
					local isInsert = subTable["sInsert"] --If set, will change how entries are inserted. 
					--Clear additional options before merging
					subTable["sIndex"] = nil 
					subTable["sInsert"] = nil
					--Inserting new entries
					local newTarget = subTable
					if isInsert ~= nil then 
						if type(isInsert) == "boolean" then
							if isInsert == false then table.insert(oldTable,1,subTable) --Insert new entry at start if false
							elseif isInsert == true then table.insert(oldTable,subTable) end --Insert new entry at end if true
							newTarget = nil --Skips merging
						else newTarget = isInsert end --If set to a number/string, it will find the index of the paramater in the table
					end 
					--Merging parameters
					if newTarget ~= nil then
						if id == nil then id = this.GetIndex{index=oldTable,targets=newTarget,selectors=firstIndex} end --Find indentifying param(s).
						if id == nil or oldTable[id] == nil then table.insert(oldTable,subTable) else --If no ID was found, insert new entry
							if isInsert ~= nil then table.insert(oldTable,id,subTable) else --Insert new entry at ID
								for y,value in pairs(subTable) do ----If no insert ID is found, replace values
									if this.IsKeyForIndexing(y,firstIndex) == false then --Don't replace keys used for indexing.
										if value ~= nil then oldTable[id][y] = value end --NOTE: Must overwrite all values.
									end
								end
							end 
						end 
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
function this.IsKeyForIndexing(index,firstIndexes)
	if index ~= nil then
		if type(firstIndexes) == "table" then
			for i,firstIndex in pairs(firstIndexes) do
				if firstIndex == index then return true end
			end
		elseif firstIndexes == index then return true end
	end
	return false
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
			if entry ~= nil and hasEntry[entry] == nil then
				hasEntry[entry] = 1
				table.insert(newTable, entry)
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
function this.VarsToTable(funcVars,selVars)
	local ret={}
	local i = 0
	while( vars[funcVars][i] ~= nil )do
		ret[i] = vars[funcVars][i]
		if selVars ~= nil then
			local newVal = selVars
			if type(selVars) == "table" and next(selVars)then newVal = selVars[i] end
			vars[funcVars][i] = newVal
		end
		i=i+1
	end
	return ret
end
--Purpose: Indexes a table using an entry from another table. 
--source: Table to search for indexing param. If left undefined, will index "Target" table instead.
--target: Table to get entry with indexing param
--index: The index of the param to return
--readonly: Isolates an entry from a table as not to modify it.
function this.GetEntryFromTable(params)
    if params ~= nil and next(params) and params.index ~= nil and params.target ~= nil and next(params.target) then
		local newIndex = params.index --If no source table is provided, get index from target table.
		if params.source ~= nil and next(params.source) then newIndex = params.source[params.index] end
		local indexOfParam = this.GetIndex{index=params.target,targets=newIndex,}
		if params.readonly == true then
			local copyOfOppIndex = this.CopyFrom(params.target[indexOfParam])
			if copyOfOppIndex ~= nil then return copyOfOppIndex end
		end 
		return params.target[indexOfParam] 
    end
    return {} --Return empty table
end
--Purpose: Gets the index of a param set.
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
--setValue: Sets the value for the latest table returned.
function this.StringToTable(keyNames, parentTable, setValue)
	if parentTable == nil then parentTable = {} end
	local tableNames = InfCore.Split(keyNames,".")
	local lastTable = nil
	for i,tableName in ipairs(tableNames) do 
		if lastTable == nil then lastTable = parentTable end
		if i == #tableNames and setValue ~= nil then lastTable[tableName]=setValue 
		elseif lastTable[tableName] == nil then lastTable[tableName]={} end
		lastTable=lastTable[tableName]
	end
	return lastTable --Return value
end
--Purpose: Exports tables to string
--tvars: Tables to export to.
--ret: Table to add strings to.
--tabs: Keeps track of tabbed characters
function this.TableToString(tvars, ret, tabs)
	for tvar,tval in pairs(tvars)do 
		if type(tvar) == "number" then tvar = "["..tvar.."]" end
		if type(tval) == "table" then 
			ret[#ret+1] = tabs..tvar.."={"
			this.TableToString(tval, ret, tabs.."\t") 
			ret[#ret+1] = tabs.."},"
		else 
			if tabs == "" then ret[#ret] = ret[#ret]..tvar.."="..tval.."," --No new lines.
			else ret[#ret+1] = tabs..tvar.."="..tval.."," end --New line per var
		end
	end
end
--Purpose: Exports tables as lua modules to the ZetaGen folder
--fileName: The lua file name you wish to save it as
--filePurpose: The comment describing what the purpose of it is.
--fileLocation: Where the lua file location is. By default, it checks "saves".
--fileVars: The table that is meant to be exported.
--fileMinified: If set to true, exports minified.
function this.ExportTableToFile(params)
	if params == nil then return nil end 
    local ret = {
        "--"..params.fileName,
		"--Purpose: "..params.filePurpose,
        "return {",
    }
	local fileTab = "\t"
	if fileMinified == true then fileTab = "" end
	this.TableToString(params.fileVars,ret,fileTab)
	if fileMinified == nil then ret[#ret+1] = "}" else ret[#ret] = ret[#ret].."}" end --If a file tab is set, remove newline
	local savePath = params.fileLocation or InfCore.paths.saves
    local fileName=savePath..params.fileName
    InfCore.WriteStringTable(fileName,ret) 
end
--Purpose: Imports loadable moadules as tables from the ZetaGen folder.
--fileName: The lua file name you wish to import.
--fileLocation: Where the lua file location is. By default, it checks "saves".
function this.ImportFileAsTable(params)
	if params == nil then return nil end 
	local svarModule=InfCore.LoadSimpleModule(params.fileLocation or InfCore.paths.saves,params.fileName)
	return svarModule
end
--Parts Utils
--Purpose: Player and Buddy parts
function this.SetupParts(curType, infosTable, init )
	if infosTable ~= nil and next(infosTable) and curType ~= nil then
		for i, bVar in ipairs(infosTable) do
			if bVar.var ~= nil then 
				if init == true then curType[bVar.id] = nil else curType[bVar.id] = vars[bVar.var] end
			end
		end
	end
end
function this.GetPartValue( entry, key, index ) --Provides fallbacks for key name
	if key ~= nil then
		local altKeys = this.GetAltStrings(key) 
		for i, altKey in ipairs(altKeys) do --Iterate through alt versions of the key
			if altKey ~= nil and entry[altKey] ~= nil then return entry[altKey] end
		end
	end
	if index == nil then return nil end --No index? Return nil
	return entry[index] --If all else fails, return index
end
function this.HasPartChanged(curType, infosTable)
	if infosTable ~= nil and next(infosTable) and curType ~= nil then
		for i, bVar in ipairs(infosTable) do
			if bVar.var ~= nil and curType[bVar.id] ~= vars[bVar.var] then return true end
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