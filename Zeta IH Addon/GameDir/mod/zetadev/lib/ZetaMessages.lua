--ZetaMessages.lua
--Description: Simplifies messages by generating functions for them.
local ZetaMessages = {}
local StrCode32 = Fox.StrCode32
--local StrCode32Table = Tpp.StrCode32Table

--Messages
function ZetaMessages.GetGameObjectList()
	local ret = {
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
	return ret
end
function ZetaMessages.GetPlayerList()
	local ret = {
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
				ZetaPlayer.lastEquipWeapon = equipId
				ZetaIndex.SafeFuncInGame("OnEquipWeapon", playerIndex, equipId )
			end
		},
		{
			msg = "OnEquipItem",
			func = function(playerId,equipId)
				ZetaPlayer.lastEquipItem = equipId
				ZetaIndex.SafeFuncInGame("OnEquipItem", playerId, equipId )					
			end
		},
		{
			msg = "OnEquipHudClosed",
			func = function(playerIndex,equipId,equipType)
				ZetaPlayer.lastEquip = equipId
				ZetaPlayer.lastEquipType = equipType
				ZetaIndex.SafeFuncInGame("OnEquipHudClosed", playerIndex,equipId,equipType )				
			end
		},
		{	
			msg = "WeaponPutPlaced",
			func = function( playerIndex, equipId )
				ZetaPlayer.lastPlacedWeapon = equipId
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
	return ret
end
function ZetaMessages.GetUIList()
	local ret = {
		--{
		--	msg = "MissionPrep_Start",
		--	func = function()
		--		if ZetaMission ~= nil then ZetaMission.MissionPrep_Start() end
		--		ZetaIndex.SafeFuncInGame("OnMissionPrep_Start", ZetaMessages )
		--	end,
		--},
	}
	return ret
end
function ZetaMessages.Update()
	if ZetaMessages.popUpThink ~= nil then --Is there a popup?
		local status, ret1 = coroutine.resume(ZetaMessages.popUpThink)
		if not status then ZetaMessages.popUpThink = nil end
	end
end
function ZetaMessages.Reload()
	InfCore.Log( "["..ZetaDef.modName.."][Messages] Creating Zeta functions for TPP messages.",false,true)
	ZetaMessages.messagesTable = {}
	ZetaMessages.messagesTable = {
		GameObject = ZetaMessages.GetGameObjectList(),
		Player = ZetaMessages.GetPlayerList(),
		UI = ZetaMessages.GetUIList()
	}
	if InfLookup ~= nil then --Add any missing messages found in InfLookup
		local messageSigs = InfLookup.messageSignatures
		if messageSigs ~= nil and next(messageSigs) then
			for objType,objTable in pairs(messageSigs)do 
				if ZetaMessages.messagesTable[objType] == nil then ZetaMessages.messagesTable[objType] = {} end
				for funcName,funcTable in pairs(objTable)do 
					if ZetaMessages.ContainsMessage(funcName,objType) == false then --Add to message table if it doesn't exist
						local newMsg = { msg = funcName,func = function() ZetaIndex.SafeFuncInGame(funcName,ZetaMessages) end}
						if funcTable ~= nil and next(funcTable) then
							newMsg.func = function(...) ZetaIndex.SafeFuncInGame(funcName,...) end
						end
						table.insert(ZetaMessages.messagesTable[objType], newMsg)
					end
				end
			end
		end
	end
	if ZetaIndex ~= nil then --Load any modifications made to messages
		ZetaIndex.ModFunction("SetMessageTable", ZetaMessages ) 
		local newMessageTable = ZetaIndex.ModGet("MessageTable", ZetaMessages)
		if newMessageTable ~= nil and next(newMessageTable) then
			ZetaMessages.messagesTable = ZetaUtil.MergeTables(ZetaMessages.messagesTable, newMessageTable, {"msg","sender"})
		end
	end
	--Show all messages generated, included those by modules.
	if ZetaMessages.messagesTable ~= nil and next(ZetaMessages.messagesTable) then
		local numOfFuncs = 0
		for objType,objVal in pairs(ZetaMessages.messagesTable) do
			for i,message in ipairs(objVal) do
				if message ~= nil and next(message) then
					if message.msg ~= nil then
						InfCore.Log( "["..ZetaDef.modName.."][Messages] "..message.msg,false,true)
						numOfFuncs = numOfFuncs + 1
					end
				end
			end
		end
		InfCore.Log( "["..ZetaDef.modName.."][Messages] Generated "..numOfFuncs.." functions",false,true)
		ZetaMessages.messagesTable = Tpp.StrCode32Table(ZetaMessages.messagesTable)
		ZetaMessages.Init()
	end
end
--Purpose: Checks if message is unique
function ZetaMessages.ContainsMessage(msgID, objID)
	if ZetaMessages.messagesTable ~= nil and next(ZetaMessages.messagesTable) then
		if objID ~= nil then
			for i,entry in ipairs(ZetaMessages.messagesTable[objID])do
				if entry.msg == msgID then return true end
			end
		else
			for objType,objTable in pairs(ZetaMessages.messagesTable)do 
				for i,entry in ipairs(objTable)do
					if entry.msg == msgID then return true end
				end
			end
		end
	end
	return false
end
ZetaMessages.Messages = function() return ZetaMessages.messagesTable end
ZetaMessages.Init = function(missionTable) ZetaMessages.messageExecTable=Tpp.MakeMessageExecTable(ZetaMessages.Messages()) end
ZetaMessages.OnMessage = function(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
	Tpp.DoMessage(ZetaMessages.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
--Purpose: Handles TPP event timers
function ZetaMessages.StartTimer(timerName, duration)
	if GkEventTimerManager.IsTimerActive( timerName ) then
		GkEventTimerManager.Stop( timerName )
		GkEventTimerManager.Start( timerName, duration )
	else GkEventTimerManager.Start( timerName, duration ) end
end
--Purpose: Can define timers easily with the following function
function ZetaMessages.Timer(timerName,timerFunc)return {msg = "Finish", sender = timerName, func = timerFunc}end
--Purpose: Toggle on-screen announcements
function ZetaMessages.ToggleAnnounceLog(toggle)
	if TppUiStatusManager ~= nil then
		if toggle == true then
			TppUiStatusManager.SetStatus( "AnnounceLog", "SUSPEND_LOG" )
			TppUiStatusManager.SetStatus( "AnnounceLog","INVALID_LOG")	
		else
			TppUiStatusManager.UnsetStatus( "AnnounceLog","INVALID_LOG")	
			TppUiStatusManager.UnsetStatus( "AnnounceLog","SUSPEND_LOG")	
			TppUiStatusManager.ClearStatus("AnnounceLog")	
		end
	end
end
--Purpose: Creates a pop-up window in TPP
--text: LangID entry for the message seen in the pop-up window
--yesFunc: Function that fires when yes is selected
--noFunc: Function that fires when no is selected
--onCloseFunc: Function that fires when pop-up is closed
function ZetaMessages.CreatePopup(params)
    if params.text == nil or ZetaMessages.popUpThink ~= nil then return nil end --If a pop-up exists or there's no text, stop here
    local popUpCoroutine = function()
        local popUpType = Popup.TYPE_ONE_BUTTON --If yesFunc and noFunc are defined, the pop-up window will show two options instead of one.
        if params.yesFunc ~= nil and params.noFunc ~= nil then popUpType = Popup.TYPE_TWO_BUTTON end
        TppUiCommand.ShowPopup( params.text, popUpType )
        while TppUiCommand.IsShowPopup() do coroutine.yield() end
        if popUpType == Popup.TYPE_TWO_BUTTON then
            local selectedOption = TppUiCommand.GetPopupSelect()
            if selectedOption == Popup.SELECT_OK then params.yesFunc() else params.noFunc() end
        end
        if params.onCloseFunc ~= nil then params.onCloseFunc() end
    end
    ZetaMessages.popUpThink = coroutine.create(popUpCoroutine)
end
return ZetaMessages