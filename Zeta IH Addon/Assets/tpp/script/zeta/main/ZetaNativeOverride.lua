--ZetaNativeOverride.lua
--Description: Provides backwards compatibility for older mods by hijacking functions to retrieve their input variables.
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
	this.recWepComboSettings = {}
				
	--Save native functions
	local regNativeFuncs = {
		receiverBase = TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase,
		inclusionInfo = TppMotherBaseManagement.RegistPartsInclusionInfo,
		barrelBase = TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase,
		underBarrelBase = TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase,
	}
	
	--Override functions
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase = function(entry) 
		local newEntry = { func=1,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds }		
		table.insert( this.recWepComboSettings, newEntry ) 
	end	
	TppMotherBaseManagement.RegistPartsInclusionInfo = function(entry) 
		local newEntry = { func=2,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds }		
		table.insert( this.recWepComboSettings, newEntry )
	end	
	TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase = function(entry) 
		local newEntry = { func=3,barrelID=entry.barrelID,partsType=entry.partsType,partsIds=entry.partsIds }		
		table.insert( this.recWepComboSettings, newEntry )
	end	
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase = function(entry) 
		local newEntry = { func=4,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds }		
		table.insert( this.recWepComboSettings, newEntry )
	end	
				
	--Load native lua file
	if this.InfLoadLib ~= nil then this.InfLoadLib(path) end			
				
	--Revert native lua functions
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase = regNativeFuncs.receiverBase
	TppMotherBaseManagement.RegistPartsInclusionInfo = regNativeFuncs.inclusionInfo
	TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase = regNativeFuncs.barrelBase
	TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase = regNativeFuncs.underBarrelBase

	--Save recovered tables
	if WeaponPartsCombinationSettings ~= nil then
		if WeaponPartsCombinationSettings.weaponPartsCombinationSettings == nil then
			WeaponPartsCombinationSettings.weaponPartsCombinationSettings=this.recWepComboSettings
		end
	end	
end

