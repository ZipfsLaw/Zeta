--ZetaIH.lua
--Description: Utilizes IH's modules
local this={
    ihModuleInfos = { 
        {module="InfSoldierFaceAndBody", funcName="BodyInfo", var="bodyInfos"},
        {module="InfSoldierFaceAndBody", funcName="FovaInfo", var="fovaInfos"},
        {module="InfMission", funcName="MissionInfo", var="missionsInfo", set="missionCode"},
        {module="InfMission", funcName="LocationInfo", var="locationInfo", set="locationId"},
        {module="InfQuest", funcName="QuestInfo", var="ihQuestsInfo",set=false},
    },
}
function this.Reload()	
    for x, infoTable in ipairs( this.ihModuleInfos ) do 
        local module = _G[infoTable.module]
        if module ~= nil then
            local newInfos = ZetaIndex.ModGetWithModules(infoTable.funcName, this) 
            if newInfos ~= nil and next(newInfos) then
                for y, info in ipairs( newInfos ) do 
                    local setVar = info.module.zetaUniqueName
                    if info.set == nil then setVar = setVar..".lua" --Adds lua ext 
                    elseif info.set == false then setVar = setVar --Doesn't add lua ext
                    elseif type(info.set) == "string" then setVar = info.set end --Set by table param
                    module[infoTable.var][setVar] = info.results 
                end
            end
        end	
    end
end
return this