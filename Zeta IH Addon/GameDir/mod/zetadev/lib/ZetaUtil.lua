--ZetaUtil.lua
--Description: Adds functions that help index lua tables.
local this={
	activeCoroutines = {},
}
--Indexes elements of tables using the first parameter, which is often an ID or string
function this.GetIndex( id, indexTable, parameter )
	for i,index in pairs(indexTable) do --Ascending
		if this.IsIndexUsable(index) then
			if this.DoesIndexMatch( this.GetElement(index,parameter), id ) then return i end
		end
	end
	return nil--Error
end
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
function this.DoesIndexMatch( key, id )
	if key==id then return true end 	
	if type(key) == "string" then 
		if string.match( key, id ) then return true end 
	end
	return false
end
function this.GetElement(entry,parameter)
	if type(entry) == "table" then 
		if parameter ~= nil then
			if entry[parameter] ~= nil then return entry[parameter] end
		end
		if entry[1] ~= nil then return entry[1] end
	end
	return entry
end
--Table Merging
--Purpose: Merges tables based on unique parameters, or IDs.
function this.MergeParams( oldTables, newTables, hasSubTables, firstIndex )
	if newTables ~= nil and next(newTables) then
		local newIndex = 1
		if firstIndex ~= nil then newIndex = firstIndex end
		for i,subTables in ipairs(newTables) do --Tables returned by all mods
			if subTables ~= nil and next(subTables) then
				if hasSubTables == true then
					for key,newTable in pairs(subTables)do --Subtables
						if newTable ~= nil and next(newTable) then
							local keyIndex = newIndex
							if type(keyIndex) == "table" then
								if next(keyIndex) then 
									if keyIndex[key] ~= nil then keyIndex = newIndex[key] end 
								end
							end
							if oldTables[key] ~= nil and next(oldTables[key]) then
								if keyIndex == true then --If true, then merge by key
									oldTables[key] = this.MergeTables(oldTables[key], newTable)
								else --Otherwise, merge based on params
									oldTables[key] = this.SubMergeParams(oldTables[key], newTable, keyIndex)
								end
							end
						end
					end
				else --Parameter tables only
					oldTables = this.SubMergeParams(oldTables, subTables, newIndex) 
				end
			end
		end
	end
	return oldTables
end
function this.SubMergeParams(oldTable, newTable, firstIndex)
	if oldTable ~= nil and next(oldTable) and newTable ~= nil and next(newTable) then
		for x,subtable in pairs(newTable) do --Parameter tables --OLD:ipairs
			if subtable ~= nil then
				if type(subtable) == "table" then --Make sure its a table
					if next(subtable) then
						local foundEntry = false --In case we want to insert a new entry
						local id = subtable["index"] --Some tables lack IDs and keys, so we use the "Index" key
						if id ~= nil then firstIndex = "index" --If there's an index key, use it
						else id = this.GetIndex(subtable[firstIndex],oldTable,firstIndex) end
						if id ~= nil then --If ID is nil, skip
							for y,value in pairs(subtable) do --Values in a table
								if y ~= firstIndex then --Don't update ID index
									if value ~= nil then --Don't update if nil value
										if oldTable[id] ~= nil then
											--if oldTable[id][y] ~= nil then
											oldTable[id][y] = value
											foundEntry = true --Entry found, no need to insert a new one
											--end
										end
									end
								end
							end
						end
						if foundEntry == false then table.insert(oldTable,subtable) end --Add entries if unfound
					end
				end
			end
		end
	end
	return oldTable
end
function this.MergeAllTables(oldTables, newTables) --Purpose: Simple table merging. 
	if newTables ~= nil and next(newTables) then
		for i,subTables in ipairs(newTables) do --Tables returned by all mods
			if subTables ~= nil and next(subTables) then
				for k, v in pairs(newTables) do
					if type(v) == 'table' then oldTables[k] = this.MergeTables(oldTables[k], subTables[k]) else oldTables[k] = v end
				end
			end
		end
	end
	return oldTables
end
function this.MergeTables(t1, t2) --Merges based on keys
	for k, v in pairs(t2) do
		if type(v) == 'table' then t1[k] = this.MergeTables(t1[k], t2[k]) else t1[k] = v end
	end
	return t1
end
--Returns indexes of modified and additional entries
--Return nil when no changes are found
function this.CompareTables(t1, t2)
	local linesChanges = {}
	--Compare lines found in both tables
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
	--Add additional lines if new table is bigger
	if #t1 < #t2 then 
		for i=#t1+1,#t2,1 do table.insert(linesChanges,i) end
	end
	if linesChanges ~= nil and next(linesChanges) then return linesChanges end	
	return nil
end
--Deep table copy
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
--Coroutines
function this.Update()
    if this.activeCoroutines ~= nil and next(this.activeCoroutines) then
        local newCoroutines = {}
        for i,co in ipairs(this.activeCoroutines) do
            if coroutine.status(co)~="dead" then
                local ok,ret=coroutine.resume(co)
                if not ok then error(ret) end
                table.insert(newCoroutines, co) 
            end
        end
        this.activeCoroutines = newCoroutines
    end
end
--postFunction: Function that runs after delays
--numOfDelays: Number of delays between functions ( can be nil, replaced with 1 )
function this.AddDelayedFunction(postFunction, numOfDelays)
    if postFunction~= nil then
		local newNum = numOfDelays
		if newNum == nil then newNum = 1 end
        local newCo = function()
            for i=0,newNum,1 do coroutine.yield() end --Should likely exceed frame rate.
            postFunction() --Run function after delays
        end
        local co=coroutine.create(newCo)
        if co ~= nil then table.insert(this.activeCoroutines, co) end
    end
end
return this