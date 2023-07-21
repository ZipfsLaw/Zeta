--ZetaEditor.Lua
--Purpose: Generates Zeta scripts to use as base templates.
local this={
	modName = "Zeta Editor",
	modDesc = "A tool used to generate Zeta lua script templates using pre-existing entities in the game.",
	modCategory = "Extensions",
	modAuthor = "ZIP",
    editorExportPath = "zeta", --Export to Zeta folder now
}
--UI
function this.ModMenu()
    return{
        {
            name="Weapon Editor",
            desc="Modify your current weapon's equip parameters.",
            options={
                {name="Receiver",desc="Modify receiver parameters",options={
                    {name="Receiver", desc="Modify receiver parameters",options=this.GetOptionSetting("equipParameters", "Receiver"),},
                    {name="Receiver Set Base",desc="Modify receiver set base parameters",options=this.GetOptionSetting("equipParameters", "RecvSetBase"),},
                    {name="Receiver Set Wobbling",desc="Modify receiver set wobbling parameters",options=this.GetOptionSetting("equipParameters", "RecvWobbling"),},
                    {name="Receiver Set Systems",desc="Modify receiver set systems parameters",options=this.GetOptionSetting("equipParameters", "RecvSystems"),},
                }},
                {name="Barrel",desc="Modify your current weapon's barrel parameters",options={
                    {name="Barrel",desc="Modify barrel parameters",options=this.GetOptionSetting("equipParameters", "Barrel"),},
                    {name="Barrel Set Base",desc="Modify barrel set base parameters",options=this.GetOptionSetting("equipParameters", "BarrelSetBase"),},
                }},
                {name="Sight",desc="Modify your current weapon's sight parameters",options={
                    {name="Sight 1",desc="Modify sight 1 parameters",options=this.GetOptionSetting("equipParameters", "Sight"),},
                    {name="Sight 2",desc="Modify sight 2 parameters",options=this.GetOptionSetting("equipParameters", "SightSec"),},
                }},
                {name="Bullet",desc="Modify your current weapon's bullet parameters",options={
                    {name="Bullet",desc="Modify bullet parameters",options=this.GetOptionSetting("equipParameters", "Bullet"),},
                    {name="Bullet Set Base 1",desc="Modify bullet Set Base 1 parameters",options=this.GetOptionSetting("equipParameters", "BulletSetBase"),},
                    {name="Bullet Set Base 2",desc="Modify bullet Set Base 2 parameters",options=this.GetOptionSetting("equipParameters", "BulletSetBaseSec"),},
                }},
                --General
                {name="Attack",desc="Modify weapon attack parameters",options=this.GetOptionSetting("DamageParameter", "WeaponDamage"),},
                {name="GunBasic",desc="Modify weapon gunBasic parameters",options=this.GetOptionSetting("equipParameters", "GunBasic"),},
                {name="Magazine",desc="Modify Magazine parameters",options=this.GetOptionSetting("equipParameters", "Magazine"),},
                {name="Stock",desc="Modify stock parameters",options=this.GetOptionSetting("equipParameters", "Stock"),},
                {name="Muzzle Options",desc="Modify muzzle options parameters",options=this.GetOptionSetting("equipParameters", "MuzzleOp"),},
                {name="Underbarrel",desc="Modify Underbarrel parameters",options=this.GetOptionSetting("equipParameters", "Underbarrel"),},
                --GS
                {var="GenerateWeaponLuaScript",name="Generate Lua Script",desc="Generates a lua script for the equipped weapon.",command=function() this.GenerateWeaponLuaScript() end,},
                {var="FAQs",name="How to Use",desc="-Equip and aim your preferred weapon\n-Return to editor to modify its parameters\n-Click \"Generate Lua Script\".",command=function()end,},
            }
        },
    }
