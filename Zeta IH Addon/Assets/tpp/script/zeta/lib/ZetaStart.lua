--ZetaStart.lua
--Description: Mimics TPP's booting process by loading Zeta's libraries in the same fashion.
local this={
	libraries = { 
		--Zeta, Modding Framework
		"/Assets/tpp/script/zeta/lib/ZetaDef.lua",
		"/Assets/tpp/script/zeta/lib/ZetaUtil.lua",
		"/Assets/tpp/script/zeta/lib/ZetaVar.lua",
		"/Assets/tpp/script/zeta/lib/ZetaCore.lua",
		"/Assets/tpp/script/zeta/lib/ZetaIndex.lua",
		"/Assets/tpp/script/zeta/lib/ZetaMenu.lua",
		"/Assets/tpp/script/zeta/lib/ZetaEnemy.lua",
		"/Assets/tpp/script/zeta/lib/ZetaPlayer.lua",
		"/Assets/tpp/script/zeta/lib/ZetaMission.lua",
		"/Assets/tpp/script/zeta/lib/ZetaMessages.lua",
		"/Assets/tpp/script/zeta/lib/ZetaNativeOverride.lua",
		--Parts and Lists
		"/Assets/tpp/script/zeta/lists/ZetaCommonPackList.lua", 
		"/Assets/tpp/script/zeta/lists/ZetaDemoBlockList.lua", 
		"/Assets/tpp/script/zeta/lists/ZetaMissionList.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaPlayerParts.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaBuddyParts.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaVehicleParts.lua",
		--Overrides ( containing tables with vanilla values )
		"/Assets/tpp/script/zeta/overrides/ZetaGrInit.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipIdTable.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipParameters.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipMotionDataForChimera.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaChimeraPartsPackageTable.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipParameterTables.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaDamageParameterTables.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipMotionData.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaSoldier2FaceAndBodyData.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaRecoilMaterialTable.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaPlayerParameters.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaCommonMotionPackage.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaMbmCommonSetting.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopConstSetting.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopFlowSetting.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsUiSetting.lua",
		"/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsCombinationSettings.lua",
		function()
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
			if type(func) == "string" then InfCore.LoadLibrary(func)
			elseif type(func) == "function" then func() end
		end
	end
end
return this