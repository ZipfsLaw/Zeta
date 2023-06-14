--ZetaNativeOverride.lua
--Description: Provides backwards compatibility for older mods by overriding native functions to retrieve their input variables.
local this={
	imported = {},
	cachedNatives = {},
}
--luaScript: Filepath of native lua script
--func: Native lua function you wish to override
--tab: Local table name for imported values and Zeta libraries
--set: If "true", sets values instead of inserts into table. If string/number, sets key/index of table. If function, overrides native functions
this.natives = {
	{
		luaScript="/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua",
		overrides={{func="TppMotherBaseManagement.RegCstDev",tab="equipDevTableCst"}},
	},
	{
		luaScript="/Assets/tpp/motherbase/script/EquipDevelopFlowSetting.lua",
		overrides={{func="TppMotherBaseManagement.RegFlwDev",tab="equipDevTableFlw"}},
	},
	{
		luaScript="/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua",
		overrides={{func="TppMotherBaseManagement.RegistWeaponPartsInfo",tab="WeaponPartsInfoTable"}},
	},
	{
		luaScript="/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua",
		overrides={
			{func="TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverBase",tab="partCombinationTable",set=function(entry) 	
				table.insert( this.imported.partCombinationTable, { func=1,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds } ) 
			end},
			{func="TppMotherBaseManagement.RegistPartsInclusionInfo",tab="partCombinationTable",set=function(entry) 
				table.insert( this.imported.partCombinationTable, { func=2,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds } )
			end},
			{func="TppMotherBaseManagement.RegistPartsInclusionInfo_BarrelBase",tab="partCombinationTable",set=function(entry) 	
				table.insert( this.imported.partCombinationTable, { func=3,barrelID=entry.barrelID,partsType=entry.partsType,partsIds=entry.partsIds } )
			end},
			{func="TppMotherBaseManagement.RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase",tab="partCombinationTable",set=function(entry) 	
				table.insert( this.imported.partCombinationTable, { func=4,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds } )
			end},
		},
	},
	{	
		luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting.lua",
		overrides={
			{func="TppMotherBaseManagement.RegisterStaffTypePeaks",tab="MbmCommonSettingTable.staffTypePeaks"},
			{func="TppMotherBaseManagement.RegisterRandomRange",tab="MbmCommonSettingTable.randomRanges",},
			{func="TppMotherBaseManagement.RegisterStaffBaseRankRange",tab="MbmCommonSettingTable.staffBaseRankRanges"},
			{func="TppMotherBaseManagement.RegisterStaffMinBaseRank",set=true,tab="MbmCommonSettingTable.staffMinBaseRankParam"},
			{func="TppMotherBaseManagement.RegisterSectionLvLine",tab="MbmCommonSettingTable.sectionLvLines"},
			{func="TppMotherBaseManagement.RegisterSkillDrawingParam",tab="MbmCommonSettingTable.skillDrawingParams"},
			{func="TppMotherBaseManagement.SortSkillDrawingParamTable",tab="MbmCommonSettingTable",set=function()end},
			{func="TppMotherBaseManagement.RegisterQuestSkillDrawingParam",tab="MbmCommonSettingTable.questSkillDrawingParams"},
			{func="TppMotherBaseManagement.SortQuestSkillDrawingParamTable",tab="MbmCommonSettingTable",set=function()end},
			{func="TppMotherBaseManagement.RegisterUniqueStaff",tab="MbmCommonSettingTable.uniqueStaff"},
			{func="TppMotherBaseManagement.RegisterMissionBaseStaffTypes",tab="MbmCommonSettingTable.missionBaseStaffTypes"},
			{func="TppMotherBaseManagement.RegisterBaseInitEnmityParam",tab="MbmCommonSettingTable.baseInitEnmityParams"},
			{func="TppMotherBaseManagement.RegisterInitEnmityOffset",set=true,tab="MbmCommonSettingTable.initEnmityOffsetParams"},
			{func="TppMotherBaseManagement.RegisterTimeMinutePer1Enmity",tab="MbmCommonSettingTable.timeMinutePer1Enmitys"},
			{func="TppMotherBaseManagement.RegisterMoraleParam",set=true,tab="MbmCommonSettingTable.moralParams"},
			{func="TppMotherBaseManagement.RegisterMedalParam",set=true,tab="MbmCommonSettingTable.medalParams"},
			{func="TppMotherBaseManagement.RegisterLanguageParam",set=true,tab="MbmCommonSettingTable.languageParams"},
			{func="TppMotherBaseManagement.RegisterPandemicParam",set=true,tab="MbmCommonSettingTable.pandemicParams"},
			{func="TppMotherBaseManagement.RegisterOgreUserVolunteerStaffParam",set=true,tab="MbmCommonSettingTable.ogreUserVolunteerStaffParams"},
			{func="TppMotherBaseManagement.RegisterOgreUserVolunteerStaffTypes",tab="MbmCommonSettingTable.ogreUserVolunteerStaffTypes",},
			{func="TppMotherBaseManagement.RegisterCommonVolunteerStaffHeroicParam",tab="MbmCommonSettingTable.commonVolunteerStaffHeroicParams"},
			{func="TppMotherBaseManagement.RegisterCommonVolunteerStaffOgreParam",tab="MbmCommonSettingTable.commonVolunteerStaffOgreParams"},
			{func="TppMotherBaseManagement.RegisterCommonVolunteerStaffClearTimeParam",tab="MbmCommonSettingTable.commonVolunteerStaffClearTimeParams"},
		}
	},
	{
		luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting20BaseResSec.lua",
		overrides={
			{func="TppMotherBaseManagement.RegisterCommandClusterBuildParam",tab="MbmCommonSetting20BaseResSecTable.buildParams"},
			{func="TppMotherBaseManagement.RegisterSectionClusterBuildParam",tab="MbmCommonSetting20BaseResSecTable.buildParams"},
			{func="TppMotherBaseManagement.SetSmallDiamondGmp",tab="MbmCommonSetting20BaseResSecTable.diamondGMPs.small", set="gmp" },
			{func="TppMotherBaseManagement.SetLargeDiamondGmp",tab="MbmCommonSetting20BaseResSecTable.diamondGMPs.large", set="gmp" },
			{func="TppMotherBaseManagement.RegisterResourceBaseExtractingTimeMinute",tab="MbmCommonSetting20BaseResSecTable.extractingTimeMinute", set="timeMinute" },
			{func="TppMotherBaseManagement.RegisterContainerParam",set=true,tab="MbmCommonSetting20BaseResSecTable.containerParams"},
			{func="TppMotherBaseManagement.RegisterResourceParam",tab="MbmCommonSetting20BaseResSecTable.resourceParams"},
			{func="TppMotherBaseManagement.RegisterStageGimmickParam",tab="MbmCommonSetting20BaseResSecTable.gimmickParams"},
			{func="TppMotherBaseManagement.RegisterSectionFuncRankLines",tab="MbmCommonSetting20BaseResSecTable.rankLines"},
			{func="TppMotherBaseManagement.RegisterCombatSectionFuncAutoGmp",set=true,tab="MbmCommonSetting20BaseResSecTable.autoGmp"},
			{func="TppMotherBaseManagement.RegisterAutoResourceParam",tab="MbmCommonSetting20BaseResSecTable.autoResourceParams"},
			{func="TppMotherBaseManagement.RegisterContainerProcessingParam",tab="MbmCommonSetting20BaseResSecTable.containerProcessingParams"},
			{func="TppMotherBaseManagement.RegisterContainerProcessingBasicParam",set=true,tab="MbmCommonSetting20BaseResSecTable.containerProcessingBasicParams"},
			{func="TppMotherBaseManagement.RegisterMedicalSectionFuncTreatmentParam",set=true,tab="MbmCommonSetting20BaseResSecTable.medicalSectionFuncTreatmentParams"},
			{func="TppMotherBaseManagement.RegisterBaseDevSectionFuncPlatformExtentionParam",set=true,tab="MbmCommonSetting20BaseResSecTable.baseDevSectionFuncPlatformExtentionParams"},
		}
	},
	{
		luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting30Deploy.lua",
		overrides={
			{func="TppMotherBaseManagement.RegisterDeployBasicParam",set=true,tab="MbmCommonSetting30DeployTable.deployBasicParams"},
			{func="TppMotherBaseManagement.RegisterDeployMissionParam",tab="MbmCommonSetting30DeployTable.deployMissionParams"},
		}
	},
	{
		luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting40RewardDeploy.lua",
		overrides={{func="TppMotherBaseManagement.RegisterDeployMissionParam",tab="MbmCommonSetting40RewardDeployTable"},}
	},
	{
		luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting50RewardFob.lua",
		overrides={
			{func="TppMotherBaseManagement.RegisterFobDefensePenaltyGmpParam",set=true,tab="MbmCommonSetting50RewardFobTable.fobDefensePenaltyGmpParam"},
			{func="TppMotherBaseManagement.RegisterPoolRewardParam",tab="MbmCommonSetting50RewardFobTable.poolRewardParams"},
			{func="TppMotherBaseManagement.RegisterStaffRankBonusTable",set=true,tab="MbmCommonSetting50RewardFobTable.staffRankBonusTable"},
		}
	},
	{
		luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting60DbPfLang.lua",
		overrides={
			{func="TppMotherBaseManagement.RegisterS10240LockStaffParam",set=true,tab="MbmCommonSetting60DbPfLangTable.s10240LockStaffParams"},
			{func="TppMotherBaseManagement.RegisterAnimalParam",tab="MbmCommonSetting60DbPfLangTable.animalParams"},
			{func="TppMotherBaseManagement.RegisterMissionGettableDesign",tab="MbmCommonSetting60DbPfLangTable.missionDesigns"},
			{func="TppMotherBaseManagement.RegisterFobSecurityCostParam",set=true,tab="MbmCommonSetting60DbPfLangTable.fobSecurityCostParams"},
			{func="TppMotherBaseManagement.RegisterSecurityCostPerUnit",set=true,tab="MbmCommonSetting60DbPfLangTable.securityCostPerUnits"},
			{func="TppMotherBaseManagement.RegisterPfRatingPointParam",tab="MbmCommonSetting60DbPfLangTable.pfRatingPointParams"},
			{func="TppMotherBaseManagement.RegisterStaffInitLangParam",tab="MbmCommonSetting60DbPfLangTable.staffInitLangParams"},
			{func="TppMotherBaseManagement.RegisterSupportAttackGmpCostTable",set=true,tab="MbmCommonSetting60DbPfLangTable.supportAttackGmpCostTable"},
		}
	},
	{
		luaScript="Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua",
		overrides={{func="TppEquip.ReloadChimeraPartsInfoTable",set=true,tab="chimeraPartsInfo"}}
	},
	{
		luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipParameters.lua",
		overrides={{func="TppEquip.ReloadEquipParameterTables2",set=true,tab="equipParameters"}}
	},
	{
		luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/EquipParameterTables.lua",
		overrides={{func="TppEquip.ReloadEquipParameterTables",set=true,tab="equipParameterTables"}}
	},
	{
		luaScript="Tpp/Scripts/Equip/EquipIdTable.lua",
		overrides={{func="TppEquip.ReloadEquipIdTable",set=true,tab="equipIdTable"}}
	},
	{
		luaScript="Tpp/Scripts/Equip/EquipMotionData.lua",
		overrides={{func="TppEquip.ReloadEquipMotionData", tab="motionDataTable", set="MotionDataTable" }}
	},
	{
		luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipMotionDataForChimera.lua",
		overrides={{func="TppEquip.ReloadEquipMotionData2",set=true,tab="equipMotionDataForChimera"}}
	},
	{
		luaScript="/Assets/tpp/level_asset/damage/ParameterTables/DamageParameterTables.lua",
		overrides={{func="TppDamage.ReloadDamageParameter", tab="DamageParameterTable", set="DamageParameter" }}
	},
	{
		luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua",
		overrides={{func="TppBullet.ReloadRecoilMaterials", set=true,tab="recoilMaterialsParameters"}}
	},
	{
		luaScript="/Assets/tpp/level_asset/chara/player/game_object/TppPlayer2InitializeScript.lua",
		functionName = "PlayerCameraAnimation",
		overrides={
			{func="Player.RegisterScriptFunc",tab="playerCallbackFuncs",set=function(path,entries)
				this.imported.playerCallBackScriptPath = path
				this.imported.playerCallbackFuncs = entries 
			end},
			{func="Player.RegisterCameraAnimationFilePaths",set=true,tab="cameraAnimationFilePaths"},
		}
	},
}
--Purpose: Blacklist implemented in InfCore.LoadLibrary ( see above )
function this.IsScriptInBlackList(luaScript) 
	for x,nativeScript in ipairs(this.natives)do
		if string.match( luaScript, nativeScript.luaScript ) then return true end
	end 
	return false