end
--Exportable Settings
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
                [1] = { ZetaTPPDef.TppEquip.RC, "TppEquip" },
                [2] = { ZetaTPPDef.TppDamage.ATK, "TppDamage" },
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
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetReceiverParams(),target=ZetaEquipParameters.equipParameters.receiverParamSetsBase,index=3,readonly=true} end
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
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetReceiverParams(),target=ZetaEquipParameters.equipParameters.receiverParamSetsWobbling,index=4,readonly=true} end
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
                [2] = { ZetaTPPDef.TppEquip.EQP_TYPE, "TppEquip" },
                [3] = { ZetaTPPDef.TppEquip.RETICLE_UI, "TppEquip" },
                [4] = { ZetaTPPDef.TppEquip.TRIGGER, "TppEquip" },
            },
            tables = "receiverParamSetsSystem",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetReceiverParams(),target=ZetaEquipParameters.equipParameters.receiverParamSetsSystem,index=5,readonly=true} end
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
                [1] = { ZetaTPPDef.TppEquip.BA, "TppEquip" },
                [3] = { ZetaTPPDef.TppEquip.BARREL_LENGTH, "TppEquip" },
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
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetBarrelParams(),target=ZetaEquipParameters.equipParameters.barrelParamSetsBase,index=2,readonly=true} end
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
                [1] = { ZetaTPPDef.TppEquip.BL, "TppEquip" },
                [9] = { ZetaTPPDef.TppEquip.RICOCHET_SIZE, "TppEquip" },
                [10] = { ZetaTPPDef.TppEquip.BULLET_TYPE, "TppEquip" },
                [11] = { ZetaTPPDef.TppEquip.BLA, "TppEquip" },
                [13] = { ZetaTPPDef.TppEquip.EQP_TYPE, "TppEquip" },
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
                [11] = { ZetaTPPDef.TppEquip.PENETRATE_LEVEL, "TppEquip" },
                [12] = { ZetaTPPDef.TppEquip.PENETRATE_LEVEL, "TppEquip" },
            },
            tables = "bulletParamSetsBase",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetBulletParams(),target=ZetaEquipParameters.equipParameters.bulletParamSetsBase,index=5,readonly=true} end
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
                [11] = { ZetaTPPDef.TppEquip.PENETRATE_LEVEL, "TppEquip" },
                [12] = { ZetaTPPDef.TppEquip.PENETRATE_LEVEL, "TppEquip" },
            },
            tables = "bulletParamSetsBase",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetBulletParams(),target=ZetaEquipParameters.equipParameters.bulletParamSetsBase,index=6,readonly=true} end
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
                [1] = { ZetaTPPDef.TppEquip.ST, "TppEquip" },
                [5] = { ZetaTPPDef.TppEquip.SCOPE_UI, "TppEquip" },
            },
            tables = "sight",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.sight, index=8} end,
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
                [1] = { ZetaTPPDef.TppEquip.ST, "TppEquip" },
                [5] = { ZetaTPPDef.TppEquip.SCOPE_UI, "TppEquip" },
            },
            tables = "sight",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.sight, index=9} end
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
                [1] = { ZetaTPPDef.TppEquip.WP, "TppEquip" },
                [2] = { ZetaTPPDef.TppEquip.RC, "TppEquip" },
                [3] = { ZetaTPPDef.TppEquip.BA, "TppEquip" },
                [4] = { ZetaTPPDef.TppEquip.AM, "TppEquip" },
                [5] = { ZetaTPPDef.TppEquip.SK, "TppEquip" },
                [6] = { ZetaTPPDef.TppEquip.MZ, "TppEquip" },
                [7] = { ZetaTPPDef.TppEquip.MO, "TppEquip" },
                [8] = { ZetaTPPDef.TppEquip.ST, "TppEquip" },
                [9] = { ZetaTPPDef.TppEquip.ST, "TppEquip" },
                [10] = { ZetaTPPDef.TppEquip.UB, "TppEquip" },
                [11] = { ZetaTPPDef.TppEquip.LTS, "TppEquip" },
                [12] = { ZetaTPPDef.TppEquip.LTS, "TppEquip" },
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
                [1] = { ZetaTPPDef.TppEquip.SK, "TppEquip" },
            },
            tables = "stock",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.stock, index=5} end
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
                [1] = { ZetaTPPDef.TppEquip.AM, "TppEquip" },
                [2] = { ZetaTPPDef.TppEquip.EQP_AM, "TppEquip" },
                [5] = { ZetaTPPDef.TppEquip.BL, "TppEquip" },
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
                [1] = { ZetaTPPDef.TppEquip.UB, "TppEquip" },
                [2] = { ZetaTPPDef.TppEquip.RC, "TppEquip" },
                [3] = { ZetaTPPDef.TppEquip.AM, "TppEquip" },
            },
            tables = "underBarrel",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.underBarrel, index=10} end
        },
        MuzzleOp = {
            label = {
                "Muzzle Option ID", 
                "Grouping Bonus",
                "Supressor Durability",
                "Is Suppressor",
            },
            IDs = {
                [1] = { ZetaTPPDef.TppEquip.MO, "TppEquip" },
            },
            tables = "muzzleOption",
            func = function() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.muzzleOption, index=7} end,
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
                "Projectile",
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
                [1] = { ZetaTPPDef.TppDamage.ATK, "TppDamage" },
                [9] = { ZetaTPPDef.TppDamage.INJ_TYPE, "TppDamage" },
                [10] = { ZetaTPPDef.TppDamage.INJ_PART, "TppDamage" },
                [29] = { ZetaTPPDef.TppDamage.DAM_SOURCE, "TppDamage" },
            },
            tables = "WeaponDamage",
            func = function() return this.GetDamageParameters() end,
        },
    },
}
--Editor Functions
function this.Update(currentChecks,currentTime,execChecks,execState)
    if InfMenu.menuOn == true then --Updates all options if IH menu's open
        --local weaponEqp = vars.weapons[vars.currentInventorySlot]
        local weaponEqp = ZetaPlayer.GetHeldEquip() --Updates when player weapon changes
        if this.currentPlayerEquip ~= weaponEqp then
            this.currentPlayerEquip = weaponEqp
            this.UpdateAllSettings() 
        end
    end
