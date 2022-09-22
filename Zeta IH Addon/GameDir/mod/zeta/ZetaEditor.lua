--ZetaEditor.Lua
local this={
	modName = "Zeta Editor",
	modDesc = "Allows you to retreive, edit lua tables in-game, and generate lua scripts",
	modCategory = "Extensions",
	modAuthor = "ZIP",
}

function this.GetOptionSetting(param,optionName)
    local tableLookup = this.optionsSettingsTable[param][optionName]
    if tableLookup ~= nil and next(tableLookup) then
        local newOption = {
            menuName = optionName,
            labels = tableLookup.label,
        }
        if tableLookup.IDs ~= nil and next(tableLookup.IDs) then newOption.IDs = tableLookup.IDs end
        if tableLookup.func ~= nil then newOption.func = tableLookup.func end
        return this.MakeEditorOption(newOption)
    end
    return {}
end

function this.MakeEditorOption(info)
    local ret = {}
    for i, value in ipairs(info.labels) do
        local newEntry = { 
            name=value,
            desc="Changes value for "..value,
            var=info.menuName.."P"..i,
            func=function()end,
            select=function(self) 
                local sysParam = info.func()[i]
                if sysParam == nil then sysParam = 0 end
                self:Set(sysParam) 
            end,
        }
        if info.IDs ~= nil and next(info.IDs) then
            local altTable = info.IDs[i]
            if altTable ~= nil and next(altTable) then
                altTable = info.IDs[i][1]
                newEntry.text = function(self,setting)
                    for key, id in pairs(altTable) do
                        if setting == id then return key end
                    end
                    return ""
                end
                local newSettings = {}
                for key, value in pairs(altTable) do table.insert(newSettings, key) end
                newEntry.list=newSettings
            end
        end
        if newEntry.list == nil then newEntry.number = {min=-8192,max=8192,inc=0.01} end
        table.insert(ret,newEntry)
    end
    return ret
end

--Get Weapon
function this.GetPlayerWeapon()
    local weaponEqp = ZetaPlayer.GetHeldEquip()
    if weaponEqp ~= nil then
        for key, value in pairs(ZetaVar.TppEquip.EQP_WP) do
            if weaponEqp == value then 
                local newKey = string.gsub( key, "EQP_", "")
                return ZetaVar.TppEquip.WP[newKey]
            end
        end
    end
    return nil
end

function this.GetGunBasicParams()
    local playerEquip = this.GetPlayerWeapon()
    if playerEquip ~= nil then
        local gunBasic = this.GetGunBasicEntry( playerEquip )
        if gunBasic ~= nil then return gunBasic end
    end
    return nil
end

--Table Funcs
function this.GetBarrelParams(index, exTable)
    local barrel = this.GetEntryFromTable(this.GetGunBasicParams(),ZetaEquipParameters.equipParameters.barrel, 3)
    if barrel ~= nil then
        if index ~= nil then
            if exTable ~= nil and next(exTable) then
                local indexOf = barrel[index]
                local setBase = ZetaUtil.CopyFrom(exTable[indexOf+1])
                if setBase ~= nil then 
                    table.insert(setBase, 1, indexOf)
                    return setBase 
                end
            end
        end
        return barrel
    end
    return nil
end
function this.GetReceiverParams(index, exTable)
    local receiver = this.GetEntryFromTable( this.GetGunBasicParams(), ZetaEquipParameters.equipParameters.receiver, 2 )
    if receiver ~= nil then
        if index ~= nil then
            if exTable ~= nil and next(exTable) then
                local indexOf = receiver[index]
                local setBase = ZetaUtil.CopyFrom(exTable[indexOf+1])
                if setBase ~= nil then 
                    table.insert(setBase, 1, indexOf)
                    return setBase 
                end
            end
        end
        return receiver
    end
    return nil
end
function this.GetBulletSetBaseParams(index, exTable)
    local bullet = this.GetBulletParams()
    if bullet ~= nil then
        if index ~= nil then
            if exTable ~= nil and next(exTable) then
                local indexOf = bullet[index]
                local setBase = ZetaUtil.CopyFrom(exTable[indexOf+1])
                if setBase ~= nil then 
                    table.insert(setBase, 1, indexOf)
                    return setBase 
                end
            end
        end
    end
    return nil
