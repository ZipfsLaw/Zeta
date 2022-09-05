--ZetaVehicleParts.lua
--Description: Handles IHHook's vehicle override system
local this={}

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
	local currentParts = {
		vehicleWestLv = {},
		vehicleEastLv = {},
		vehicleWestTrc = {},
		vehicleEastTrc = {},
		vehicleWestWavMachinegun = {},
		vehicleWestWavCannon = {},
		vehicleWestWav = {},
		vehicleWestWavRocket = {},
		vehicleWestTnk = {},
		vehicleEastTnk = {},
	}
	this.vehicleParts = {
		vehicleWestLv = {},
		vehicleEastLv = {},
		vehicleWestTrc = {},
		vehicleEastTrc = {},
		vehicleWestWavMachinegun = {},
		vehicleWestWavCannon = {},
		vehicleWestWav = {},
		vehicleWestWavRocket = {},
		vehicleWestTnk = {},
		vehicleEastTnk = {},
	} --Clear certain tables
	if orderedList ~= nil and next(orderedList) then this.vehicleParts = orderedList end
	--Each vehicle has their own file path, rather than sharing one.		
	if this.vehicleParts ~= nil then
		if next(this.vehicleParts) then
			for i,partsList in ipairs(this.vehicleParts)do
				local vehicleType = ZetaUtil.GetPartValue(partsList, "VehicleType", 1)
				local vehicleFpk = ZetaUtil.GetPartValue(partsList, "FpkPath", 2)
				if type(vehicleType) == "number" then 
					if vehicleType == 1 then currentParts.vehicleWestLv = vehicleFpk
					elseif vehicleType == 2 then currentParts.vehicleEastLv = vehicleFpk
					elseif vehicleType == 3 then currentParts.vehicleWestTrc = vehicleFpk
					elseif vehicleType == 4 then currentParts.vehicleEastTrc = vehicleFpk
					elseif vehicleType == 5 then currentParts.vehicleWestWavMachinegun = vehicleFpk
					elseif vehicleType == 6 then currentParts.vehicleWestWavCannon = vehicleFpk
					elseif vehicleType == 7 then currentParts.vehicleWestWav = vehicleFpk
					elseif vehicleType == 8 then currentParts.vehicleWestWavRocket = vehicleFpk
					elseif vehicleType == 9 then currentParts.vehicleWestTnk = vehicleFpk
					elseif vehicleType == 10 then currentParts.vehicleEastTnk = vehicleFpk end
				else
					for i,part in ipairs(this.currentParts)do part[vehicleType] = vehicleFpk end
				end
			end
		end
	end	
	local canOverride = false;
	if currentParts ~= nil and next(currentParts) then canOverride = true end
	--If any parts were found, apply them when their target parts are active
	if IhkVehicle ~= nil then
		IhkVehicle.SetOverrideVehicleSystem(canOverride)
		if canOverride == true then
			if currentParts.vehicleWestLv ~= nil then IhkVehicle.SetVehicleWestLvFpkPath( currentParts.vehicleWestLv ) else IhkVehicle.SetVehicleWestLvFpkPath( "" ) end
			if currentParts.vehicleEastLv ~= nil then IhkVehicle.SetVehicleEastLvFpkPath( currentParts.vehicleEastLv ) else IhkVehicle.SetVehicleEastLvFpkPath( "" ) end
			if currentParts.vehicleWestTrc ~= nil then IhkVehicle.SetVehicleWestTrcFpkPath( currentParts.vehicleWestTrc ) else IhkVehicle.SetVehicleWestTrcFpkPath( "" ) end
			if currentParts.vehicleEastTrc ~= nil then IhkVehicle.SetVehicleEastTrcFpkPath( currentParts.vehicleEastTrc ) else IhkVehicle.SetVehicleEastTrcFpkPath( "" ) end
			if currentParts.vehicleWestWavMachinegun ~= nil then IhkVehicle.SetVehicleWestWavMachineGunFpkPath( currentParts.vehicleWestWavMachinegun ) else IhkVehicle.SetVehicleWestWavMachineGunFpkPath( "" ) end
			if currentParts.vehicleWestWavCannon ~= nil then IhkVehicle.SetVehicleWestWavCannonFpkPath( currentParts.vehicleWestWavCannon ) else IhkVehicle.SetVehicleWestWavCannonFpkPath( "" ) end
			if currentParts.vehicleWestWav ~= nil then IhkVehicle.SetVehicleEastWavFpkPath( currentParts.vehicleWestWav ) else IhkVehicle.SetVehicleEastWavFpkPath( "" ) end
			if currentParts.vehicleWestWavRocket ~= nil then IhkVehicle.SetVehicleEastWavRocketFpkPath( currentParts.vehicleWestWavRocket ) else IhkVehicle.SetVehicleEastWavRocketFpkPath( "" ) end
			if currentParts.vehicleWestTnk ~= nil then IhkVehicle.SetVehicleWestTnkFpkPath( currentParts.vehicleWestTnk ) else IhkVehicle.SetVehicleWestTnkFpkPath( "" ) end
			if currentParts.vehicleEastTnk ~= nil then IhkVehicle.SetVehicleEastTnkFpkPath( currentParts.vehicleEastTnk ) else IhkVehicle.SetVehicleEastTnkFpkPath( "" ) end
		else
			IhkVehicle.SetVehicleWestLvFpkPath( "" )
			IhkVehicle.SetVehicleEastLvFpkPath( "" )
			IhkVehicle.SetVehicleWestTrcFpkPath( "" )
			IhkVehicle.SetVehicleEastTrcFpkPath( "" )
			IhkVehicle.SetVehicleWestWavMachineGunFpkPath( "" )
			IhkVehicle.SetVehicleWestWavCannonFpkPath( "" )
			IhkVehicle.SetVehicleEastWavFpkPath( "" )
			IhkVehicle.SetVehicleEastWavRocketFpkPath( "" )
			IhkVehicle.SetVehicleWestTnkFpkPath( "" )
			IhkVehicle.SetVehicleEastTnkFpkPath( "" )
		end
	end 
	this.vehicleParts={
		vehicleWestLv = currentParts.vehicleWestLv,
		vehicleEastLv = currentParts.vehicleEastLv,
		vehicleWestTrc = currentParts.vehicleWestTrc,
		vehicleEastTrc = currentParts.vehicleEastTrc,
		vehicleWestWavMachinegun = currentParts.vehicleWestWavMachinegun,
		vehicleWestWavCannon = currentParts.vehicleWestWavCannon,
		vehicleWestWav = currentParts.vehicleWestWav,
		vehicleWestWavRocket = currentParts.vehicleWestWavRocket,
		vehicleWestTnk = currentParts.vehicleWestTnk,
		vehicleEastTnk = currentParts.vehicleEastTnk,
	}
end

return this