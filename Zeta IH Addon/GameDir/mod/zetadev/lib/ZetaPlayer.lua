--ZetaPlayer.lua
--Description: Adds functions for the player.
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
		local equipInfo = ZetaPlayer.GetEquipIDAmmoStock(newEquipId)
		newAmmo = equipInfo[2] 
	elseif subEventTable.usePrevEquipAmmoStock == true then newAmmo = 0 end
	if subEventTable.announceToLog or subEventTable.announceToLog == nil then ZetaMenu.ToggleAnnounceLog( true ) end --Announce it on screen?
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
	if subEventTable.announceToLog or subEventTable.announceToLog == nil then ZetaMenu.ToggleAnnounceLog( false ) end --Announce it on screen?
end

--Returns current equip's TppEquip.EQP_TYPE_
function ZetaPlayer.GetCurrentEquipTypeBySlot()
	return Player.GetEquipTypeIdBySlot( vars.currentInventorySlot, vars.currentSupportWeaponIndex )
end

function ZetaPlayer.GetLastPlacedWeapon() return ZetaPlayer.lastPlacedWeapon end --Returns last placed weapon, like mines
function ZetaPlayer.GetLastWeaponPickup() return ZetaPlayer.lastEquipWeapon end --Returns last weapon acquired by the player
function ZetaPlayer.GetLastItemPickup() return ZetaPlayer.lastEquipItem end --Returns last item acquired by the player
function ZetaPlayer.GetLastEquipPickup() return ZetaPlayer.lastEquipPickup end --Returns last weapon/item acquired by the player
function ZetaPlayer.GetLastEquip() return ZetaPlayer.lastEquip end --Returns last weapon equiped by the player
function ZetaPlayer.GetLastEquipType() return ZetaPlayer.lastEquipType end --Returns last weapon type equiped by the player
function ZetaPlayer.GetHeldEquip() return ZetaPlayer.heldEquip end --Returns last weapon aimed by player

--Returns Magazine Equip Id, magazine bullet count, Stock bullet count, Sub Equip id, Sub magazine bullet count, Sub stock bullet count
function ZetaPlayer.GetEquipIDAmmoStock(equipId)
	local i,l,r,o,n,t=TppEquip.GetAmmoInfo(equipId)
	return { i,l,r,o,n,t }
end

return ZetaPlayer