end
function this.GetMagazineParams()
    local mag = this.GetEntryFromTable(this.GetGunBasicParams(),ZetaEquipParameters.equipParameters.magazine, 4)
    if mag ~= nil then return mag end
    return nil
end
function this.GetStockParams()
    local stock = this.GetEntryFromTable(this.GetGunBasicParams(),ZetaEquipParameters.equipParameters.stock, 5)
    if stock ~= nil then return stock end
    return nil
end
function this.GetUnderBarrelParams()
    local underBarrel = this.GetEntryFromTable(this.GetGunBasicParams(),ZetaEquipParameters.equipParameters.underBarrel, 10)
    if underBarrel ~= nil then return underBarrel end
    return nil
end
function this.GetBulletParams()
    local bullet = this.GetEntryFromTable(this.GetMagazineParams(),ZetaEquipParameters.equipParameters.bullet, 5)
    if bullet ~= nil then return bullet end
    return nil
end
function this.GetSightParams(sec)
    local index = 8
    if sec == true then index = 9 end
    local sight = this.GetEntryFromTable(this.GetGunBasicParams(), ZetaEquipParameters.equipParameters.sight, index)
    if sight ~= nil then return sight end
    return nil
end
function this.GetMuzzleOptionParams()
    local muzOp = this.GetEntryFromTable(this.GetGunBasicParams(),ZetaEquipParameters.equipParameters.muzzleOption, 7)
    if muzOp ~= nil then return muzOp end
    return nil
end
function this.GetDamageParameters()
    local receiver = this.GetEntryFromTable( this.GetGunBasicParams(), ZetaEquipParameters.equipParameters.receiver, 2 )
    if receiver ~= nil then
        local atkID = this.GetEntryFromTable(receiver, ZetaDamageParameterTables.DamageParameterTable, 2)
        if atkID ~= nil then return atkID end
    end
    return nil
end

--Single Entry Functions
function this.GetWeaponEntry(equip)
    if equip ~= nil then
        local constTable = ZetaEquipIdTable.equipIdTable
        if constTable ~= nil and next(constTable)then
            local indexOfEqp = ZetaUtil.GetIndex(equip,constTable)
            if indexOfEqp ~= nil then return constTable[indexOfEqp][3] end
        end
    end
    return nil
end
function this.GetGunBasicEntry(weapon)
    if weapon ~= nil then
        local gunBasicTable = ZetaEquipParameters.equipParameters.gunBasic
        if gunBasicTable ~= nil and next(gunBasicTable)then
            local indexOfWp = ZetaUtil.GetIndex(weapon,gunBasicTable)
            if indexOfWp ~= nil then return gunBasicTable[indexOfWp] end
        end
    end
    return nil
end

function this.GetEntryFromTable(sourceTable,targetTable,index)
    if sourceTable ~= nil and next(sourceTable) then
        if targetTable ~= nil and next(targetTable)then
            local indexOfParam = ZetaUtil.GetIndex(sourceTable[index],targetTable)
            if indexOfParam ~= nil then return targetTable[indexOfParam] end
        end
    end
    return {}
end