end
function this.UpdateAllSettings() --Updates all options
    for class, classTable in pairs(this.optionsSettingsTable) do
        for settings, settingTable in pairs(classTable) do
            if settingTable ~= nil and next(settingTable) then
                if settingTable.func ~= nil then  
                    local sysParams = settingTable.func()
                    if sysParams ~= nil and next(sysParams) then
                        for i, value in ipairs(settingTable.label) do
                            local ivarOption = this.ZVar(settings.."P"..i,{default=0, get=false})
                            if ivarOption ~= nil then
                                local newParam = sysParams[i]
                                if newParam == nil then newParam = 0 end
                                ivarOption:Set(newParam)
                            end
                        end
                    end
                end
            end
        end
    end
end
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
--Exports values, tables, functions as lua files.
function this.GenerateWeaponLuaScript()
    local saveName = "Weapon"..os.time()..".lua"
    local ret = {
        "--"..saveName,
        "local this={",
        "\tmodName=\"Generated Script "..os.time().."\",",
        "\tmodDesc=\"This is a generated weapon script.\",",
        "\tmodAuthor=\"(Generated)\",",
        "\tmodCategory=\"Weapons\",",
        "\tmodDisabledByDefault=true, --Remove this line if you want it to be enabled by default!",
        "}",
    }
    ret = this.FunctionToFile(ret, this.optionsSettingsTable.equipParameters, "EquipParameters" )
    ret = this.FunctionToFile(ret, this.optionsSettingsTable.DamageParameter, "DamageParameters", false )
    ret[#ret+1] = "return this"
    local fileName=InfCore.paths[this.editorExportPath]..saveName
    InfCore.WriteStringTable(fileName,ret)
    ZetaCore.ReloadMods{} --Reload mods to include saved script
    ZetaCore.Log(fileName,{"ZetaEditor","Script Generated"} )
end
function this.FunctionToFile(ret, params, functionName, usesKeyNames )
    --Concat repeating functions
    local conCatTable = {}
    for tableName, tableValue in pairs(params) do 
        if conCatTable[tableValue.tables] == nil then conCatTable[tableValue.tables] = {} end
        conCatTable[tableValue.tables][tableName] = tableValue
    end
    if conCatTable ~= nil and next(conCatTable)then
        ret[#ret+1] = "function this."..functionName.."()"
        ret[#ret+1] = "\treturn {"
        for funcName, tableValues in pairs(conCatTable) do 
            if tableValues ~= nil and next(tableValues)then
                local combinedEntries = {}
                for tableName, tableValue in pairs(tableValues) do 
                    local newParamsForTable = this.ParamsToTable(tableValue.label, tableValue.IDs, tableName )
                    if newParamsForTable ~= nil then table.insert(combinedEntries,newParamsForTable) end
                end
                if combinedEntries ~= nil and next(combinedEntries) then
                    local newFuncName = funcName
                    if usesKeyNames == false then newFuncName = nil end --Lists them without keys
                    local tempTable = this.TableToFunction(combinedEntries, newFuncName)
                    for y, table in ipairs(tempTable) do ret[#ret+1] = table end
                end
            end
        end
        ret[#ret+1] = "\t}"
        ret[#ret+1] = "end"
    end
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
        local paramIvar = this.ZVar(paramName.."P"..i)
        if paramIvar ~= nil then newParam = paramIvar end
        if i == 1 and newParam == 0 then return nil end --Don't write lines for NONE entries
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
        if label == "Index" then newParam = "sIndex="..newParam end --Add index if label
        ret[#ret+1] = newParam 
    end
    return ret
end
--GET Functions
function this.GetPlayerWeapon() --Get Weapon
    local weaponEqp = ZetaPlayer.GetHeldEquip()
    if weaponEqp ~= nil then
        for key, value in pairs(ZetaTPPDef.TppEquip.EQP_WP) do
            if weaponEqp == value then 
                local newKey = string.gsub( key, "EQP_", "")
                return ZetaTPPDef.TppEquip.WP[newKey]
            end
        end
    end
    return nil
end
--EquipParameters
function this.GetGunBasicParams() return ZetaUtil.GetEntryFromTable{target=ZetaEquipParameters.equipParameters.gunBasic,index=this.GetPlayerWeapon()} end
function this.GetReceiverParams() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.receiver,index=2}  end
function this.GetBarrelParams() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.barrel,index=3}  end
function this.GetMagazineParams() return ZetaUtil.GetEntryFromTable{source=this.GetGunBasicParams(),target=ZetaEquipParameters.equipParameters.magazine,index=4} end
function this.GetBulletParams() return ZetaUtil.GetEntryFromTable{source=this.GetMagazineParams(),target=ZetaEquipParameters.equipParameters.bullet,index=5} end
--DamageParameterTables
function this.GetDamageParameters() return ZetaUtil.GetEntryFromTable{source=this.GetReceiverParams(),target=ZetaDamageParameterTables.DamageParameterTable,index=2} end
return this