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
		"zetadev/tpp/ZetaGr_init_dx11.lua",
		function()
			if ZetaIndex ~= nil then ZetaIndex.LoadAllModFiles() end
			if ZetaCore ~= nil then ZetaCore.ReloadMods({force=true,reloadMods=false,reloadType=ZetaCore.ReloadType.Graphics}) end
			if ZetaIH ~= nil then ZetaIH.Reload() end
		end,
		--Zeta Modules
		"zetadev/lib/ZetaEnemy.lua",
		"zetadev/lib/ZetaPlayer.lua",
		"zetadev/lib/ZetaMission.lua",
		"zetadev/lib/ZetaMessages.lua",
		"zetadev/lib/ZetaPlayerParts.lua",
		"zetadev/lib/ZetaBuddyParts.lua",
		"zetadev/lib/ZetaVehicleParts.lua",
		"zetadev/lib/ZetaDemoBlockList.lua", 
		"zetadev/lib/ZetaMissionList.lua",
		"zetadev/tpp/ZetaCommonPackList.lua", 
		"zetadev/tpp/ZetaEquipIdTable.lua",
		"zetadev/tpp/ZetaEquipParameters.lua",
		"zetadev/tpp/ZetaEquipMotionDataForChimera.lua",
		"zetadev/tpp/ZetaChimeraPartsPackageTable.lua",
		"zetadev/tpp/ZetaEquipParameterTables.lua",
		"zetadev/tpp/ZetaDamageParameterTables.lua",
		"zetadev/tpp/ZetaEquipMotionData.lua",
		"zetadev/tpp/ZetaRecoilMaterialTable.lua",
		"zetadev/tpp/ZetaPlayerParameters.lua",
		"zetadev/tpp/ZetaCommonMotionPackage.lua",
		"zetadev/tpp/ZetaMbmCommonSetting.lua",
		"zetadev/tpp/ZetaMbmCommonSetting20BaseResSec.lua",
		"zetadev/tpp/ZetaMbmCommonSetting30Deploy.lua",
		"zetadev/tpp/ZetaMbmCommonSetting40RewardDeploy.lua",
		"zetadev/tpp/ZetaMbmCommonSetting50RewardFob.lua",
		"zetadev/tpp/ZetaMbmCommonSetting60DbPfLang.lua",
		"zetadev/tpp/ZetaEquipDevelopConstSetting.lua",
		"zetadev/tpp/ZetaEquipDevelopFlowSetting.lua",
		"zetadev/tpp/ZetaWeaponPartsUiSetting.lua",
		"zetadev/tpp/ZetaWeaponPartsCombinationSettings.lua",
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