--UI
function this.ModMenu()
    return{
        { --Graphics Menu
            options={
                {
                    name="Weapon Editor",
                    desc="Modify your current weapon's equip parameters. (NOTICE: DO THE FOLLOWING) Equip the weapon you wish to edit, aim it once, then modify in the editor.",
                    options={
                        {
                            name="Receiver",
                            desc="Modify receiver parameters",
                            options={
                                {
                                    name="Receiver",
                                    desc="Modify receiver parameters",
                                    options=this.GetOptionSetting("equipParameters", "Receiver"),
                                },
                                {
                                    name="Receiver Set Base",
                                    desc="Modify receiver set base parameters",
                                    options=this.GetOptionSetting("equipParameters", "RecvSetBase"),
                                },
                                {
                                    name="Receiver Set Wobbling",
                                    desc="Modify receiver set wobbling parameters",
                                    options=this.GetOptionSetting("equipParameters", "RecvWobbling"),
                                },
                                {
                                    name="Receiver Set Systems",
                                    desc="Modify receiver set systems parameters",
                                    options=this.GetOptionSetting("equipParameters", "RecvSystems"),
                                },
                            }
                        },
                        {
                            name="Barrel",
                            desc="Modify your current weapon's barrel parameters",
                            options={
                                {
                                    name="Barrel",
                                    desc="Modify barrel parameters",
                                    options=this.GetOptionSetting("equipParameters", "Barrel"),
                                },
                                {
                                    name="Barrel Set Base",
                                    desc="Modify barrel set base parameters",
                                    options=this.GetOptionSetting("equipParameters", "BarrelSetBase"),
                                },
                            }
                        },
                        {
                            name="Sight",
                            desc="Modify your current weapon's sight parameters",
                            options={
                                {
                                    name="Sight 1",
                                    desc="Modify sight 1 parameters",
                                    options=this.GetOptionSetting("equipParameters", "Sight"),
                                },
                                {
                                    name="Sight 2",
                                    desc="Modify sight 2 parameters",
                                    options=this.GetOptionSetting("equipParameters", "SightSec"),
                                },
                            }
                        },
                        {
                            name="Bullet",
                            desc="Modify your current weapon's bullet parameters",
                            options={
                                {
                                    name="Bullet",
                                    desc="Modify bullet parameters",
                                    options=this.GetOptionSetting("equipParameters", "Bullet"),
                                },
                                {
                                    name="Bullet Set Base 1",
                                    desc="Modify bullet Set Base 1 parameters",
                                    options=this.GetOptionSetting("equipParameters", "BulletSetBase"),
                                },
                                {
                                    name="Bullet Set Base 2",
                                    desc="Modify bullet Set Base 2 parameters",
                                    options=this.GetOptionSetting("equipParameters", "BulletSetBaseSec"),
                                },
                            }
                        },
                        --General
                        {
                            name="Attack",
                            desc="Modify weapon attack parameters",
                            options=this.GetOptionSetting("DamageParameter", "WeaponDamage"),
                        },
                        {
                            name="GunBasic",
                            desc="Modify weapon gunBasic parameters",
                            options=this.GetOptionSetting("equipParameters", "GunBasic"),
                        },
                        {
                            name="Magazine",
                            desc="Modify Magazine parameters",
                            options=this.GetOptionSetting("equipParameters", "Magazine"),
                        },
                        {
                            name="Stock",
                            desc="Modify stock parameters",
                            options=this.GetOptionSetting("equipParameters", "Stock"),
                        },
                        {
                            name="Muzzle Options",
                            desc="Modify muzzle options parameters",
                            options=this.GetOptionSetting("equipParameters", "MuzzleOp"),
                        },
                        {
                            name="Underbarrel",
                            desc="Modify Underbarrel parameters",
                            options=this.GetOptionSetting("equipParameters", "Underbarrel"),
                        },
                        --GS
                        {
                            var="GenerateWeaponLuaScript",
                            name="Generate Lua Script",
                            desc="Generates a lua script for the equipped weapon.",
                            command="GenerateWeaponLuaScript",
                        },
                    }
                },
            }
        }
    }
end

