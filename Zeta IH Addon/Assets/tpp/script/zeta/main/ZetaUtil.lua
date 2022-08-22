--ZetaUtil.lua
--Description: Adds functions that help index lua tables.
local this={}

--Indexes elements of tables using the first parameter, which is often an ID or string
function this.GetIndex( id, indexTable, parameter )
	for i,index in pairs(indexTable) do 
		if this.IsIndexUsable(index) then
			local value = this.GetElement(index,parameter)
			if this.DoesIndexMatch( value, id ) then 
				return i
			end
		end
	end
	return nil--Error
end
function this.IsIndexUsable( key )
	--Nil key, or table format that might have nothing
	if key == nil then 
		return false 
	end	
	
	local tempKey = key
	local typeKey = type(tempKey)
	if typeKey == "table" then
		if tempKey == {} or tempKey == {""} then 
			return false 
		end	

		return true
	end
	
	if typeKey == "number" then 
		if tempKey<=1 then 
			return false 
		end 
	end
	
	if typeKey == "string" then 
		if tempKey == "" then 
			return false 
		end 		
	end
	
	return true
end
function this.DoesIndexMatch( key, id )
	if key==id then 
		return true 
	end 
		
	if type(key) == "string" then 
		if string.match( key, id ) then 
			return true 
		end 
	end
	return false
end
function this.GetElement(entry,parameter)
	if type(entry) == "table" then 
		if parameter ~= nil then
			if entry[parameter] ~= nil then
				return entry[parameter]
			end
		end
		if entry[1] ~= nil then
			return entry[1] 
		end
	end
	return entry
end

--Table Merging
function this.MergeTables( oldTables, newTables, hasSubTables, firstIndex )
	if newTables ~= nil and next(newTables) then
		local tempIndex = 1
		if firstIndex ~= nil then tempIndex = firstIndex end
		for i,tables in ipairs(newTables) do --Tables returned by all mods
			if tables ~= nil and next(tables) then
				if hasSubTables == true then
					for key,table in pairs(tables)do --Subtables
						if table ~= nil and next(table) then
							if oldTables[key] ~= nil and next(oldTables[key]) then
								oldTables[key] = this.SubMergeTables(oldTables[key], table, tempIndex)
							end
						end
					end
				else --Parameter tables only
					oldTables = this.SubMergeTables(oldTables, tables, tempIndex) 
				end
			end
		end
	end
	return oldTables
end
function this.SubMergeTables(oldTable, newTable, firstIndex)
	if oldTable ~= nil and next(oldTable) and newTable ~= nil and next(newTable) then
		for x,subtable in ipairs(newTable) do --Parameter tables
			if subtable ~= nil then
				if type(subtable) == "table" then --Make sure its a table
					if next(subtable) then
						local id = subtable["index"] 
						if id ~= nil then firstIndex = "index" --If there's an index key, use it
						else id = this.GetIndex(subtable[firstIndex],oldTable,firstIndex) end
						if id ~= nil then --If ID is nil, skip
							for y,value in pairs(subtable) do --Values in a table
								if y ~= firstIndex then --Don't update ID index
									if value ~= nil then --Don't update if nil value
										if oldTable[id] ~= nil then
											if oldTable[id][y] ~= nil then
												oldTable[id][y] = value
											end
										end
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

--Returns indexes of modified and additional entries
--Return nil when no changes are found
function this.CompareTables(t1, t2)
	local linesChanges = {}
	
	--Compare lines found in both tables
	if t1 ~= nil and t2 ~= nil then
		for i,index in ipairs(t1) do
			local lineChanged = false
			if i > #t2 then
				lineChanged = true
			else
				for key,value in pairs(index) do 
					local opp = t2[i][key]
					if opp ~= nil then
						if value ~= opp then 
							lineChanged = true
						end
					end
				end
			end
			
			if lineChanged == true then 
				table.insert(linesChanges,i)
			end
		end
	end	
	--Add additional lines if new table is bigger
	if #t1 < #t2 then 
		for i=#t1+1,#t2,1 do
			table.insert(linesChanges,i)
		end
	end

	if linesChanges ~= nil and next(linesChanges) then
		return linesChanges
	end	
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

--String Utils

--Lowers first letter of string
function this.firstToLower(str)
    return (str:gsub("^%u", string.lower))
end

--Lowers first letter of string
function this.firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

return this