--ZetaVehicleParts.lua
--Description: Handles IHHook's vehicle override system
local this={
	vehicleInfos = {
		{type="vehicleWestLv", func="SetVehicleWestLvFpkPath"},
		{type="vehicleEastLv", func="SetVehicleEastLvFpkPath"},
		{type="vehicleWestTrc", func="SetVehicleWestTrcFpkPath"},
		{type="vehicleEastTrc", func="SetVehicleEastTrcFpkPath"},
		{type="vehicleWestWavMachinegun", func="SetVehicleWestWavMachineGunFpkPath"},
		{type="vehicleWestWavCannon", func="SetVehicleWestWavCannonFpkPath"},
		{type="vehicleWestWav", func="SetVehicleEastWavFpkPath"},
		{type="vehicleWestWavRocket", func="SetVehicleEastWavRocketFpkPath"},
		{type="vehicleWestTnk", func="SetVehicleWestTnkFpkPath"},
		{type="vehicleEastTnk", func="SetVehicleEastTnkFpkPath"},
	},
}

function this.Reload()	
	local orderedList = {}
	local newParts = ZetaIndex.ModGet("LoadVehicleParts", this) 
	if newParts ~= nil and next(newParts) then
		for x,partsList in ipairs(newParts)do
			if partsList ~= nil and next(partsList) then
				for y,parts in ipairs(partsList)do
					table.insert( orderedList, parts )
				end
			end
		end		
	end	
	--Clear override
	if IhkVehicle ~= nil then
		if this.vehicleParts ~= nil and next(this.vehicleParts) then
			IhkVehicle.SetOverrideVehicleSystem(false)
		end
	end
	--Custom vehicle parts
	local currentParts = {}
	this.vehicleParts = {} --Clear certain tables
	if orderedList ~= nil and next(orderedList) then this.vehicleParts = orderedList end
	--Each vehicle has their own file path, rather than sharing one.		
	if this.vehicleParts ~= nil then
		if next(this.vehicleParts) then
			for i,partsList in ipairs(this.vehicleParts)do
				local vehicleType = ZetaUtil.GetPartValue(partsList, "VehicleType", 1)
				local vehicleFpk = ZetaUtil.GetPartValue(partsList, "FpkPath", 2)
				if type(vehicleType) == "number" then 
					currentParts[this.vehicleInfos[vehicleType].type] = vehicleFpk
				else currentParts[vehicleType] = vehicleFpk end
			end
		end
	end	
	local canOverride = false;
	if currentParts ~= nil and next(currentParts) then canOverride = true end
	--If any parts were found, apply them when their target parts are active
	if IhkVehicle ~= nil then
		IhkVehicle.SetOverrideVehicleSystem(canOverride)
		if canOverride == true then
			for i,vehicleInfo in ipairs(this.vehicleInfos)do
				local vehicleFunc = IhkVehicle[vehicleInfo.func]
				if currentParts[vehicleInfo.type] ~= nil then vehicleFunc( currentParts[vehicleInfo.type] ) else vehicleFunc( "" ) end
			end
		else
			for i,vehicleInfo in ipairs(this.vehicleInfos)do IhkVehicle[vehicleInfo.func]("") end
		end
	end 
	this.vehicleParts={} --Clear table
	for i,vehicleInfo in ipairs(this.vehicleInfos)do this.vehicleParts[vehicleInfo.type] = currentParts[vehicleInfo.type] end
end

return this