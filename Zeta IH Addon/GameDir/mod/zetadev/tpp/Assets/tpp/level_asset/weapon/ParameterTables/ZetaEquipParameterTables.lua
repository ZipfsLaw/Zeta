--ZetaEquipParameterTables.lua
local this={}
function this.GetTable()
	local table={
		BlastParameter={
			0,
			{TppEquip.BLA_20mmGrenade,4,7,2.5},
			{TppEquip.BLA_20mmGrenadeS,4,5,2.5},
			{TppEquip.BLA_ms00,4,11,2.5},
			{TppEquip.BLA_ms02,4,11,2.5},
			{TppEquip.BLA_ms02F,4,13,2.5},
			{TppEquip.BLA_ms02F_G2,4,17,2.5},
			{TppEquip.BLA_ms02F_G3,4,17,2.5},
			{TppEquip.BLA_ms03,4,11,2.5},
			{TppEquip.BLA_East_ms_010,4,11,2.5},
			{TppEquip.BLA_West_ms_010,4,11,2.5},
			{TppEquip.BLA_Com_ms_010,4,11,2.5},
			{TppEquip.BLA_C4,2,8,2.5},
			{TppEquip.BLA_Grenade,2,7,2.5},
			{TppEquip.BLA_WarningFlare,1,3,3},
			{TppEquip.BLA_SmokeGrenade,1,8,8},
			{TppEquip.BLA_DMine,2,2.5,2.5},
			{TppEquip.BLA_AntitankMine,2,8,4},
			{TppEquip.BLA_SupportHeliFlareGrenade,1,3,3},
			{TppEquip.BLA_SupplyFlareGrenade,1,3,3},
			{TppEquip.BLA_StunGrenade,2,10,10},
			{TppEquip.BLA_SleepingGusGrenade,1,8,8},
			{TppEquip.BLA_MolotovCocktail,3,1,1},
			{TppEquip.BLA_MolotovCocktailPlaced,3,1,1},
			{TppEquip.BLA_ElectromagneticNetMine,2,5,5},
			{TppEquip.BLA_SleepingGusMine,1,4,4},
			{TppEquip.BLA_BlastArm,2,7,2.5},
			{TppEquip.BLA_Cannon,2,7.5,7.5},
			{TppEquip.BLA_Wav1,0,2,2},
			{TppEquip.BLA_WavCannon,2,7.5,7.5},
			{TppEquip.BLA_TankCannon,2,7.5,7.5},
			{TppEquip.BLA_WavRocket,2,7.5,7.5},
			{TppEquip.BLA_uth0_ammo0,4,7.5,7.5},
			{TppEquip.BLA_uth0_ammo1,4,7.5,7.5},
			{TppEquip.BLA_mgm0_ammo0,4,7.5,7.5},
			{TppEquip.BLA_mgm0_famo0,4,7.5,7.5},
			{TppEquip.BLA_mgs0_miss1,4,7.5,7.5},
			{TppEquip.BLA_mgs0_miss0,4,7.5,7.5},
			{TppEquip.BLA_mgs0_srcm0,2,7.5,7.5},
			{TppEquip.BLA_mgs0_grnd0,2,7.5,7.5},
			{TppEquip.BLA_Mortar,2,10,10},
			{TppEquip.BLA_FlareBomb,1,0,0},
			{TppEquip.BLA_GimmickCommon,2,3,3},
			{TppEquip.BLA_Drum,2,4.5,3},
			{TppEquip.BLA_GasTank,2,30,30},
			{TppEquip.BLA_HydrantTank,2,4.9,4.9},
			{TppEquip.BLA_BombAssist,2,20,30},
			{TppEquip.BLA_SleepGusAssist,1,30,30},
			{TppEquip.BLA_SmokeAssist,1,30,30},
			{TppEquip.BLA_ChaffAssist,1,30,30}
		},
		SupportWeaponParameter={
			0,
			{TppEquip.SWP_Grenade,6,3,0,1},
			{TppEquip.SWP_Grenade_G01,6,3,0,2},
			{TppEquip.SWP_Grenade_G02,8,3,0,3},
			{TppEquip.SWP_Grenade_G03,8,3,0,4},
			{TppEquip.SWP_Grenade_G04,12,3,0,5},
			{TppEquip.SWP_Grenade_G05,12,3,0,8},
			{TppEquip.SWP_Grenade_G06,12,3,0,9},
			{TppEquip.SWP_Grenade_G07,12,3,0,10},
			{TppEquip.SWP_Grenade_G08,12,3,0,11},
			{TppEquip.SWP_SmokeGrenade,6,3,30,1},
			{TppEquip.SWP_SmokeGrenade_G01,6,3,45,2},
			{TppEquip.SWP_SmokeGrenade_G02,8,3,45,3},
			{TppEquip.SWP_SmokeGrenade_G03,8,3,60,4},
			{TppEquip.SWP_SmokeGrenade_G04,12,3,60,5},
			{TppEquip.SWP_Magazine,-1,30,0,1},
			{TppEquip.SWP_C4,4,0,0,1},
			{TppEquip.SWP_C4_G01,4,0,0,2},
			{TppEquip.SWP_C4_G02,8,0,0,3},
			{TppEquip.SWP_C4_G03,8,0,0,4},
			{TppEquip.SWP_C4_G04,12,0,0,5},
			{TppEquip.SWP_DMine,6,1.2,120,3},
			{TppEquip.SWP_DMine_G01,8,1.2,120,4},
			{TppEquip.SWP_DMine_G02,12,1.2,120,5},
			{TppEquip.SWP_DMine_G03,12,1.2,120,8},
			{TppEquip.SWP_AntitankMine,4,.8,360,4},
			{TppEquip.SWP_AntitankMine_G01,8,.8,360,5},
			{TppEquip.SWP_AntitankMine_G02,12,.8,360,6},
			{TppEquip.SWP_Kibidango,4,30,60,3},
			{TppEquip.SWP_Kibidango_G01,8,30,120,4},
			{TppEquip.SWP_Kibidango_G02,12,30,180,5},
			{TppEquip.SWP_SupportHeliFlareGrenade,4,3,30,1},
			{TppEquip.SWP_SupportHeliFlareGrenade_G01,8,3,30,2},
			{TppEquip.SWP_SupportHeliFlareGrenade_G02,12,3,30,3},
			{TppEquip.SWP_SupplyFlareGrenade,4,3,30,2},
			{TppEquip.SWP_SupplyFlareGrenade_G01,8,3,30,3},
			{TppEquip.SWP_SupplyFlareGrenade_G02,12,3,30,4},
			{TppEquip.SWP_StunGrenade,4,3,0,3},
			{TppEquip.SWP_StunGrenade_G01,8,3,0,4},
			{TppEquip.SWP_StunGrenade_G02,12,3,0,5},
			{TppEquip.SWP_StunGrenade_G03,12,3,0,8},
			{TppEquip.SWP_StunGrenade_G04,12,3,0,9},
			{TppEquip.SWP_StunGrenade_G05,12,3,0,10},
			{TppEquip.SWP_StunGrenade_G06,12,3,0,11},
			{TppEquip.SWP_SleepingGusGrenade,4,3,10,4},
			{TppEquip.SWP_SleepingGusGrenade_G01,8,3,10,5},
			{TppEquip.SWP_SleepingGusGrenade_G02,12,3,10,6},
			{TppEquip.SWP_MolotovCocktail,4,30,0,3},
			{TppEquip.SWP_MolotovCocktail_G01,8,30,0,4},
			{TppEquip.SWP_MolotovCocktail_G02,12,30,0,5},
			{TppEquip.SWP_MolotovCocktailPlaced,8,30,0,3},
			{TppEquip.SWP_ElectromagneticNetMine,4,.8,5,4},
			{TppEquip.SWP_ElectromagneticNetMine_G01,8,.8,10,5},
			{TppEquip.SWP_ElectromagneticNetMine_G02,12,.8,20,6},
			{TppEquip.SWP_Decoy,4,300,0,2},
			{TppEquip.SWP_Decoy_G01,6,500,0,3},
			{TppEquip.SWP_Decoy_G02,12,700,0,4},
			{TppEquip.SWP_ActiveDecoy,6,300,0,3},
			{TppEquip.SWP_ActiveDecoy_G01,8,500,0,4},
			{TppEquip.SWP_ActiveDecoy_G02,12,700,0,5},
			{TppEquip.SWP_ShockDecoy,4,300,0,4},
			{TppEquip.SWP_ShockDecoy_G01,8,500,0,5},
			{TppEquip.SWP_ShockDecoy_G02,12,700,0,6},
			{TppEquip.SWP_ShockDecoy_G03,12,700,0,10},
			{TppEquip.SWP_ShockDecoy_G04,12,700,0,11},
			{TppEquip.SWP_CaptureCage,4,0,0,2},
			{TppEquip.SWP_CaptureCage_G01,6,0,0,3},
			{TppEquip.SWP_CaptureCage_G02,8,0,0,4},
			{TppEquip.SWP_SleepingGusMine,4,.8,0,4},
			{TppEquip.SWP_SleepingGusMine_G01,8,.8,0,5},
			{TppEquip.SWP_SleepingGusMine_G02,12,.8,0,8},
			{TppEquip.SWP_Dung,0,1,120,1},
			{TppEquip.SWP_WormholePortal,3,0,0,9},
			{TppEquip.SWP_WormholePortal_G01,3,0,0,10},
			{TppEquip.SWP_WormholePortal_G02,4,0,0,11},
			{TppEquip.SWP_WormholePortal_G03,5,0,0,12},
			{TppEquip.SWP_DMineLocator,-1,0,0,1},
			{TppEquip.SWP_SleepingGusMineLocator,-1,0,0,1},
			{TppEquip.SWP_FakeSign,5,3,60,5},
			{TppEquip.SWP_FakeSign_G01,7,3,80,7},
			{TppEquip.SWP_FakeSign_G02,9,3,100,8},
			{TppEquip.SWP_DarkMatter,3,0,0,7},
			{TppEquip.SWP_DarkMatter_G01,4,0,0,8},
			{TppEquip.SWP_DarkMatter_G02,4,0,0,10},
			{TppEquip.SWP_DarkMatter_G03,6,0,0,11},
			{TppEquip.SWP_StunDarkMatter,3,0,0,7},
			{TppEquip.SWP_StunDarkMatter_G01,4,0,0,8},
			{TppEquip.SWP_StunDarkMatter_G02,4,0,0,10},
			{TppEquip.SWP_StunDarkMatter_G03,6,0,0,11}
		},
	}
	return table
end
function this.Reload()
	--Clear and load vanilla tables
	this.equipParameterTables={}
	this.equipParameterTables=this.GetTable()
	--Load Mods
	ZetaIndex.ModFunction("SetEquipParameterTables", this ) --Passthrough
	local newEquipParameterTables = ZetaIndex.ModGet("EquipParameterTables", this)
	if newEquipParameterTables ~= nil and next(newEquipParameterTables) then
		this.equipParameterTables = ZetaUtil.MergeTables(this.equipParameterTables, newEquipParameterTables)
	end
	TppEquip.ReloadEquipParameterTables(this.equipParameterTables)
end
return this