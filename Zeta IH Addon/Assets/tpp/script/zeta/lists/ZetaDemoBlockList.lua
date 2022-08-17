--ZetaDemoBlockList.lua
local this={}

--Load block list for that mission/sequence
function this.LoadBlocklist( id )
	--Get every demo block modification and concat the requested mods
	local orderedList = {}
	local newSequences =  ZetaIndex.SafeGet("LoadDemoBlock", this)
	if newSequences ~= nil and next(newSequences) then
		for x,fpkPathList in ipairs(newSequences)do
			if fpkPathList ~= nil and next(fpkPathList) then
				for y,fpkPath in ipairs(fpkPathList)do
					if id == fpkPath[1] then --Demo lua script/Only add the requested ID
						local demoSeq = fpkPath[2] --Sequence in demoBlockList 
						local demoFpk = fpkPath[3] --Demo FPK of sequence
						
						--Init order list categories
						if orderedList[demoSeq] == nil then orderedList[demoSeq] = {} end		

						--Add FPK path for sequence
						if type(demoFpk) == "table" then
							if next(demoFpk) then
								for z,fpkSubPath in ipairs(demoFpk)do
									table.insert(orderedList[demoSeq], fpkSubPath )
								end
							end
						else
							table.insert(orderedList[demoSeq], demoFpk )
						end
					end
				end	
			end
		end		
	end
	
	if orderedList ~= nil and next(orderedList) then
		local newTable = {}
		for seqKey,seqValue in pairs(orderedList)do
			if newTable[seqKey] == nil then newTable[seqKey] = {} end
			for i,fpkPath in ipairs(seqValue)do 
				table.insert( newTable[seqKey], fpkPath ) 
			end 
		end
		return newTable --Reset modified demo blocklist
	end
	return {} --Return an empty table if no modifications
end

--TppScriptBlock.OnAllocate loads demoBlockList
local demoBlock = "demo_block"
function this.OnAllocate(missionTable)
	local missionCode = vars.missionCode
	if missionCode >= 5 then
		if missionTable ~= nil then
			local newBlocklist = this.LoadBlocklist( missionCode )
			if newBlocklist ~= nil and next(newBlocklist) then
				if missionTable.demo ~= nil and missionTable.demo.demoBlockList ~= nil then 
					--Rebuild demo block pack list
					local newPaths = {}
					for packName,packPaths in pairs(newBlocklist)do
						newPaths[packName]=packPaths
					end
					
					--Combine mod fpks with vanilla fpk lists
					local demoPacks = mvars.sbl_scriptBlockPackList[demoBlock]
					for packName,packPaths in pairs(demoPacks)do
						if newPaths[packName] ~= nil then
							for i,demoPackPaths in ipairs(packPaths)do
								table.insert( newPaths[packName], demoPackPaths )
							end
						else
							newPaths[packName] = packPaths
						end
					end				
					mvars.sbl_scriptBlockPackList[demoBlock]=newPaths
					mvars.sbl_scriptBlockStrCode32PackList[demoBlock]={}
				end
			end
		end
	end
end

return this