--ZetaNativeOverride.lua
local this={}

--Override Functions
function this.OverrideEquipDevelopConstSetting(path)
	if TppMotherBaseManagement == nil then return nil end
	
	--Create tables
	this.recCstDev = {}
				
	--Save native functions
	local regCstDev = TppMotherBaseManagement.RegCstDev	
				
	--Override functions
	TppMotherBaseManagement.RegCstDev = function(entry) table.insert( this.recCstDev, entry ) end	

	--Load native lua file
	if this.InfLoadLib ~= nil then this.InfLoadLib(path) end			

	--Revert native lua functions
	TppMotherBaseManagement.RegCstDev = regCstDev
				
	--Save recovered tables
	if EquipDevelopConstSetting ~= nil then
		if EquipDevelopConstSetting.equipDevTable == nil then
			EquipDevelopConstSetting.equipDevTable = this.recCstDev
		end
	end		
end

function this.OverrideWeaponPartsUiSetting(path)
	if TppMotherBaseManagement == nil then return nil end
	
	--Create tables
	this.recWepPartsInfo = {}	
				
	--Save native functions
	local registWeaponPartsInfo = TppMotherBaseManagement.RegistWeaponPartsInfo			
				
	--Override functions
	TppMotherBaseManagement.RegistWeaponPartsInfo = function(entry) table.insert( this.recWepPartsInfo, entry ) end	
				
	--Load native lua file
	if this.InfLoadLib ~= nil then this.InfLoadLib(path) end			
				
	--Revert native lua functions
	TppMotherBaseManagement.RegistWeaponPartsInfo = registWeaponPartsInfo
				
	--Save recovered tables
	if WeaponPartsUiSetting ~= nil then
		if WeaponPartsUiSetting.weaponPartsInfoTable == nil then
			WeaponPartsUiSetting.weaponPartsInfoTable = this.recWepPartsInfo
		end
	end	
end

function this.OverrideWeaponPartsCombinationSettings(path)
	if TppMotherBaseManagement == nil then return nil end
	
	--Create tables
	this.recWepComboFunc = {}
	this.recWepComboID = {}
	this.recWepComboPartsType = {}
	this.recWepComboPartsId = {}
				
	--Save native functions
	local regReceiverBase = TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase
	local regInclusionInfo = TppMotherBaseManagement.RegistPartsInclusionInfo
	local regBarrelBase = TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase
	local regUnderBarrelBase = TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase
	
	--Override functions
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase = function(entry) 
		table.insert( this.recWepComboFunc, 1 ) 
		table.insert( this.recWepComboID, entry.receiverID ) 
		table.insert( this.recWepComboPartsType, entry.partsType ) 
		table.insert( this.recWepComboPartsId, entry.partsIds ) 
	end	
	TppMotherBaseManagement.RegistPartsInclusionInfo = function(entry) 
		table.insert( this.recWepComboFunc, 2 ) 
		table.insert( this.recWepComboID, entry.receiverID ) 
		table.insert( this.recWepComboPartsType, entry.partsType ) 
		table.insert( this.recWepComboPartsId, entry.partsIds ) 
	end	
	TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase = function(entry) 
		table.insert( this.recWepComboFunc, 3 ) 
		table.insert( this.recWepComboID, entry.barrelID ) 
		table.insert( this.recWepComboPartsType, entry.partsType ) 
		table.insert( this.recWepComboPartsId, entry.partsIds ) 
	end	
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase = function(entry) 
		table.insert( this.recWepComboFunc, 4 ) 
		table.insert( this.recWepComboID, entry.receiverID ) 
		table.insert( this.recWepComboPartsType, entry.partsType ) 
		table.insert( this.recWepComboPartsId, entry.partsIds ) 
	end	
				
	--Load native lua file
	if this.InfLoadLib ~= nil then this.InfLoadLib(path) end			
				
	--Revert native lua functions
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase = regReceiverBase
	TppMotherBaseManagement.RegistPartsInclusionInfo = regInclusionInfo
	TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase = regBarrelBase
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase = regUnderBarrelBase
	
	--Save recovered tables
	if WeaponPartsCombinationSettings ~= nil then
		if WeaponPartsCombinationSettings.funcTable == nil then
			WeaponPartsCombinationSettings.funcTable = this.recWepComboFunc
			WeaponPartsCombinationSettings.idTable = this.recWepComboID
			WeaponPartsCombinationSettings.partsTypeTable = this.recWepComboPartsType
			WeaponPartsCombinationSettings.partsIdTable = this.recWepComboPartsId
		end
	end	
