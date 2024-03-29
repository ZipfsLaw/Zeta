--ZetaHook.lua
--Purpose: Overrides native functions for multiple mod support. 
--This automatically generates hooks for lua libraries listed below. All of these functions are listed in IH_Log.txt when Zeta's dev mode is enabled.
--You can override native functions, or use them to trigger your functions in your own Zeta scripts. Any functions that return a value will override the native function it hooks.
--[[
    EXAMPLE: If you want to override "TppPlayer.Warp", or use it as a trigger, add the following snippet to your Zeta module:
    function this.TppPlayerWarp(info)
        --Your code here
        return 0 --Your function must always return a value to override the native function.
    end
]]
local this={
    tppLibraries={ --TODO: Add more libraries to automatically hook. Most entries are from "Assets/tpp/script/lib/"
        "Tpp",
        "TppAnimal",
        "TppAnimalBlock",
        "TppCassette",
        "TppCheckPoint",
        "TppClock",
        "TppCollection",
        "TppDemoBlock",
        "TppDevelopFile",
        "TppEmblem",
        "TppEnemy",
        "TppEneFova",
        "TppFreeHeliRadio",
        "TppGeneInter",
        "TppHelicopter",
        "TppHero",
        "TppInterrogation",
        "TppLandingZone",
        "TppLocation",
        "TppMain",
        "TppMarker",
        "TppMbFreeDemo",
        "TppMovie",
        "TppPackList",
        "TppPaz",
        "TppPlayer",
        "TppQuest",
        "TppRadio",
        "TppRanking",
        "TppRatBird",
        "TppReinforceBlock",
        "TppResult",
        "TppReward",
        "TppRevenge",
        "TppSave",
        "TppScriptBlock",
        "TppSequence",
        "TppSound",
        "TppStory",
        "TppTerminal",
        "TppTelop",
        "TppTrap",
        "TppTrophy",
        "TppTutorial",
        "TppUI",
        "TppWeather",
        "TppVarInit",
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