end
function this.LoadLibrary(path)
	if this.IsScriptInBlackList(path) == false then
		if this.InfLoadLib ~= nil then this.InfLoadLib(path) end --Run file	
	end
end
function this.Init()
	this.InfPCallFunc = InfCore.PCall
	this.InfLoadLib = InfCore.LoadLibrary
	InfCore.LoadLibrary = this.LoadLibrary
end
--Purpose: Overrides functions and scripts listed in 'this.natives'
function this.Reload()
	InfCore.PCall = function()end
	for x,nativeScript in ipairs(this.natives)do
		for y,override in ipairs(nativeScript.overrides)do
			local overrideTable = ZetaUtil.StringToTable(override.tab, this.imported)
			local newOverride = function(entry) table.insert( overrideTable, entry ) end  --Insert entry into table
			if override.set ~= nil then --Does this override use another function?
				local typeOfSet = type(override.set)
				if override.set == true then --Instead of inserting into table, it replaces the latest table found
					newOverride = function(entry) ZetaUtil.StringToTable(override.tab, this.imported, entry ) end 
				elseif typeOfSet == "string" or typeOfSet == "number" then --Set param could be a key or index
					newOverride = function(entry) ZetaUtil.StringToTable(override.tab, this.imported, entry[override.set] ) end 
				elseif typeOfSet == "function" then newOverride = override.set end --Set param is a function that sets table values its own way
			end
			ZetaUtil.StringToTable(override.func, this.cachedNatives, ZetaUtil.StringToTable(override.func,_G) )
			ZetaUtil.StringToTable(override.func, _G, newOverride)
		end 
		if nativeScript.luaScript ~= nil then InfCore.DoFile(nativeScript.luaScript) end --Run file	
		for y,override in ipairs(nativeScript.overrides) do --Revert native lua functions
			ZetaUtil.StringToTable(override.func, _G, ZetaUtil.StringToTable(override.func, this.cachedNatives) )
		end
	end 
	InfCore.PCall = this.InfPCallFunc
end

--Add functions to dummy lua module ( This is so legacy mods can be treated like other Zeta mods )
function this.SetupBackwardsCompatibility(zetamodule)
	if zetamodule == nil then return nil end
	for x,nativeScript in ipairs(this.natives)do
		local tppScript = nativeScript.functionName or InfCore.GetModuleName(nativeScript.luaScript)
		if zetamodule[tppScript] == nil then
			if nativeScript.overrides ~= nil and next(nativeScript.overrides) then
				for y,override in ipairs(nativeScript.overrides) do
					zetamodule[tppScript] = function(gamemodule)
						if gamemodule == nil then return nil end
						local nativeTables = InfCore.Split(override.tab,".")
						gamemodule[nativeTables[1]] = ZetaUtil.CopyFrom( this.imported[nativeTables[1]] )
						return {} --Don't merge anything. Still runs.
					end
				end
			end
		end 
	end 
end
this.Init() --Init overrides for InfCore
return this