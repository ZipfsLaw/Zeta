--ZetaMessages.lua
--Description: Simplifies messages by creating functions for them. 
local ZetaMessages = {}

--Messages
function ZetaMessages.GetGameObjectList()
	local table = {
		--Recovery
		{
			msg = "Carried",
			func = function ( gameObjectId, carriedState )
				ZetaIndex.SafeFuncInGame("OnCarried", gameObjectId, carriedState )
			end
		},
		{	
			msg = "Fulton",
			func = function( gameObjectId )
				ZetaIndex.SafeFuncInGame("OnFulton", gameObjectId )
			end
		},
		{	
			msg = "FultonFailed",
			func = function( gameObjectId, locatorName, locatorNameUpper, failureType )
				if failureType == TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
					ZetaIndex.SafeFuncInGame("OnFultonFailed", gameObjectId, locatorName, locatorNameUpper, failureType )
				end
			end
		},
		{	
			msg = "FultonInfo",
			func = function( gameObjectId )
				ZetaIndex.SafeFuncInGame("OnFultonInfo", gameObjectId )
			end
		},
		--Damage
		{	
			msg = "AimedFromPlayer",
			func = function( gameObjectId )				
				local slot = vars.currentInventorySlot
				local subIndex =  vars.currentSupportWeaponIndex
				local isNonActive = Player.IsNonActiveBySlot( slot, subIndex )
				if isNonActive == false then
					ZetaIndex.SafeFuncInGame("OnAimedFromPlayer", gameObjectId )
				end
			end
		},
		{		
			msg = "Neutralize",
			func = function( gameObjectId, attackerId, neutralizeType, neutralizeCause )
				ZetaIndex.SafeFuncInGame("OnNeutralize", gameObjectId, attackerId, neutralizeType, neutralizeCause )
			end
		},
		{		
			msg = "Damage",
			func = function( gameObjectId, AttackId, AttackerId )
				ZetaIndex.SafeFuncInGame("OnDamage", gameObjectId, AttackId, AttackerId )
			end
		},
		{	
			msg = "Dying",
			func = function( gameObjectId )
				ZetaIndex.SafeFuncInGame("OnDying", gameObjectId )
			end
		},
		{	
			msg = "Dead",
			func = function( gameObjectId )
				ZetaIndex.SafeFuncInGame("OnDead", gameObjectId )
			end
		},
		{	
			msg = "HeadShot",
			func = function( gameObjectId, attackId, attackerObjectId, headShotFlag )
				ZetaIndex.SafeFuncInGame("OnHeadShot", gameObjectId, attackId, attackerObjectId, headShotFlag )
			end
		},
		--Vehicles
		{	
			msg = "PlacedIntoVehicle",
			func = function( gameObjectId, vehicleGameObjectId )
				ZetaIndex.SafeFuncInGame("OnPlacedIntoVehicle", gameObjectId, vehicleGameObjectId )
			end
		},
		{			
			msg = "VehicleAction",
			func = function ( rideMemberId, vehicleId, actionType )	
				ZetaIndex.SafeFuncInGame("OnVehicleAction", rideMemberId, vehicleId, actionType )
			end
		},
		{	
			msg = "VehicleBroken",
			func = function( gameObjectId, state )
				if state == StrCode32("End") then
					ZetaIndex.SafeFuncInGame("OnVehicleBroken", gameObjectId, state )
				end
			end
		},
		--CP/Enemy
		{	msg = "ChangePhase",
			func = function( cpId, phase )
				ZetaIndex.SafeFuncInGame("OnChangePhase", cpId, phase )
			end
		},
		{	
			msg = "RadioEnd",
			func = function( gameObjectId, cpGameObjectId, speechLabel, isSuccess )
				ZetaIndex.SafeFuncInGame("OnRadioEnd", gameObjectId, cpGameObjectId, speechLabel, isSuccess )
			end
		},
		--Conversations
		{	
			msg = "ConversationEnd",
			func = function( gameObjectId, speechLabel, isSuccess )
				ZetaIndex.SafeFuncInGame("OnConversationEnd", gameObjectId, speechLabel, isSuccess )
			end
		},
		{	
			msg = "MonologueEnd",
			func = function( gameObjectId, speechLabel, isSuccess )
				ZetaIndex.SafeFuncInGame("OnMonologueEnd", gameObjectId, speechLabel, isSuccess )
			end
		},
		--Skulls
		{ 
			msg = "StartedSearch",				
			func = function( gameObjectId, searchType )				
				ZetaIndex.SafeFuncInGame("OnStartedSearch", gameObjectId, searchType )
			end
		},		
		{ 
			msg = "StartedDiscovery",				
			func = function( gameObjectId )				
				ZetaIndex.SafeFuncInGame("OnStartedDiscovery", gameObjectId )
			end
		},			
		{ 
			msg = "StartedCombat",				
			func = function(gameObjectId)				
				ZetaIndex.SafeFuncInGame("OnStartedCombat", gameObjectId )
			end	
		},
		--Player
		{	
			msg = "PlayerGetNear",
			func = function ( gameObjectId )
				ZetaIndex.SafeFuncInGame("OnPlayerGetNear", gameObjectId )
			end
		},
		{	
			msg = "PlayerGetAway",
			func = function ( gameObjectId )
				ZetaIndex.SafeFuncInGame("OnPlayerGetAway", gameObjectId )
			end
		},
		--Navigation
		{	
			msg = "RoutePoint2",
			func = function( gameObjectId, routeId, routeNodeIndex, messageId )
				ZetaIndex.SafeFuncInGame("OnRoutePoint2", gameObjectId, routeId, routeNodeIndex, messageId )
			end
		},
	}
	return table
end

