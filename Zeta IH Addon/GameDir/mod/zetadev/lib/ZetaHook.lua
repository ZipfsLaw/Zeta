--ZetaHook.lua
--Purpose: Overrides native functions recursively for multiple mod support
local this={
    tppLibraries={
        "TppAnimalBlock",
        "TppCassette",
        "TppCheckPoint",
        "TppCollection",
        "TppEmblem",
        "TppFreeHeliRadio",
        "TppHelicopter",
        "TppInterrogation",
        "TppRadio",
        "TppRanking",
        "TppResult",
        "TppReward",
        "TppPlayer",
        "TppWeather",
        "TppEnemy",
        "TppHero",
    },
    natives={},
    hooks={},
}
function this.Reload() --Hooks numerous functions discovered in the libraries listed above
    local numOfFuncs = 0
    InfCore.Log( "["..ZetaDef.modName.."][ZetaHook] Creating hooks for Zeta modules.",false,true)
    for i, libName in ipairs(this.tppLibraries)do
        local lib = _G[libName]
        if lib ~= nil then
            for key, val in pairs(lib)do
                if val ~= nil then
                    if type(val) == "function" then
                        numOfFuncs = numOfFuncs + 1
                        local funcName = libName..key
                        InfCore.Log( "["..ZetaDef.modName.."][ZetaHook] "..funcName,false,true)
                        local newOverride = function(...)return ZetaIndex.ModReturn(funcName,...)end
                        this.AddHook(libName.."."..key,newOverride)
                    end
                end
            end
        end
    end
    InfCore.Log( "["..ZetaDef.modName.."][ZetaHook] Generated "..numOfFuncs.." functions for use in Zeta modules.",false,true)
end
function this.CreateHook(funcName, overrideFunc, hookTable)
    local newHook = function(...) 
        local overrideVal = overrideFunc(...)
        if overrideVal ~= nil then return overrideVal end --Return override value instead
        local nativeFunc = ZetaUtil.StringToTable(funcName, hookTable )
        if nativeFunc ~= nil then 
            local nativeVal = nativeFunc(...)
            if nativeVal ~= nil then return nativeVal end
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