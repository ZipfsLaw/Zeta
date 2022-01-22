--ZetaPlayer.lua
local ZetaPlayer={}

--Improved weapon switch
function ZetaPlayer.SwitchToWeapon(subEventTable)
	local newEquipId = subEventTable.equipId --TppEquip[ subEventTable.equipId ]
	local newStock = subEventTable.stock
	local newAmmo = subEventTable.ammo

	--Transfer ammo count to next weapon
	if subEventTable.usePrevEquipAmmoStock and subEventTable.inventorySlot ~= nil then		
		newStock = Player.GetAmmoStockBySlot(subEventTable.inventorySlot,vars.currentSupportWeaponIndex)
	end
	
	--Full reload on switch or empty mag?
	if subEventTable.ReloadOnSwitch == true then
		local equipInfo = ZetaEquip.GetEquipIDAmmoStock(newEquipId)
		newAmmo = equipInfo[2] 
	elseif subEventTable.usePrevEquipAmmoStock == true then
		newAmmo = 0 
	end
		
	--Announce it on screen?
	if subEventTable.announceToLog or subEventTable.announceToLog == nil then
		TppUiStatusManager.SetStatus( "AnnounceLog", "SUSPEND_LOG" )
		TppUiStatusManager.SetStatus( "AnnounceLog","INVALID_LOG")	
	end
	
	if subEventTable.slotType ~= nil then
		Player.UnsetEquip{
			slotType = subEventTable.slotType,    
			dropPrevEquip = false,  
		}
	end

	Player.ChangeEquip{
		equipId = newEquipId,
		stock = newStock,
		ammo = newAmmo,
		suppressorLife = subEventTable.suppressorLife,
		isSuppressorOn = subEventTable.isSuppressorOn,
		isLightOn = subEventTable.isLightOn,
		toActive = subEventTable.toActive,
		dropPrevEquip = subEventTable.dropPrevEquip,
	}

	--Announce it on screen?
	if subEventTable.announceToLog or subEventTable.announceToLog == nil then
		TppUiStatusManager.UnsetStatus( "AnnounceLog","INVALID_LOG")	
		TppUiStatusManager.UnsetStatus( "AnnounceLog","SUSPEND_LOG")	
		TppUiStatusManager.ClearStatus("AnnounceLog")	
	end
end

--Returns current equip's TppEquip.EQP_TYPE_
function ZetaPlayer.GetCurrentEquipTypeBySlot()
	return Player.GetEquipTypeIdBySlot( vars.currentInventorySlot, vars.currentSupportWeaponIndex )
end

function ZetaPlayer.GetLastEquipPickup() return ZetaPlayer.lastEquipPickup end
function ZetaPlayer.GetHeldEquip() return ZetaPlayer.heldEquip end

return ZetaPlayer