--ZetaNativeOverride.lua
--Description: Provides backwards compatibility for older mods by hijacking functions to retrieve their input variables.
local this={
	InfLoadLib = nil,
	libBlackList = {},
	imported = {},
	cachedNatives = {},
}

--luaScript: Lua filepath
--tab: Table name for used in the override process
--subTab: In case subtables need to be handled differently
--override: The function that overrides the native
this.natives = {
	TppMotherBaseManagement = {
		EquipDevelopConstSetting = {
			luaScript="/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua",
			RegCstDev={tab="equipDevTableCst"}
		},
		EquipDevelopFlowSetting = {
			luaScript="/Assets/tpp/motherbase/script/EquipDevelopFlowSetting.lua",
			RegFlwDev={tab="equipDevTableFlw"}
		},
		WeaponPartsUiSetting={
			luaScript="/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua",
			RegistWeaponPartsInfo={tab="WeaponPartsInfoTable"}
		},
		WeaponPartsCombinationSettings={
			luaScript="/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua",
			RegistPartsInclusionInfo_ReceiverBase={
				tab="partCombinationTable",
				override=function(entry) 
					local newEntry = { func=1,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds }		
					table.insert( this.imported.partCombinationTable, newEntry ) 
				end,
			},
			RegistPartsInclusionInfo={
				tab="partCombinationTable",
				override=function(entry) 
					local newEntry = { func=2,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds }		
					table.insert( this.imported.partCombinationTable, newEntry )
				end,
			},
			RegistPartsInclusionInfo_BarrelBase={
				tab="partCombinationTable",
				override=function(entry) 
					local newEntry = { func=3,barrelID=entry.barrelID,partsType=entry.partsType,partsIds=entry.partsIds }		
					table.insert( this.imported.partCombinationTable, newEntry )
				end,
			},
			RegistPartsInclusionInfo_ReceiverWithUnderBarrellBase={
				tab="partCombinationTable",
				override=function(entry) 
					local newEntry = { func=4,receiverID=entry.receiverID,partsType=entry.partsType,partsIds=entry.partsIds }		
					table.insert( this.imported.partCombinationTable, newEntry )
				end,
			},
		},
		MbmCommonSetting={	
			luaScript="/Assets/tpp/motherbase/script/MbmCommonSetting.lua",
			RegisterStaffTypePeaks={tab="MbmCommonSettingTable",subTab="staffTypePeaks"},
			RegisterRandomRange={tab="MbmCommonSettingTable",subTab="randomRanges",},
			RegisterStaffBaseRankRange={tab="MbmCommonSettingTable",subTab="staffBaseRankRanges"},
			RegisterStaffMinBaseRank={set=true,tab="MbmCommonSettingTable",subTab="staffMinBaseRankParam"},
			RegisterSectionLvLine={tab="MbmCommonSettingTable",subTab="sectionLvLines"},
			RegisterSkillDrawingParam={tab="MbmCommonSettingTable",subTab="skillDrawingParams"},
			SortSkillDrawingParamTable={tab="MbmCommonSettingTable",override=function()end},
			RegisterQuestSkillDrawingParam={tab="MbmCommonSettingTable",subTab="questSkillDrawingParams"},
			SortQuestSkillDrawingParamTable={tab="MbmCommonSettingTable",override=function()end},
			RegisterUniqueStaff={tab="MbmCommonSettingTable",subTab="uniqueStaff"},
			RegisterMissionBaseStaffTypes={tab="MbmCommonSettingTable",subTab="missionBaseStaffTypes"},
			RegisterBaseInitEnmityParam={tab="MbmCommonSettingTable",subTab="baseInitEnmityParams"},
			RegisterInitEnmityOffset={set=true,tab="MbmCommonSettingTable",subTab="initEnmityOffsetParams"},
			RegisterTimeMinutePer1Enmity={tab="MbmCommonSettingTable",subTab="timeMinutePer1Enmitys"},
			RegisterMoraleParam={set=true,tab="MbmCommonSettingTable",subTab="moralParams"},
			RegisterMedalParam={set=true,tab="MbmCommonSettingTable",subTab="medalParams"},
			RegisterLanguageParam={set=true,tab="MbmCommonSettingTable",subTab="languageParams"},
			RegisterPandemicParam={set=true,tab="MbmCommonSettingTable",subTab="pandemicParams"},
			RegisterOgreUserVolunteerStaffParam={set=true,tab="MbmCommonSettingTable",subTab="ogreUserVolunteerStaffParams"},
			RegisterOgreUserVolunteerStaffTypes={tab="MbmCommonSettingTable",subTab="ogreUserVolunteerStaffTypes",},
			RegisterCommonVolunteerStaffHeroicParam={tab="MbmCommonSettingTable",subTab="commonVolunteerStaffHeroicParams"},
			RegisterCommonVolunteerStaffOgreParam={tab="MbmCommonSettingTable",subTab="commonVolunteerStaffOgreParams"},
			RegisterCommonVolunteerStaffClearTimeParam={tab="MbmCommonSettingTable",subTab="commonVolunteerStaffClearTimeParams"},
		}
	},
	TppEquip = {
		ChimeraPartsPackageTable={
			luaScript="Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua",
			ReloadChimeraPartsInfoTable={
				tab="chimeraPartsInfo",
				override=function(...)
					local arg = {...}	
					this.imported.chimeraPartsInfo = arg[1]
				end,
			}
		},
		EquipParameters={
			luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipParameters.lua",
			ReloadEquipParameterTables2={set=true,tab="equipParameters"}
		},
		EquipParameterTables={
			luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/EquipParameterTables.lua",
			ReloadEquipParameterTables={set=true,tab="equipParameterTables"}
		},
		EquipIdTable={
			luaScript="Tpp/Scripts/Equip/EquipIdTable.lua",
			ReloadEquipIdTable={set=true,tab="equipIdTable"}
		},
		EquipMotionData={
			luaScript="Tpp/Scripts/Equip/EquipMotionData.lua",
			ReloadEquipMotionData={
				tab="motionDataTable",
				override=function(entry) this.imported.motionDataTable = entry.MotionDataTable end,
			}
		},
		EquipMotionDataForChimera={
			luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipMotionDataForChimera.lua",
			ReloadEquipMotionData2={set=true,tab="equipMotionDataForChimera"}
		},
	},
	TppDamage={
		DamageParameterTables={
			luaScript="/Assets/tpp/level_asset/damage/ParameterTables/DamageParameterTables.lua",
			ReloadDamageParameter={
				tab="DamageParameterTable",
				override=function(entry) this.imported.DamageParameterTable = entry.DamageParameter end,
			}
		},
	},
	TppBullet={
		RecoilMaterialTable={
			luaScript="/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua",
			ReloadRecoilMaterials={set=true,tab="recoilMaterialsParameters"}
		},
	},
	TppSoldierFace={
		Soldier2FaceAndBodyData={
			luaScript="/Assets/tpp/level_asset/chara/enemy/Soldier2FaceAndBodyData.lua",
			SetFovaFileTable={
				tab="faceAndBodyTable",
				override=function(entry) 
					this.CreateTables(this.imported, "faceAndBodyTable", "faceFova")
					this.CreateTables(this.imported, "faceAndBodyTable", "faceDecoFova")
					this.CreateTables(this.imported, "faceAndBodyTable", "hairFova")
					this.CreateTables(this.imported, "faceAndBodyTable", "hairDecoFova")
					this.CreateTables(this.imported, "faceAndBodyTable", "bodyFova")
					this.imported.faceAndBodyTable.faceFova = entry.faceFova.table 
					this.imported.faceAndBodyTable.faceDecoFova = entry.faceDecoFova.table
					this.imported.faceAndBodyTable.hairFova = entry.hairFova.table
				 	this.imported.faceAndBodyTable.hairDecoFova = entry.hairDecoFova.table 
					this.imported.faceAndBodyTable.bodyFova = entry.bodyFova.table
				end,
			},
			SetFaceFovaDefinitionTable={
				tab="faceAndBodyTable",subTab="faceDefinition",
				override=function(entry) 
					this.imported.faceAndBodyTable.faceDefinition = entry.table 
				end,
			},
			ModFaceFovaDefinitionTable={
				tab="faceAndBodyTable",subTab="modFaceFova",
				override=function(entry) 
					this.imported.faceAndBodyTable.modFaceFova = entry.table 
				end,
			},
			SetBodyFovaDefinitionTable={
				tab="faceAndBodyTable",subTab="bodyDefinition",
				override=function(entry) 
					this.imported.faceAndBodyTable.bodyDefinition = entry.table
				end,
			},
			ModBodyFovaDefinitionTable={
				tab="faceAndBodyTable",subTab="modBodyFova",
				override=function(entry) 
					this.imported.faceAndBodyTable.modBodyFova = entry.table
				end,
			},
		},
	}
}

