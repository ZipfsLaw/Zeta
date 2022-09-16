--ZetaStart.lua
--Description: The init script for Zeta.
local this={}
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
local loadLibraries = {
	--Native Override
	"/Assets/tpp/script/zeta/main/ZetaNativeOverride.lua",
	function()
		if ZetaNativeOverride ~= nil then ZetaNativeOverride.Reload() end
	end,
	--Zeta ( Modding Framework )
	"/Assets/tpp/script/zeta/main/ZetaCore.lua",
	"/Assets/tpp/script/zeta/main/ZetaUtil.lua",
	"/Assets/tpp/script/zeta/main/ZetaMenu.lua",
	"/Assets/tpp/script/zeta/main/ZetaVar.lua",
	"/Assets/tpp/script/zeta/main/ZetaIndex.lua",
	"/Assets/tpp/script/zeta/main/ZetaEnemy.lua",
	"/Assets/tpp/script/zeta/main/ZetaPlayer.lua",
	"/Assets/tpp/script/zeta/main/ZetaMission.lua",
	"/Assets/tpp/script/zeta/main/ZetaMessages.lua",
	--Overrides ( containing tables with vanilla values )
	"/Assets/tpp/script/zeta/lists/ZetaCommonPackList.lua", 
	"/Assets/tpp/script/zeta/lists/ZetaDemoBlockList.lua", 
	"/Assets/tpp/script/zeta/lists/ZetaMissionList.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaGrInit.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipIdTable.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipParameters.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipMotionDataForChimera.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaChimeraPartsPackageTable.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipParameterTables.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaDamageParameterTables.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipMotionData.lua",
	--"/Assets/tpp/script/zeta/overrides/ZetaSoldier2FaceAndBodyData.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaRecoilMaterialTable.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaPlayerParameters.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaCommonMotionPackage.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaMbmCommonSetting.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopConstSetting.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopFlowSetting.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsUiSetting.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsCombinationSettings.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaPlayerParts.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaBuddyParts.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaVehicleParts.lua",
	function()
		if ZetaCore ~= nil then ZetaCore.ReloadMods({reloadType=ZetaCore.reloadType.All,force=true}) end --Load all mods
	end
}
--Run startup as a coroutine to prevent any issues in loading
local function it()
	for i,func in ipairs(loadLibraries) do 
		if func ~= nil then
			if type(func) == "string" then InfCore.LoadLibrary(func) --Script.LoadLibrary(func) 
			elseif type(func) == "function" then func() end
			coroutine.yield()
		end
	end
end
do
	local co=coroutine.create(it)
	repeat
		local ok,ret=coroutine.resume(co)
		if not ok then error(ret) end
	until coroutine.status(co)=="dead"
end
return this