--Settings
this.optionsSettingsTable ={
    equipParameters={
        --Receiver
        Receiver = {
            label = {
                "Receiver ID",
                "Attack ID",
                "Set ID",
                "Wobbling ID",
                "System ID",
                "Sound ID",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.RC, "TppEquip" },
                [2] = { ZetaVar.TppDamage.ATK, "TppDamage" },
            },
            tables = "receiver",
            func = function() return this.GetReceiverParams() end
        },
        RecvSetBase = {
            label = {
                "Index",
                "Fire rate",
                "Aim-Assist Distance",
                "Draw Speed",
                "Unknown4",
                "Unknown5",
                "Ironsight 1",
                "Ironsight 2",
                "Reload Speed",
            },
            IDs = {},
            tables = "receiverParamSetsBase",
            func = function() return this.GetReceiverParams(3, ZetaEquipParameters.equipParameters.receiverParamSetsBase) end
        },
        RecvWobbling = {
            label = {
                "Index",
                "Unknown1",
                "Unknown2",
                "Unknown3",
                "Unknown4",
                "Unknown5",
                "Unknown6",
                "Unknown7",
            },
            IDs = {},
            tables = "receiverParamSetsWobbling",
            func = function() return this.GetReceiverParams(4, ZetaEquipParameters.equipParameters.receiverParamSetsWobbling) end
        },
        RecvSystems = {
            label = {
                "Index",
                "Equip Type",
                "Reticle Type",
                "Fire Mode",
                "Unknown4",
                "Unknown5",
                "Unknown6",
                "Unknown7",
                "Unknown8",
                "Unknown9",
                "Unknown10",
                "Unknown11",
                "Unknown12",
            },
            IDs = {
                [2] = { ZetaVar.TppEquip.EQP_TYPE, "TppEquip" },
                [3] = { ZetaVar.TppEquip.RETICLE_UI, "TppEquip" },
                [4] = { ZetaVar.TppEquip.TRIGGER, "TppEquip" },
            },
            tables = "receiverParamSetsSystem",
            func = function() return this.GetReceiverParams(5, ZetaEquipParameters.equipParameters.receiverParamSetsSystem) end
        },
        --Barrel
        Barrel = {
            label = {
                "Barrel ID",
                "Barrel Param Sets Base ID",
                "Barrel Length ID",
                "Has Scope Mount",
                "Unknown1",
                "Has Side Mount",
                "Has Under Mount",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.BA, "TppEquip" },
                [3] = { ZetaVar.TppEquip.BARREL_LENGTH, "TppEquip" },
            },
            tables = "barrel",
            func = function() return this.GetBarrelParams() end
        },
        BarrelSetBase = {
            label = {
                "Index",
                "Unknown1",
                "Unknown2",
                "Unknown3",
                "Unknown4",
                "Unknown5",
                "Unknown6",
                "Unknown7",
            },
            IDs = {},
            tables = "barrelParamSetsBase",
            func = function() return this.GetBarrelParams(2,ZetaEquipParameters.equipParameters.barrelParamSetsBase) end
        },
        --Bullet
        Bullet = {
            label = {
                "Bullet ID",
                "Initial Force",
                "Drop-off Force",
                "Unknown4",
                "Param Set Base 1",
                "Param Set Base 2",
                "Unknown7",
                "Unknown8",
                "Ricochet Size",
                "Bullet Type",
                "Bullet Ammo",
                "Unknown12",
                "Equip Type",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.BL, "TppEquip" },
                [9] = { ZetaVar.TppEquip.ST, "TppEquip" },
                [10] = { ZetaVar.TppEquip.RICOCHET_SIZE, "TppEquip" },
                [11] = { ZetaVar.TppEquip.BLA, "TppEquip" },
                [13] = { ZetaVar.TppEquip.EQP_TYPE, "TppEquip" },
            },
            tables = "bullet",
            func = function() return this.GetBulletParams() end,
        },
        BulletSetBase = {
            label = {
                "Index",
                "Unknown1",
                "Unknown2",
                "Unknown3",
                "Unknown4",
                "Unknown5",
                "Unknown6",
                "Unknown7",
                "Unknown8",
                "Unknown9",
                "Penetrate Level ID 1",
                "Penetrate Level ID 2",
                "Unknown12",
            },
            IDs = {
                [11] = { ZetaVar.TppEquip.PENETRATE_LEVEL, "TppEquip" },
                [12] = { ZetaVar.TppEquip.PENETRATE_LEVEL, "TppEquip" },
            },
            tables = "bulletParamSetsBase",
            func = function() return this.GetBulletSetBaseParams(5, ZetaEquipParameters.equipParameters.bulletParamSetsBase) end
        },
        BulletSetBaseSec = {
            label = {
                "Index",
                "Unknown1",
                "Unknown2",
                "Unknown3",
                "Unknown4",
                "Unknown5",
                "Unknown6",
                "Unknown7",
                "Unknown8",
                "Unknown9",
                "Penetrate Level ID 1",
                "Penetrate Level ID 2",
                "Unknown12",
            },
            IDs = {
                [11] = { ZetaVar.TppEquip.PENETRATE_LEVEL, "TppEquip" },
                [12] = { ZetaVar.TppEquip.PENETRATE_LEVEL, "TppEquip" },
            },
            tables = "bulletParamSetsBase",
            func = function() return this.GetBulletSetBaseParams(6, ZetaEquipParameters.equipParameters.bulletParamSetsBase) end
        },
        --Sight
        Sight = {
            label = {
                "Scope ID",
                "Zoom Distance 1",
                "Zoom Distance 2",
                "Zoom Distance 3",
                "Scope UI ID",
                "Is Booster Scope",
                "Is Nightvision",
                "Is Built-in Scope", 
                "Is Range Finder",
                "Is Range Finder w/ Bullet Drop Indicator",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.ST, "TppEquip" },
                [5] = { ZetaVar.TppEquip.SCOPE_UI, "TppEquip" },
            },
            tables = "sight",
            func = function() return this.GetSightParams() end,
        },
        SightSec = {
            label = {
                "Scope ID",
                "Zoom Distance 1",
                "Zoom Distance 2",
                "Zoom Distance 3",
                "Scope UI ID",
                "Is Booster Scope",
                "Is Nightvision",
                "Is Built-in Scope", 
                "Is Range Finder",
                "Is Range Finder w/ Bullet Drop Indicator",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.ST, "TppEquip" },
                [5] = { ZetaVar.TppEquip.SCOPE_UI, "TppEquip" },
            },
            tables = "sight",
            func = function() return this.GetSightParams(true) end
        },
        --Other
        GunBasic = {
            label = {
                "Weapon ID",
                "Receiver ID",
                "Barrel ID",
                "Ammo ID",
                "Stock ID",
                "Muzzle ID",
                "Muzzle Option ID",
                "Sight ID",
                "Sight 2 ID",
                "Underbarrel ID",
                "Laser/Flashlight ID",
                "Laser/Flashlight 2 ID",
                "Weapon Grade",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.WP, "TppEquip" },
                [2] = { ZetaVar.TppEquip.RC, "TppEquip" },
                [3] = { ZetaVar.TppEquip.BA, "TppEquip" },
                [4] = { ZetaVar.TppEquip.AM, "TppEquip" },
                [5] = { ZetaVar.TppEquip.SK, "TppEquip" },
                [6] = { ZetaVar.TppEquip.MZ, "TppEquip" },
                [7] = { ZetaVar.TppEquip.MO, "TppEquip" },
                [8] = { ZetaVar.TppEquip.ST, "TppEquip" },
                [9] = { ZetaVar.TppEquip.ST, "TppEquip" },
                [10] = { ZetaVar.TppEquip.UB, "TppEquip" },
                [11] = { ZetaVar.TppEquip.LTS, "TppEquip" },
                [12] = { ZetaVar.TppEquip.LTS, "TppEquip" },
            },
            tables = "gunBasic",
            func = function() return this.GetGunBasicParams() end,
        },
        Stock = {
            label =  {
                "Stock ID",
                "Unknown1",
                "Unknown2",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.SK, "TppEquip" },
            },
            tables = "stock",
            func = function() return this.GetStockParams() end
        },
        Magazine = {
            label = {
                "Ammo ID",
                "Equip Ammo ID",
                "Magazine Capacity",
                "Total Carry Capacity",
                "Bullet ID",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.AM, "TppEquip" },
                [2] = { ZetaVar.TppEquip.EQP_AM, "TppEquip" },
                [5] = { ZetaVar.TppEquip.BL, "TppEquip" },
            },
            tables = "magazine",
            func = function() return this.GetMagazineParams() end
        },
        Underbarrel = {
            label = {
                "Underbarrel ID",
                "Receiver ID",
                "Ammo ID",
                "Unknown1",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.UB, "TppEquip" },
                [2] = { ZetaVar.TppEquip.RC, "TppEquip" },
                [3] = { ZetaVar.TppEquip.AM, "TppEquip" },
            },
            tables = "underBarrel",
            func = function() return this.GetUnderBarrelParams() end
        },
        MuzzleOp = {
            label = {
                "Muzzle Option ID", 
                "Grouping Bonus",
                "Supressor Durability",
                "Is Suppressor",
            },
            IDs = {
                [1] = { ZetaVar.TppEquip.MO, "TppEquip" },
            },
            tables = "muzzleOption",
            func = function() return this.GetMuzzleOptionParams() end,
        },
    },
    DamageParameter={
        WeaponDamage={
            label = {
                "Attack ID",
                "Lethal Damage (UI)",
                "Unknown3",
                "Unknown4",
                "Unknown5",
                "Unknown6",
                "Unknown7",
                "Unknown8",
                "Injury Type",
                "Injury Part",
                "Unknown11",
                "Unknown12",
                "Physically Simulated",
                "Unknown14",
                "Knockback",
                "Tranquilizer",
                "Stuns",
                "Unknown18",
                "Unknown19",
                "Unknown20",
                "Fire",
                "Unknown22",
                "Gas",
                "Unknown24",
                "Unknown25",
                "Electric",
                "Unknown27",
                "Unknown28",
                "Damage Source",
                "Lethal Damage Value",
                "Non-lethal Damage Value",
                "Impact Force",
            },
            IDs = {
                [1] = { ZetaVar.TppDamage.ATK, "TppDamage" },
                [9] = { ZetaVar.TppDamage.INJ_TYPE, "TppDamage" },
                [10] = { ZetaVar.TppDamage.INJ_PART, "TppDamage" },
                [29] = { ZetaVar.TppDamage.DAM_SOURCE, "TppDamage" },
            },
            tables = "WeaponDamage",
            func = function() return this.GetDamageParameters() end,
        },
    },
}
--Exports values, tables, functions as lua files.
function this.GenerateWeaponLuaScript()
    local saveName = "Weapon"..os.time()..".lua"
    local ret = {
        "--"..saveName,
        "local this={",
        "\tmodName=\"Generated Script "..os.time().."\",",
        "\tmodDesc=\"This is a generated weapon script.\",",
        "\tmodAuthor=\"(Generated)\",",
        "\tmodCategory=\"Weapon\",",
        "}",
    }
    ret = this.FunctionToFile(ret, this.optionsSettingsTable.equipParameters, "EquipParameters" )
    ret = this.FunctionToFile(ret, this.optionsSettingsTable.DamageParameter, "DamageParameters", false )
    ret[#ret+1] = "return this"
    local fileName=InfCore.paths.zetagen..saveName
    InfCore.WriteStringTable(fileName,ret)
    TppUiCommand.AnnounceLogView(ZetaCore.modName..": Script Generated ("..fileName..")") 
end
function this.FunctionToFile(ret, params, functionName, hasSubTables)
    ret[#ret+1] = "function this."..functionName.."()"
    ret[#ret+1] = "\treturn {"
    --Concat repeating functions
    local conCatTable = {}
    for tableName, tableValue in pairs(params) do 
        if conCatTable[tableValue.tables] == nil then conCatTable[tableValue.tables] = {} end
        conCatTable[tableValue.tables][tableName] = tableValue
    end
    for funcName, tableValues in pairs(conCatTable) do 
        local combinedEntries = {}
        for tableName, tableValue in pairs(tableValues) do 
            table.insert(combinedEntries,this.ParamsToTable(tableValue.label, tableValue.IDs, tableName )) 
        end
        local newFuncName = funcName
        if hasSubTables == false then newFuncName = nil end
        local tempTable = this.TableToFunction(combinedEntries, newFuncName)
        for y, table in ipairs(tempTable) do ret[#ret+1] = table end
    end
    ret[#ret+1] = "\t}"
    ret[#ret+1] = "end"
    return ret
end
function this.TableToFunction(entries, tableName)
    local ret = {}
    local tabs = "\t"
    if tableName ~= nil then
        tabs = tabs.."\t"
        ret[#ret+1] = tabs..tableName.."={"
    end
    tabs = tabs.."\t"
    if entries ~= nil and next(entries)then
        for i,subEntry in ipairs(entries) do
            local string = tabs.."{"
            for i,value in ipairs(subEntry) do 
                string = string.." "..value
                if i < #subEntry then string = string.."," end
            end
            string = string.."},"
            ret[#ret+1] = string
        end
    end
    if tableName ~= nil then
        ret[#ret+1] = "\t\t},"
    end
    return ret
end

function this.ParamsToTable(labelNames, idTables, paramName )
    local ret = {}
    for i, label in ipairs(labelNames) do
        local newParam = 0
        local paramIvar = ZetaVar.GetModIvar(this,paramName.."P"..i)
        if paramIvar ~= nil then newParam = paramIvar end
        if idTables ~= nil and next(idTables) then
            local altTable = idTables[i]
            if altTable ~= nil and next(altTable) then
                altTable = idTables[i][1]
                for key, id in pairs(altTable) do
                    if paramIvar == id then  
                        newParam = idTables[i][2].."."..key
                    end
                end
            end
        end
        if label == "Index" then newParam = "index="..newParam end --Add index if label
        ret[#ret+1] = newParam 
    end
    return ret
end

return this