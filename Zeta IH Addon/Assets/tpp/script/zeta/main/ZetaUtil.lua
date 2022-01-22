--ZetaUtil.lua
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

--Returns the highest ID, useful for creating new IDs
function this.GetHighestIndex( indexTable, parameter )
	local highestId = 0
	local highestEqpID = 0
	for i,indexOf in pairs(indexTable) do 
		if this.IsIndexUsable(indexOf) then
			local value = this.GetElement(indexOf, parameter)
			if value > highestEqpID then
				highestId = i
				highestEqpID = value
			end
		end
	end
	return { index = highestId, id = highestEqpID }
end

--Orders table, so highest ID is at top
function this.GetGreatestValue( indexTable, parameter )
	if indexTable ~= nil then
		local newParam = 1
		if parameter ~= nil then newParam = parameter end		
		local newTable = this.CopyFrom(indexTable)
		if type(newTable[1]) ~= "table" then table.remove(newTable,1) end		
		table.sort(newTable, function(a, b) return a[newParam] > b[newParam] end)
		return newTable[1][newParam]
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
	local isTable = false
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

--Returns index of inserted element
function this.InsertElement(table, entry)
	local recvTotal = table.maxn(table)
	table.insert(table, entry )
	return recvTotal 
end

--Copy elements
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

--Returns indexes of modified and additional entries
--Return nil when no changes are found
function this.MergeTables(t1, t2)
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

function this.CloneEntryFromDevFlow(devFlowTable)
	local newTable = {}
	for i,index in ipairs(devFlowTable) do 
		table.insert( newTable, {p50=index[1],p51=index[2],p52=index[3],p53=index[4],p54=index[5],p55=index[6],p56=index[7],p57=index[8],p58=index[9],p59=index[10],p60=index[11],p61=index[12],p62=index[13],p63=index[14],p64=index[15],p65=index[16],p66=index[17],p67=index[18],p68=index[19],p69=index[20],p70=index[21],p71=index[22],p72=index[23],p73=index[24],p74=index[25]})
	end
	return newTable
end

function this.CloneEntryFromDevConst(devConstTable)
	local newTable = {}
	for i,index in ipairs(devConstTable) do 
		table.insert( newTable, {p00=index[1],p01=index[2],p02=index[3],p03=index[4],p04=index[5],p05=index[6],p06=index[7],p07=index[8],p08=index[9],p09=index[10],p10=index[11],p30=index[12],p31=index[13],p32=index[14],p33=index[15],p34=index[16],p35=index[17],p36=index[18]})
	end
	return newTable
end

return this