function ZetaMessages.GetPlayerList()
	local table = {
		--Equip
		{
			msg = "PlayerHoldWeapon",
			func = function( equipId, equipTypeId, isFlashLight, isShield ) 
				ZetaPlayer.heldEquip = equipId 
				ZetaIndex.SafeFuncInGame("OnPlayerHoldWeapon", equipId, equipTypeId, isFlashLight, isShield )
			end 
		},
		{	
			msg = "OnEquipWeapon",
			func = function( playerIndex, equipId )
				ZetaIndex.SafeFuncInGame("OnEquipWeapon", playerIndex, equipId )
			end
		},
		{
			msg = "OnEquipItem",
			func = function(playerId,equipId)
				ZetaIndex.SafeFuncInGame("OnEquipItem", playerId, equipId )					
			end
		},
		{	
			msg = "WeaponPutPlaced",
			func = function( playerIndex, equipId )
				ZetaIndex.SafeFuncInGame("OnWeaponPutPlaced", playerIndex, equipId )
			end
		},
		{	
			msg = "OnPickUpCollection",
			func = function( playerGameObjectId, collectionUniqueId, collectionTypeId )
				ZetaIndex.SafeFuncInGame("OnPickUpCollection", playerGameObjectId, collectionUniqueId, collectionTypeId )
			end
		},
		{
			msg = "OnPickUpWeapon",
			func = function( playerGameObjectId, equipId, number) 
				ZetaPlayer.lastEquipPickup = equipId 
				ZetaIndex.SafeFuncInGame("OnPickUpWeapon", playerGameObjectId, equipId, number )
			end
		},
		{
			msg = "StartEventDoorPicking",
			func = function (playerId,doorId)
				ZetaIndex.SafeFuncInGame("OnStartEventDoorPicking", playerId, doorId )
			end
		},
		{
			msg = "OnAmmoLessInMagazine", 
			func = function() 
				ZetaIndex.SafeFuncInGame("OnAmmoLessInMagazine", ZetaMessages )
			end 
		},
		{
			msg = "OnAmmoStackEmpty",
			func = function() 
				ZetaIndex.SafeFuncInGame("OnAmmoStackEmpty", playerIndex, equipId ) 
			end 
		},
		--Player Status
		{	
			msg = "PlayerDamaged",
			func = function ( playerIndex, attackId, attackerId )
				ZetaIndex.SafeFuncInGame("OnPlayerDamaged", playerIndex, attackId, attackerId )
			end
		},
		{	
			msg = "PlayerFulton",
			func = function( playerId, gameObjectId )
				ZetaIndex.SafeFuncInGame("OnPlayerFulton", playerId, gameObjectId)
			end
		},
		{
			msg = "OnPickUpSupplyCbox",
			func = function ()
				ZetaIndex.SafeFuncInGame("OnPickUpSupplyCbox", ZetaMessages )
			end
		},
		{
			msg = "OnComeOutSupplyCbox",
			func = function ()
				ZetaIndex.SafeFuncInGame("OnComeOutSupplyCbox", ZetaMessages )
			end
		},
		{
			msg = "OnPlayerToilet",
			func = function()
				ZetaIndex.SafeFuncInGame("OnPlayerToilet", ZetaMessages )
			end
		},
		{
			msg	= "OnPlayerTrashBox",
			func = function()
				ZetaIndex.SafeFuncInGame("OnPlayerTrashBox", ZetaMessages )
			end
		},
		{	
			msg = "OnVehicleRide_Start",
			func = function( playerId, rideType, gameObjectId )
				ZetaIndex.SafeFuncInGame("OnVehicleRide_Start", playerId, rideType, gameObjectId )
			end
		},
		{	
			msg = "RideHelicopter",
			func = function( gameObjectId )
				if Tpp.IsPlayer( gameObjectId ) then
					ZetaIndex.SafeFuncInGame("OnRideHelicopter", gameObjectId )
				end
			end,
		},
		{
			msg = "RideHelicopterWithHuman",
			func = function()
				ZetaIndex.SafeFuncInGame("OnRideHelicopterWithHuman", ZetaMessages )
			end
		},
		{	
			msg = "LandingFromHeli",
			func = function( questNameHash )
				ZetaIndex.SafeFuncInGame("OnLandingFromHeli", questNameHash )
			end
		},
		{	
			msg = "OnPlayerHeliHatchOpen",
			func = function()
				ZetaIndex.SafeFuncInGame("OnPlayerHeliHatchOpen", ZetaMessages )
			end,
		},
	}
	return table
end

function ZetaMessages.GetUIList()
	local table = {
		--{
		--	msg = "MissionPrep_Start",
		--	func = function()
		--		if ZetaMission ~= nil then ZetaMission.MissionPrep_Start() end
		--		ZetaIndex.SafeFuncInGame("OnMissionPrep_Start", ZetaMessages )
		--	end,
		--},
	}
	return table
end

function ZetaMessages.Reload()
	--Clear vanilla table and reload mods
	ZetaMessages.messagesTable = {}
	ZetaMessages.messagesTable = {
		GameObject = ZetaMessages.GetGameObjectList(),
		Player = ZetaMessages.GetPlayerList(),
		UI = ZetaMessages.GetUIList()
	}

	--Load mods
	ZetaIndex.SafeFunc("SetModMessages", ZetaMessages ) --Passthrough
	ZetaMessages.messagesTable = Tpp.StrCode32Table(ZetaMessages.messagesTable)
	ZetaMessages.Init()
end

ZetaMessages.Messages = function()
	return ZetaMessages.messagesTable
end

ZetaMessages.Init = function(missionTable)
	ZetaMessages.messageExecTable=Tpp.MakeMessageExecTable(ZetaMessages.Messages())
end
ZetaMessages.OnMessage = function(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
	Tpp.DoMessage(ZetaMessages.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

return ZetaMessages