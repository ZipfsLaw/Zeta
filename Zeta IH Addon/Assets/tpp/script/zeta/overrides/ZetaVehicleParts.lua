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
	local currentParts = {}
	this.vehicleParts = {} --Clear certain tables
	if orderedList ~= nil and next(orderedList) then
		this.vehicleParts = orderedList
	end

	--Each vehicle has their own file path, rather than sharing one.		
	if this.vehicleParts ~= nil then
		if next(this.vehicleParts) then
			for i,partsList in ipairs(this.vehicleParts)do
				local vehicleType = this.VehicleStringToInt( this.GetVehicleType(partsList) )
				local vehicleFpk = this.GetVehicleFpk(partsList)
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
			end
		end
	end	

	local canOverride = false;
	if currentParts ~= nil and next(currentParts) then
		canOverride = true
	end

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

	this.vehicleParts.vehicleWestLv = currentParts.vehicleWestLv
	this.vehicleParts.vehicleEastLv = currentParts.vehicleEastLv
	this.vehicleParts.vehicleWestTrc = currentParts.vehicleWestTrc
	this.vehicleParts.vehicleEastTrc = currentParts.vehicleEastTrc
	this.vehicleParts.vehicleWestWavMachinegun = currentParts.vehicleWestWavMachinegun
	this.vehicleParts.vehicleWestWavCannon = currentParts.vehicleWestWavCannon
	this.vehicleParts.vehicleWestWav = currentParts.vehicleWestWav
	this.vehicleParts.vehicleWestWavRocket = currentParts.vehicleWestWavRocket
	this.vehicleParts.vehicleWestTnk = currentParts.vehicleWestTnk
	this.vehicleParts.vehicleEastTnk = currentParts.vehicleEastTnk
end

function this.VehicleStringToInt( vehicleType )
	if type(vehicleType) == "number" then return vehicleType end
	local newType = 0
	if vehicleType == "vehicleWestLv" then newType = 1
	elseif vehicleType == "vehicleEastLv" then newType = 2
	elseif vehicleType == "vehicleWestTrc" then newType = 3
	elseif vehicleType == "vehicleEastTrc" then newType = 4
	elseif vehicleType == "vehicleWestWavMachinegun" then newType = 5
	elseif vehicleType == "vehicleWestWavCannon" then newType = 6
	elseif vehicleType == "vehicleWestWav" then newType = 7
	elseif vehicleType == "vehicleWestWavRocket" then newType = 8
	elseif vehicleType == "vehicleWestTnk" then newType = 9
	elseif vehicleType == "vehicleEastTnk" then newType = 10
	end
	return newType
end

function this.GetVehicleType( entry )
	if entry["VehicleType"] ~= nil then
		return entry["VehicleType"]
	end
	return entry[1]
end

function this.GetVehicleFpk( entry )
	if entry["FpkPath"] ~= nil then
		return entry["FpkPath"]
	end
	return entry[2]
end

return this