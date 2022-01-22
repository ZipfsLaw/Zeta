--ZetaEquip.lua
local this = {}

--Returns Magazine Equip Id, magazine bullet count, Stock bullet count, Sub Equip id, Sub magazine bullet count, Sub stock bullet count
function this.GetEquipIDAmmoStock(equipId)
	local i,l,r,o,n,t=TppEquip.GetAmmoInfo(equipId)
	return { i,l,r,o,n,t }
end

--EquipId: secondary, primaryHip, primaryBack, support
function this.CreateEquipTable(secondary, primaryHip, primaryBack, support )
	return { secondary, primaryHip, primaryBack, support }
end

--Covers all 8 items
function this.CreateItemTable(item1, item2, item3, item4, item5, item6, item7, item8)
	return { item1, item2, item3, item4, item5, item6, item7, item8,}
end

return this