function this.OverrideMbmCommonSettings(path)
	if TppMotherBaseManagement == nil then return nil end
	
	--Create tables
	this.recTppMBMSetting = {}

	--Native functions in MbmCommonSetting
	local keyFuncs = {
		RegisterStaffTypePeaks = { param = "staffTypePeaks", entries=true},
		RegisterRandomRange = { param = "randomRanges", entries=true},
		RegisterStaffBaseRankRange = { param = "staffBaseRankRanges", entries=true},
		RegisterStaffMinBaseRank = { param = "staffMinBaseRankParam" },
		RegisterSectionLvLine = { param = "sectionLvLines", entries=true},
		RegisterSkillDrawingParam = { param = "skillDrawingParams", entries=true},
		SortSkillDrawingParamTable = nil,
		RegisterQuestSkillDrawingParam = { param = "questSkillDrawingParams", entries=true},
		SortQuestSkillDrawingParamTable = nil,
		RegisterUniqueStaff = { param = "uniqueStaff", entries=true},
		RegisterMissionBaseStaffTypes = { param = "missionBaseStaffTypes", entries=true},
		RegisterBaseInitEnmityParam = { param = "baseInitEnmityParams", entries=true},
		RegisterInitEnmityOffset = { param = "initEnmityOffsetParams" },
		RegisterTimeMinutePer1Enmity = { param = "timeMinutePer1Enmitys", entries=true},
		RegisterMoraleParam = { param = "moralParams" },
		RegisterMedalParam = { param = "medalParams" },
		RegisterLanguageParam = { param = "languageParams" },
		RegisterPandemicParam = { param = "pandemicParams" },
		RegisterOgreUserVolunteerStaffParam = { param = "ogreUserVolunteerStaffParams" },
		RegisterOgreUserVolunteerStaffTypes = { param = "ogreUserVolunteerStaffTypes", entries=true},
		RegisterCommonVolunteerStaffHeroicParam = { param = "commonVolunteerStaffHeroicParams", entries=true},
		RegisterCommonVolunteerStaffOgreParam = { param = "commonVolunteerStaffOgreParams", entries=true},
		RegisterCommonVolunteerStaffClearTimeParam = { param = "commonVolunteerStaffClearTimeParams", entries=true},
	}
	
	--Save native functions
	local regNativeFuncs = {}
	for func,Val in pairs(keyFuncs)do
		regNativeFuncs[func] = TppMotherBaseManagement[func] 
	end 

	--Override functions
	for func,Val in pairs(keyFuncs)do
		if Val ~= nil then
			if Val.entries == true then
				if this.recTppMBMSetting[Val.param] == nil then
					this.recTppMBMSetting[Val.param] = {}
				end
				TppMotherBaseManagement[func] = function(entry)
					table.insert( this.recTppMBMSetting[Val.param], entry )
				end
			else
				TppMotherBaseManagement[func] = function(entry)
					this.recTppMBMSetting[Val.param] = entry
				end
			end
		else
			TppMotherBaseManagement[func] = function()end
		end
	end 

	--Load native lua file
	if this.InfLoadLib ~= nil then this.InfLoadLib(path) end			
				
	--Revert native lua functions
	for func,Val in pairs(keyFuncs)do
		TppMotherBaseManagement[func] = regNativeFuncs[func] 
	end 

	--Save recovered tables
	if MbmCommonSetting ~= nil then
		if MbmCommonSetting.MbmCommonSettingTable == nil then
			MbmCommonSetting.MbmCommonSettingTable=this.recTppMBMSetting
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
this.vanillaLibList = {
	{ "/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua", "/Assets/tpp/script/zeta/overrides/ZetaEquipDevelopConstSetting.lua", this.OverrideEquipDevelopConstSetting },
	{ "/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua", "/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsUiSetting.lua", this.OverrideWeaponPartsUiSetting },
	{ "/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua", "/Assets/tpp/script/zeta/overrides/ZetaWeaponPartsCombinationSettings.lua", this.OverrideWeaponPartsCombinationSettings },
	{ "/Assets/tpp/motherbase/script/MbmCommonSetting.lua", "/Assets/tpp/script/zeta/overrides/ZetaMbmCommonSetting.lua", this.OverrideMbmCommonSettings },
	{ "Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua", nil, this.OverrideChimeraPartsPackageTable },
}
function this.LoadLibrary(path)
	for i,vPath in ipairs(this.vanillaLibList)do   
		if vPath[1] == path then
			if vPath[3] ~= nil then 
				vPath[3](path) --Recover values and override	
			end
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
	
	zetamodule.ChimeraPartsInfoTableEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if ChimeraPartsPackageTable ~= nil then 
			if ChimeraPartsPackageTable.chimeraPartsInfoTable ~= nil then
				gamemodule.chimeraPartsInfo = ZetaUtil.CopyFrom( ChimeraPartsPackageTable.chimeraPartsInfoTable )
			end
		end
	end
	
	zetamodule.DamageParameterTableEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if DamageParameterTables ~= nil then
			 if DamageParameterTables.DamageParameter ~= nil then
			 	gamemodule.DamageParameterTable = ZetaUtil.CopyFrom( DamageParameterTables.DamageParameter )
			 end
		end
	end
	
	zetamodule.EquipDevelopConstSettingEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipDevelopConstSetting ~= nil then 
			if EquipDevelopConstSetting.equipDevTable ~= nil then
				gamemodule.equipDevTable = ZetaUtil.CopyFrom( EquipDevelopConstSetting.equipDevTable ) 
			end
		end	
	end
	
	zetamodule.EquipDevelopFlowSettingEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipDevelopFlowSetting ~= nil then 
			if EquipDevelopFlowSetting.equipDevTable ~= nil then
				gamemodule.equipDevTable = ZetaUtil.CopyFrom( EquipDevelopFlowSetting.equipDevTable ) 
			end
		end	
	end
	
	zetamodule.EquipIdTableEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipIdTable ~= nil then 
			if EquipIdTable.equipTable ~= nil then
				gamemodule.equipIdTable = ZetaUtil.CopyFrom( EquipIdTable.equipTable ) 
			end
		end	
	end
	
	zetamodule.EquipMotionDataEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipMotionData ~= nil then
			if EquipMotionData.equipMotionData ~= nil then
				gamemodule.NewMotionDataTable = ZetaUtil.CopyFrom( EquipMotionData.equipMotionData )
			end
		end
	end
	
	zetamodule.EquipParametersEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipParameters ~= nil then
			if EquipParameters.equipParameterTables ~= nil then
				gamemodule.equipParameters = ZetaUtil.CopyFrom(EquipParameters.equipParameterTables)
			end
		end
	end
	
	zetamodule.EquipParameterTablesEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if EquipParameterTables ~= nil then 
			if EquipParameterTables.equipParameterTables ~= nil then
				gamemodule.equipParameterTables = ZetaUtil.CopyFrom( EquipParameterTables.equipParameterTables)
			end
		end
	end
	
	zetamodule.WeaponPartsCombinationSettingsTableEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if WeaponPartsCombinationSettings ~= nil then 
			if WeaponPartsCombinationSettings.weaponPartsCombinationSettings ~= nil then
				gamemodule.partCombinationTable = ZetaUtil.CopyFrom(WeaponPartsCombinationSettings.weaponPartsCombinationSettings)
			end
		end	
	end
	
	zetamodule.WeaponPartsUiSettingEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if WeaponPartsUiSetting ~= nil then 
			if WeaponPartsUiSetting.weaponPartsInfoTable ~= nil then
				gamemodule.WeaponPartsInfoTable = ZetaUtil.CopyFrom(WeaponPartsUiSetting.weaponPartsInfoTable)
			end
		end	
	end
	
	zetamodule.PlayerCamoufTable = function(gamemodule)
		if gamemodule == nil then return nil end
		if player2_camouf_param ~= nil then
			local origTable = player2_camouf_param.camoTable
			if origTable ~= nil and next(origTable) then
				gamemodule.playerCamoufTable = ZetaUtil.CopyFrom( origTable ) 
			end
		end
	end

	zetamodule.MbmCommonSettingEvent = function(gamemodule)
		if gamemodule == nil then return nil end
		if MbmCommonSetting ~= nil then
			if MbmCommonSetting.MbmCommonSettingTable ~= nil then
				gamemodule.MbmCommonSettingTable = ZetaUtil.CopyFrom( MbmCommonSetting.MbmCommonSettingTable)
			end
		end	
	end
end

return this