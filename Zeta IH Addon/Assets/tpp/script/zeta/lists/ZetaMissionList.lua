--ZetaMissionList.lua
local ZetaMissionList={}

function ZetaMissionList.Reload()	
	--Reload mission pack table with mods
	ZetaMissionList.missionPackTable = {}
	ZetaMissionList.allMissionsPackTable = {}
	local orderedList = {}
	
	--Reload fpks from zeta mods
	local newMissionFunctions = ZetaIndex.SafeGet("AddMissionPacksTop", ZetaMissionList)
	for x,newMissionPaths in ipairs(newMissionFunctions)do
		if newMissionPaths ~= nil and next(newMissionPaths) then
			for y,missionPack in ipairs(newMissionPaths)do
				local mission = missionPack[1] --Demo lua script
				local missionFunc = missionPack[2] --Demo FPK of sequence
				if missionFunc ~= nil then
					--Init order list categories
					local newMission = mission --If nil, apply to all missions
					if newMission == nil then newMission = "ALL" end					
					if orderedList[newMission] == nil then orderedList[newMission] = {} end	
					local typeOfFunc = type(missionFunc)
					if typeOfFunc == "table" then
						if next(missionFunc) then
							for z,fpkPath in ipairs(missionFunc)do
								table.insert(orderedList[newMission], fpkPath )
							end
						end
					elseif typeOfFunc == "string" then
						table.insert(orderedList[newMission], missionFunc )
					end
				end
			end	
		end
	end
	
	--Create mod mission list
	if orderedList ~= nil and next(orderedList) then	
		for demoScrKey,demoValue in pairs(orderedList)do
			if demoValue ~= nil and next(demoValue) then
				if demoScrKey ~= nil and demoScrKey ~= "ALL" then --If a mission code is provided, apply pack to that mission only
					if ZetaMissionList.missionPackTable[demoScrKey] == nil then ZetaMissionList.missionPackTable[demoScrKey] = {} end
					for i,fpkPath in ipairs(demoValue)do
						table.insert(ZetaMissionList.missionPackTable[demoScrKey], fpkPath )
					end				
				else --If none is provided, add pack to all missions possible.
					for i,fpkPath in ipairs(demoValue)do 
						table.insert(ZetaMissionList.allMissionsPackTable, fpkPath )
					end	
				end
			end
		end	
		if Mission.SetMissionPackagePathFunc then Mission.SetMissionPackagePathFunc(ZetaMissionList.GetMissionPackagePath) end --Override TPP mission list
	elseif Mission.SetMissionPackagePathFunc then Mission.SetMissionPackagePathFunc(TppMissionList.GetMissionPackagePath) end --Reset TPP mission list
end

function ZetaMissionList.AddModMissionPacks(missionCode)
	local packs = {}
	
	--Add packs to all missions except init
	if missionCode > 5 then
		local allModMissionTable = ZetaMissionList.allMissionsPackTable
		if allModMissionTable ~= nil and next(allModMissionTable) then
			for i,fpkPath in ipairs(allModMissionTable)do
				table.insert(packs,fpkPath)
			end
		end
	end
	
	--Add missions based on code
	local modMissionTable = ZetaMissionList.missionPackTable
	if modMissionTable ~= nil and next(modMissionTable) then
		local modMissionPack = modMissionTable[missionCode]
		if modMissionPack ~= nil and next(modMissionPack) then
			for i,fpkPath in ipairs(modMissionPack)do
				table.insert(packs,fpkPath)
			end			
		end
	end
	
	return packs
end

function ZetaMissionList.GetMissionPackagePath(missionCode)
	local packagePaths = ZetaMissionList.AddModMissionPacks(missionCode)
	if TppMissionList ~= nil then
		local missionPaths = TppMissionList.GetMissionPackagePath(missionCode)
		if missionPaths ~= nil and next(missionPaths) then
			for i,fpkPath in ipairs(missionPaths)do
				table.insert(packagePaths,fpkPath)
				--packagePaths[#packagePaths+1] = fpkPath
			end
		end
	end
	return packagePaths
end

return ZetaMissionList