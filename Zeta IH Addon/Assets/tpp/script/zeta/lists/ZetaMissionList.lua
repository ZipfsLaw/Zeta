--ZetaMissionList.lua
local ZetaMissionList={}

function ZetaMissionList.Reload()	
	ZetaMissionList.ReloadMissionTables()
	ZetaMissionList.ReloadAdditionalFPKs()
end

function ZetaMissionList.ReloadMissionTables()
	--Reload mission pack table with mods
	if TppMissionList ~= nil then
		ZetaMissionList.missionPackTable = {}
		
		--Reload mission tables from zeta mods
		local orderedList = {}
		local newMissionFunctions = ZetaIndex.ModGet("MissionTable", ZetaMissionList)
		for x,newMissionPaths in ipairs(newMissionFunctions)do
			if newMissionPaths ~= nil and next(newMissionPaths) then
				for missionCode,missionFunction in pairs(newMissionPaths)do
					if orderedList[missionCode] == nil then 
						orderedList[missionCode] = missionFunction 
					end
				end	
			end
		end
	
		--Create mod mission list
		if orderedList ~= nil and next(orderedList) then	
			for missionCode,missionFunction in pairs(orderedList)do
				TppMissionList.missionPackTable[missionCode] = missionFunction
			end	
		end
	end
end

function ZetaMissionList.AddDefaultMissionAreaPack(missionCode, pathAdd)
	if TppPackList ~= nil then
		local pack=ZetaMissionList.MakeDefaultMissionAreaPackPath(missionCode, pathAdd)
		if pack then TppPackList.AddMissionPack(pack) end
	end
end

function ZetaMissionList.MakeDefaultMissionAreaPackPath(missionCode, pathAdd)
	if TppMission ~= nil then
		local missionCode=missionCode
		if TppMission.IsHardMission(missionCode)then
			missionCode=TppMission.GetNormalMissionCodeFromHardMission(missionCode)
		end
		local missionTypeName,missionTypeCodeName=TppPackList.GetMissionTypeAndMissionName(missionCode)
		if missionTypeName and missionTypeCodeName then
			local packPath="/Assets/tpp/pack/mission2/"..(missionTypeName..("/"..(missionTypeCodeName..(pathAdd..("/"..(missionTypeCodeName.."_area.fpk"))))))
			return packPath
		end
	end
end

function ZetaMissionList.ReloadAdditionalFPKs()
	--Reload mission pack table with mods
	ZetaMissionList.missionFPKTable = {}
	ZetaMissionList.allMissionsFPKTable = {}

	--Reload fpks from zeta mods
	local orderedList = {}
	local newMissionFunctions = ZetaIndex.ModGet("AddMissionPacksTop", ZetaMissionList)
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
					if ZetaMissionList.missionFPKTable[demoScrKey] == nil then ZetaMissionList.missionFPKTable[demoScrKey] = {} end
					for i,fpkPath in ipairs(demoValue)do
						table.insert(ZetaMissionList.missionFPKTable[demoScrKey], fpkPath )
					end				
				else --If none is provided, add pack to all missions possible.
					for i,fpkPath in ipairs(demoValue)do 
						table.insert(ZetaMissionList.allMissionsFPKTable, fpkPath )
					end	
				end
			end
		end	
		if Mission.SetMissionPackagePathFunc then Mission.SetMissionPackagePathFunc(ZetaMissionList.GetMissionPackagePath) end --Override TPP mission list
	elseif Mission.SetMissionPackagePathFunc then 
		if TppMissionList ~= nil then Mission.SetMissionPackagePathFunc(TppMissionList.GetMissionPackagePath) end
	end --Reset TPP mission list
end

function ZetaMissionList.AddModMissionPacks(missionCode)
	local packs = {}
	--Add packs to all missions except init
	if missionCode > 5 then
		local allModMissionTable = ZetaMissionList.allMissionsFPKTable
		if allModMissionTable ~= nil and next(allModMissionTable) then
			for i,fpkPath in ipairs(allModMissionTable)do
				table.insert(packs,fpkPath)
			end
		end
	end
	--Add missions based on code
	local modMissionTable = ZetaMissionList.missionFPKTable
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