--ZetaStart.lua
--Description: Loads TPP and Zeta libraries.
local this={
	libraries = { 
		--Zeta Libraries
		"zetadev/lib/ZetaDef.lua",
		"zetadev/lib/ZetaTPPDef.lua",
		"zetadev/lib/ZetaUtil.lua",
		"zetadev/lib/ZetaVar.lua",
		"zetadev/lib/ZetaCore.lua",
		"zetadev/lib/ZetaIndex.lua",
		"zetadev/lib/ZetaMenu.lua",
		 --Add Tpp scripts to block list
		"zetadev/lib/ZetaNativeOverride.lua",
		"zetadev/lib/ZetaHook.lua",
		"zetadev/lib/ZetaIH.lua",
		function()
			if ZetaNativeOverride ~= nil then ZetaNativeOverride.Init() end
		end,
		--Load all mod files and reload graphics
		"zetadev/tpp/Fox/Scripts/Gr/ZetaGr_init_dx11.lua",
		function()
			if ZetaIndex ~= nil then ZetaIndex.LoadAllModFiles() end
			if ZetaCore ~= nil then ZetaCore.ReloadMods({force=true,reloadMods=false,reloadType=ZetaCore.ReloadType.Graphics}) end
		end,
		--Zeta Modules
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
		"zetadev/tpp/Tpp/Scripts/Equip/ZetaEquipIdTable.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/parts/ZetaEquipParameters.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/parts/ZetaEquipMotionDataForChimera.lua",
		"zetadev/tpp/Tpp/Scripts/Equip/ZetaChimeraPartsPackageTable.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/ZetaEquipParameterTables.lua",
		"zetadev/tpp/Assets/tpp/level_asset/damage/ParameterTables/ZetaDamageParameterTables.lua",
		"zetadev/tpp/Tpp/Scripts/Equip/ZetaEquipMotionData.lua",
		"zetadev/tpp/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/ZetaRecoilMaterialTable.lua",
		"zetadev/tpp/Assets/tpp/level_asset/chara/player/game_object/ZetaPlayerParameters.lua",
		"zetadev/tpp/Assets/tpp/level_asset/chara/player/game_object/ZetaCommonMotionPackage.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting20BaseResSec.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting30Deploy.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting40RewardDeploy.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting50RewardFob.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaMbmCommonSetting60DbPfLang.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaEquipDevelopConstSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaEquipDevelopFlowSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaWeaponPartsUiSetting.lua",
		"zetadev/tpp/Assets/tpp/motherbase/ZetaWeaponPartsCombinationSettings.lua",
	}
}
if this.libraries ~= nil and next(this.libraries) then --Load Zeta
	for i,func in ipairs(this.libraries) do 
		if func ~= nil then
			if type(func) == "string" then 
				if string.match( func, "zetadev" ) then InfCore.LoadExternalLibrary(func) else InfCore.LoadLibrary(func) end
			elseif type(func) == "function" then func() end
		end
	end
end
return this