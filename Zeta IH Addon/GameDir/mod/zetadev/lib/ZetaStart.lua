--ZetaStart.lua
--Description: Loads Zeta libraries, runs various functions.
local this={
	libraries = { 
		--Zeta Libraries
		"zetadev/lib/ZetaDef.lua",
		"zetadev/lib/ZetaUtil.lua",
		"zetadev/lib/ZetaVar.lua",
		"zetadev/lib/ZetaCore.lua",
		"zetadev/lib/ZetaIndex.lua",
		"zetadev/lib/ZetaMenu.lua",
		"zetadev/lib/ZetaNativeOverride.lua",
		"zetadev/lib/ZetaEnemy.lua",
		"zetadev/lib/ZetaPlayer.lua",
		"zetadev/lib/ZetaMission.lua",
		"zetadev/lib/ZetaMessages.lua",
		"zetadev/lib/ZetaPlayerParts.lua",
		"zetadev/lib/ZetaBuddyParts.lua",
		"zetadev/lib/ZetaVehicleParts.lua",
		"zetadev/lib/ZetaCommonPackList.lua", 
		"zetadev/lib/ZetaDemoBlockList.lua", 
		"zetadev/lib/ZetaMissionList.lua",
		--TPP Table Overrides
		"zetadev/tpp/Fox/Scripts/Gr/ZetaGr_init_dx11.lua",
		"zetadev/tpp/Tpp/Scripts/Equip/ZetaEquipIdTable.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/parts/ZetaEquipParameters.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/parts/ZetaEquipMotionDataForChimera.lua",
		"zetadev/tpp/Tpp/Scripts/Equip/ZetaChimeraPartsPackageTable.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/ZetaEquipParameterTables.lua",
		"zetadev/tpp/Assets/tpp/level_asset/damage/ParameterTables/ZetaDamageParameterTables.lua",
		"zetadev/tpp/Tpp/Scripts/Equip/ZetaEquipMotionData.lua",
		"zetadev/tpp/Assets/tpp/level_asset/enemy/ZetaSoldier2FaceAndBodyData.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/ZetaRecoilMaterialTable.lua",
		"zetadev/tpp/Assets/tpp/level_asset/player/game_object/ZetaPlayerParameters.lua",
		"zetadev/tpp/Assets/tpp/level_asset/player/game_object/ZetaCommonMotionPackage.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaEquipDevelopConstSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaEquipDevelopFlowSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaWeaponPartsUiSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaWeaponPartsCombinationSettings.lua",
		function()
			--InfCore.LoadExternalModule"Zeta"
			--InfCore.LoadExternalModule"ZetaUI"
			if ZetaNativeOverride ~= nil then ZetaNativeOverride.Reload() end
			if ZetaIndex ~= nil then ZetaIndex.LoadAllModFiles() end
			if ZetaCore ~= nil then ZetaCore.ReloadMods({force=true,reloadMods=false,reloadType=ZetaCore.ReloadType.Graphics}) end
		end,
	}
}
--TPP Load Order
--EquipIdTable.lua
--EquipParameters.lua
--EquipMotionDataForChimera.lua
--ChimeraPartsPackageTable.lua
--EquipParameterTables.lua
--DamageParameterTables.lua
--EquipMotionData.lua
--Soldier2FaceAndBodyData.lua
--RecoilMaterialTable.lua
--Player2_camouf_param.lua
--TppPlayer2InitializeScript.lua
--MbmCommonSetting.lua
--EquipDevelopConstSetting.lua
--EquipDevelopFlowSetting.lua
--WeaponPartsUiSetting.lua
--WeaponPartsCombinationSettings.lua
if this.libraries ~= nil and next(this.libraries) then --Load Zeta
	for i,func in ipairs(this.libraries) do 
		if func ~= nil then
			if type(func) == "string" then InfCore.LoadExternalLibrary(func)
			elseif type(func) == "function" then func() end
		end
	end
end
return this