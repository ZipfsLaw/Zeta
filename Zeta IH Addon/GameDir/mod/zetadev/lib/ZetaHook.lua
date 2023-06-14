--ZetaHook.lua
--Purpose: Overrides native functions recursively for multiple mod support. 
--This automatically generates hooks for a number of lua libraries listed below. All of these functions are listed in IH_Log.txt when Zeta's dev mode is enabled.
local this={
    tppLibraries={ --TODO: Add more libraries to automatically hook.
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
    for i, libName in ipairs(this.tppLibraries)do
        local lib = _G[libName]
        if lib ~= nil then
            for key, val in pairs(lib)do
                if val ~= nil then
                    if type(val) == "function" then
                        local funcName = libName..key
                        local newOverride = function(...)return ZetaIndex.ModReturn(funcName,...)end
                        this.AddHook(libName.."."..key,newOverride)
                    end
                end
            end
        end
    end
    --Show all hooks generated
    if ZetaVar.IsZetaInDevMode() == true then  
        ZetaCore.Log("Creating hooks for Zeta modules.","ZetaHook",false) 
        local numOfFuncs = 0
        for hookName,hookFunc in pairs(this.hooks) do
            local correctName = string.gsub(hookName,"[.]","") --Removes periods from names of exported hooked functions
            ZetaCore.Log(correctName,"ZetaHook",false) 
            numOfFuncs = numOfFuncs + 1
        end
        ZetaCore.Log("Generated "..numOfFuncs.." functions for use in Zeta modules.","ZetaHook",false) 
    end
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
            this.hooks[funcName] = true --Add to hooks table
            ZetaUtil.StringToTable(funcName, this.natives, ZetaUtil.StringToTable(funcName,_G) ) --Save native
            ZetaUtil.StringToTable(funcName, _G, this.CreateHook(funcName, overrideFunc, this.natives)) --Override native
        else ZetaUtil.StringToTable(funcName, _G, this.CreateHook(funcName, overrideFunc, _G))end --Use new override for native
    end
end
function this.ContainsHook(funcName)
    if this.hooks ~= nil and next(this.hooks) then
        if this.hooks[funcName] ~= nil then return true end
    end
    return false
end
function this.NativeFunction(funcName,...)
    local nativeFunc = ZetaUtil.StringToTable(funcName, this.natives)
    if nativeFunc == nil then return nil end
    return nativeFunc(...)
end
return this