end

function this.OverrideChimeraPartsPackageTable(path)
	if TppEquip == nil then return nil end
	
	--Create tables
	this.recChimPartsPacks = {}
				
	--Save native functions
	local regChimPartsPacks = TppEquip.ReloadChimeraPartsInfoTable
				
	--Override functions
	TppEquip.ReloadChimeraPartsInfoTable = function(...)
		local arg = {...}	
		this.recChimPartsPacks = arg[1]
	end	

	--Load native lua file
	InfCore.DoFile(path)				

	--Revert native lua functions
	TppEquip.ReloadChimeraPartsInfoTable = regChimPartsPacks
				
	--Save recovered tables
	if ChimeraPartsPackageTable ~= nil then
		if ChimeraPartsPackageTable.chimeraPartsInfoTable == nil then
			ChimeraPartsPackageTable.chimeraPartsInfoTable = this.recChimPartsPacks
		end
	end		
end

--Overrides InfCore.LoadLibrary
this.InfLoadLib = nil
this.vanillaFileList = {
	{ "/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua", "/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopConstSetting.lua", this.OverrideEquipDevelopConstSetting },
	{ "/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua", "/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsUiSetting.lua", this.OverrideWeaponPartsUiSetting },
	{ "/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua", "/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsCombinationSettings.lua", this.OverrideWeaponPartsCombinationSettings },
	{ "Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua", nil, this.OverrideChimeraPartsPackageTable },
}
function this.LoadLibrary(path)
	for i,vPath in ipairs(this.vanillaFileList)do   
		if vPath[1] == path then
			vPath[3](path) --Recover values and override	
			path = vPath[2]
		end
	end
	if path ~= nil then
		if this.InfLoadLib ~= nil then 
			this.InfLoadLib(path) 
		end
	end
end