--Override functions
function this.IsScriptInBlackList(luaScript) 
	if this.libBlackList ~= nil and next(this.libBlackList) then
		for i,blockedLib in ipairs(this.libBlackList)do 
			if string.match( luaScript, blockedLib ) then return true end
		end
	end
	return false
end
function this.CreateTables(entries, tab, subTab)
	if entries == nil then entries = {} end
	if tab ~= nil then --Create tables
		if entries[tab] == nil then entries[tab] = {} end
		if subTab ~= nil then 
			if entries[tab][subTab] == nil then entries[tab][subTab] = {} end
		end
	end
	return entries
end
--Overrides InfCore.LoadLibrary / Prevents vanilla libs from running
function this.LoadLibrary(path)
	if path ~= nil then
		if this.IsScriptInBlackList(path) == false then
			if this.InfLoadLib ~= nil then this.InfLoadLib(path) end
		end
	end
end

function this.Reload()
	this.InfLoadLib = InfCore.LoadLibrary
	InfCore.LoadLibrary = this.LoadLibrary
	--Override native lua functions
	for tppTable,tppTables in pairs(this.natives)do
		for tppSubTable,tppSubTables in pairs(tppTables)do
			for tppValue,tppOverride in pairs(tppSubTables)do  
				if type(tppOverride) == "table" then
					if _G[tppTable] ~= nil then  
						this.imported = this.CreateTables(this.imported, tppOverride.tab, tppOverride.subTab)
						local newOverride = tppOverride.override
						if newOverride == nil then
							if tppOverride.tab ~= nil then
								if tppOverride.subTab ~= nil then 
									if tppOverride.set == true then
										newOverride = function(entry) this.imported[tppOverride.tab][tppOverride.subTab] = entry end 
									else
										newOverride = function(entry) table.insert( this.imported[tppOverride.tab][tppOverride.subTab], entry ) end 
									end
								else 
									if tppOverride.set == true then
										newOverride = function(entry) this.imported[tppOverride.tab] = entry end 
									else
										newOverride = function(entry) table.insert( this.imported[tppOverride.tab], entry ) end 
									end
								end
							end
						end
						if _G[tppTable][tppValue]~= nil then
							this.cachedNatives = this.CreateTables(this.cachedNatives, tppTable, tppValue)
							this.cachedNatives[tppTable][tppValue] = _G[tppTable][tppValue]
							_G[tppTable][tppValue] = newOverride
						end
					end
				end
			end
			if tppSubTables.luaScript ~= nil then
				InfCore.DoFile(tppSubTables.luaScript) 
				if this.IsScriptInBlackList(tppSubTables.luaScript) == false then table.insert(this.libBlackList, tppSubTables.luaScript) end
			end --Run file	
			for tppValue,tppOverride in pairs(tppSubTables)do --Revert native lua functions
				if type(tppOverride) == "table" then
					if tppTable ~= nil then  
						if tppOverride.tab ~= nil then
							if _G[tppTable] ~= nil then _G[tppTable][tppValue] = this.cachedNatives[tppTable][tppValue] end
						end
					end
				end
			end
		end 
	end 
end

--Add functions to dummy lua module ( This is so legacy mods can be treated like other Zeta mods )
function this.SetupBackwardsCompatibility(zetamodule)
	if zetamodule == nil then return nil end
	if this.imported ~= nil and next(this.imported) then
		for tppTable,tppTables in pairs(this.natives)do
			for tppSubTable,tppSubTables in pairs(tppTables)do
				if zetamodule["Set"..tppSubTable] == nil then
					for tppValue,tppOverride in pairs(tppSubTables)do
						if type(tppOverride) == "table" then
							if tppOverride.tab ~= nil then
								local tableValues = this.imported[tppOverride.tab]
								if tableValues ~= nil and next(tableValues) then
									zetamodule["Set"..tppSubTable] = function(gamemodule)
										if gamemodule == nil then return nil end
										gamemodule[tppOverride.tab] = ZetaUtil.CopyFrom( tableValues )
									end
								end
							end
						end
					end	
				end
			end 
		end 
	end
end

return this