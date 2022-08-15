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
--RecoilMaterialTable.lua
--Player2_camouf_param.lua
--TppPlayer2InitializeScript.lua
--EquipDevelopConstSetting.lua
--EquipDevelopFlowSetting.lua
--WeaponPartsUiSetting.lua
--WeaponPartsCombinationSettings.lua
local loadLibraries = {
	--Core
	"/Assets/tpp/script/zeta/main/ZetaCore.lua",
	"/Assets/tpp/script/zeta/main/ZetaNativeOverride.lua",
	"/Assets/tpp/script/zeta/main/ZetaMenu.lua",
	"/Assets/tpp/script/zeta/main/ZetaUtil.lua",
	"/Assets/tpp/script/zeta/main/ZetaVar.lua",
	--Index and load mods
	"/Assets/tpp/script/zeta/main/ZetaIndex.lua",
	function() 
		if ZetaIndex ~= nil then
			ZetaIndex.LoadAllModFiles()
		end
		if ZetaNativeOverride ~= nil then
			ZetaNativeOverride.InfLoadLib = InfCore.LoadLibrary
			InfCore.LoadLibrary = ZetaNativeOverride.LoadLibrary
			ZetaNativeOverride.InfDoFile = InfCore.DoFile
			InfCore.DoFile = ZetaNativeOverride.DoFile		
		end
	end,
	--Load API
	"/Assets/tpp/script/zeta/main/ZetaEnemy.lua",
	"/Assets/tpp/script/zeta/main/ZetaPlayer.lua",
	"/Assets/tpp/script/zeta/main/ZetaMission.lua",
	"/Assets/tpp/script/zeta/main/ZetaMessages.lua",
	--Load lists
	"/Assets/tpp/script/zeta/lists/ZetaCommonPackList.lua", 
	"/Assets/tpp/script/zeta/lists/ZetaDemoBlockList.lua", 
	"/Assets/tpp/script/zeta/lists/ZetaMissionList.lua",
	--TPP Overrides
	"/Assets/tpp/script/zeta/overrides/ZetaGrInit.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipIdTable.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipParameters.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipMotionDataForChimera.lua",
	"Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua", --Workaround
	"/Assets/tpp/script/zeta/overrides/ZetaChimeraPartsPackageTable.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipParameterTables.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaDamageParameterTables.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipMotionData.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaRecoilMaterialTable.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaPlayerParameters.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaCommonMotionPackage.lua",
	--"/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopConstSetting.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopFlowSetting.lua",
	--"/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsUiSetting.lua",
	--"/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsCombinationSettings.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaPlayerParts.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaBuddyParts.lua",
	"/Assets/tpp/script/zeta/overrides/ZetaVehicleParts.lua",
}

--Run startup
function this.StartFunc(func)
	if func ~= nil then
		if type(func) == "string" then InfCore.LoadLibrary(func) --Script.LoadLibrary(func) 
		elseif type(func) == "function" then func() end
	end
end
for i,func in ipairs(loadLibraries) do this.StartFunc(func) end

return this