--Add functions to dummy lua module.
function this.SetupBackwardsCompatibility(zetamodule)
	if zetamodule == nil then return nil end
	zetamodule.ChimeraPartsInfoTable = function(gamemodule)
		if gamemodule == nil then return nil end
		if ChimeraPartsPackageTable ~= nil then
			local origTable = ChimeraPartsPackageTable.chimeraPartsInfoTable
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.packageInfosTable = origTable.packageInfos
				gamemodule.barrelTable = origTable.barrel
				gamemodule.magazineTable = origTable.magazine
				gamemodule.muzzleOptionTable = origTable.muzzleOption 
				gamemodule.muzzleTable = origTable.muzzle
				gamemodule.optionTable = origTable.option
				gamemodule.receiverTable = origTable.receiver 
				gamemodule.sightTable = origTable.sight
				gamemodule.stockTable = origTable.stock 
				gamemodule.underBarrelTable = origTable.underBarrel 
				gamemodule.colorTable = origTable.color 
			end
		end
	end
	
	zetamodule.DamageParameterTable = function(gamemodule)
		if gamemodule == nil then return nil end
		if DamageParameterTables ~= nil then
			local origTable = DamageParameterTables.DamageParameter
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.DamageParameterTable = origTable
			end
		end
	end
	
	zetamodule.EquipDevelopConstSetting = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipDevelopConstSetting ~= nil then
			local origTable =  EquipDevelopConstSetting.equipDevTable
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.equipDevTable = origTable
			end
		end	
	end
	
	zetamodule.EquipDevelopFlowSetting = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipDevelopFlowSetting ~= nil then
			local nativeTable = EquipDevelopFlowSetting.equipDevTable
			if nativeTable ~= nil and next(nativeTable) then
				nativeTable = ZetaUtil.CopyFrom( nativeTable )
				gamemodule.equipDevTable = nativeTable
			end
		end	
	end
	
	zetamodule.EquipIdTable = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipIdTable ~= nil then
			local origTable = EquipIdTable.equipTable
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.equipIdTable = origTable
			end
		end
	end
	
	zetamodule.EquipMotionData = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipMotionData ~= nil then
			local origTable = EquipMotionData.equipMotionData
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.NewMotionDataTable = origTable.MotionDataTable
			end
		end
	end
	
	zetamodule.EquipParameters = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipParameters ~= nil then
			local origTable = EquipParameters.equipParameterTables
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.gunBasicTable = origTable.gunBasic 
				gamemodule.receiverParamSetsBaseTable = origTable.receiverParamSetsBase 
				gamemodule.receiverParamSetsWobblingTable = origTable.receiverParamSetsWobbling 
				gamemodule.receiverParamSetsSystemTable = origTable.receiverParamSetsSystem 
				gamemodule.receiverParamSetsSoundTable = origTable.receiverParamSetsSound
				gamemodule.receiverTable = origTable.receiver 
				gamemodule.barrelParamSetsBaseTable = origTable.barrelParamSetsBase 
				gamemodule.barrelTable = origTable.barrel 
				gamemodule.magazineTable = origTable.magazine 
				gamemodule.muzzleOptionTable = origTable.muzzleOption 
				gamemodule.optionTable = origTable.option 
				gamemodule.sightTable = origTable.sight 
				gamemodule.stockTable = origTable.stock 
				gamemodule.underBarrelTable = origTable.underBarrel 
				gamemodule.bulletParamSetsBaseTable = origTable.bulletParamSetsBase 
				gamemodule.bulletTrailEffectListTable = origTable.bulletTrailEffectList 
				gamemodule.bulletTable = origTable.bullet 
			end
		end
	end
	
	zetamodule.EquipParameterTables = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipParameterTables ~= nil then
			local origTable = EquipParameterTables.equipParameterTables
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.BlastParameterTable = origTable.BlastParameter
				gamemodule.SupportWeaponParameterTable = origTable.SupportWeaponParameter
			end
		end
	end
	
	zetamodule.WeaponPartsCombinationSettingsTable = function(gamemodule)
		if gamemodule == nil then return nil end
		if WeaponPartsCombinationSettings ~= nil then
			if WeaponPartsCombinationSettings.funcTable ~= nil then
				gamemodule.funcTable = ZetaUtil.CopyFrom( WeaponPartsCombinationSettings.funcTable )
				gamemodule.idTable = ZetaUtil.CopyFrom( WeaponPartsCombinationSettings.idTable )
				gamemodule.partsTypeTable = ZetaUtil.CopyFrom( WeaponPartsCombinationSettings.partsTypeTable )
				gamemodule.partsIdTable = ZetaUtil.CopyFrom( WeaponPartsCombinationSettings.partsIdTable )
			end
		end	
	end
	
	zetamodule.WeaponPartsUiSetting = function(gamemodule)
		if gamemodule == nil then return nil end
		if WeaponPartsUiSetting ~= nil then
			local origTable = WeaponPartsUiSetting.weaponPartsInfoTable
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.WeaponPartsInfoTable = origTable
			end
		end	
	end
	
	zetamodule.PlayerCamoufTable = function(gamemodule)
		if gamemodule == nil then return nil end
		if player2_camouf_param ~= nil then
			local origTable = player2_camouf_param.camoTable
			if origTable ~= nil and next(origTable) then
				origTable = ZetaUtil.CopyFrom( origTable )
				gamemodule.playerCamoufTable = origTable 
			end
		end
	end
end

return this