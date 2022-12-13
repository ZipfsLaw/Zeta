--ZetaHook.lua
--Purpose: Overrides native functions recursively for multiple mod support. 
--This automatically generates hooks for a number of lua libraries listed below. All of these functions are listed in IH_Log.txt
local this={
    tppLibraries={
        "TppAnimal",
        "TppAnimalBlock",
        "TppCassette",
        "TppCheckPoint",
        "TppCollection",
        "TppEmblem",
        "TppEnemy",
        "TppEneFova",
        "TppFreeHeliRadio",
        "TppHelicopter",
        "TppHero",
        "TppInterrogation",
        "TppPlayer",
        "TppQuest",
        "TppRadio",
        "TppRanking",
        "TppResult",
        "TppReward",
        "TppRevenge",
        "TppSound",
        "TppStory",
        "TppTerminal",
        "TppTelop",
        "TppUI",
        "TppWeather",
    },
    natives={},
    hooks={},
}
function this.Reload() --Hooks numerous functions discovered in the libraries listed above
    InfCore.Log( "["..ZetaDef.modName.."][ZetaHook] Creating hooks for Zeta modules.",false,true)
    local numOfFuncs = 0
    for i, libName in ipairs(this.tppLibraries)do
        local lib = _G[libName]
        if lib ~= nil then
            for key, val in pairs(lib)do
                if val ~= nil then
                    if type(val) == "function" then
                        local funcName = libName..key
                        local newOverride = function(...)return ZetaIndex.ModReturn(funcName,...)end
                        this.AddHook(libName.."."..key,newOverride)
                        InfCore.Log( "["..ZetaDef.modName.."][ZetaHook] "..funcName,false,true)
                        numOfFuncs = numOfFuncs + 1
                    end
                end
            end
        end
    end
    InfCore.Log( "["..ZetaDef.modName.."][ZetaHook] Generated "..numOfFuncs.." functions for use in Zeta modules.",false,true)
end
function this.CreateHook(funcName, overrideFunc, hookTable)
    local unpack = unpack or table.unpack
    local newHook = function(...) 
        local retValue = { overrideFunc(...) }
        if retValue ~= nil and next(retValue) then return unpack(retValue) end --Return override value instead
        local nativeFunc = ZetaUtil.StringToTable(funcName, hookTable )
        if nativeFunc ~= nil then 
            retValue = { nativeFunc(...) }
            if retValue ~= nil and next(retValue) then return unpack(retValue) end --Return override value instead
        end
    end
    return newHook
end
function this.AddHook(funcName,overrideFunc)
    if overrideFunc ~= nil then
        if this.ContainsHook(funcName) == false then 
            table.insert( this.hooks, funcName )
            ZetaUtil.StringToTable(funcName, this.natives, ZetaUtil.StringToTable(funcName,_G) )
            ZetaUtil.StringToTable(funcName, _G, this.CreateHook(funcName, overrideFunc, this.natives))
        else ZetaUtil.StringToTable(funcName, _G, this.CreateHook(funcName, overrideFunc, _G))end
    end
end
function this.ContainsHook(funcName)
    if this.hooks ~= nil and next(this.hooks) then
        for i,hookName in ipairs(this.hooks) do
            if hookName == funcName then return true end
        end
    end
    return false
end
return this