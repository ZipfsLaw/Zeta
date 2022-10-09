--ZetaMessages.lua
--Description: Simplifies messages by generating functions for them with InfLookup
local ZetaMessages = {
	zetaFuncs = { --Provides additional Zeta functions to discovered messages
		Player = {
			PlayerHoldWeapon = function( equipId, equipTypeId, isFlashLight, isShield ) ZetaPlayer.heldEquip = equipId end,
			OnEquipWeapon = function( playerIndex, equipId ) ZetaPlayer.lastEquipWeapon = equipId end,
			OnEquipItem = function(playerId,equipId) ZetaPlayer.lastEquipItem = equipId end,
			WeaponPutPlaced = function( playerIndex, equipId ) ZetaPlayer.lastPlacedWeapon = equipId end,
			OnPickUpWeapon = function( playerGameObjectId, equipId, number) ZetaPlayer.lastEquipPickup = equipId end,
			OnEquipHudClosed = function(playerIndex,equipId,equipType)
				ZetaPlayer.lastEquip = equipId
				ZetaPlayer.lastEquipType = equipType
			end,
		}
	}
}
local StrCode32 = Fox.StrCode32
--local StrCode32Table = Tpp.StrCode32Table
function ZetaMessages.Reload()
	local numOfFuncs = 0
	ZetaMessages.messagesTable = {}
	if InfLookup ~= nil then
		local messageSigs = InfLookup.messageSignatures
		if messageSigs ~= nil and next(messageSigs) then
			for objType,objTable in pairs(messageSigs)do 
				if ZetaMessages.messagesTable[objType] == nil then ZetaMessages.messagesTable[objType] = {} end
				for funcName,funcTable in pairs(objTable)do 
					local zetaFunc = function()end
					if ZetaMessages.zetaFuncs[objType] ~= nil then 
						if ZetaMessages.zetaFuncs[objType][funcName] ~= nil then 
							zetaFunc = ZetaMessages.zetaFuncs[objType][funcName]
						end
					end
					local newMsg = { 
						msg = funcName,
						func = function() 
							zetaFunc()
							ZetaIndex.SafeFuncInGame(funcName,ZetaMessages) 
						end
					}
					if funcTable ~= nil and next(funcTable) then
						newMsg.func = function(...) 
							zetaFunc(...)
							ZetaIndex.SafeFuncInGame(funcName,...) 
						end
					end
					table.insert(ZetaMessages.messagesTable[objType], newMsg)
					numOfFuncs = numOfFuncs + 1
				end
			end
		end
	end
	ZetaMessages.messagesTable = Tpp.StrCode32Table(ZetaMessages.messagesTable)
	ZetaMessages.Init()
	InfCore.Log( "["..ZetaDef.modName.."][Messages] Generated "..numOfFuncs.." functions",false,true)
end
ZetaMessages.Messages = function() return ZetaMessages.messagesTable end
ZetaMessages.Init = function(missionTable) ZetaMessages.messageExecTable=Tpp.MakeMessageExecTable(ZetaMessages.Messages()) end
ZetaMessages.OnMessage = function(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
	Tpp.DoMessage(ZetaMessages.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
return ZetaMessages