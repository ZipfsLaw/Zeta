--ZetaIH.lua
--Description: Utilizes IH's modules
local this={
    ihModuleInfos = { 
        {module="InfBodyInfo",funcName="BodyInfo",set=function(module,var,set)
            module.bodyInfo[var]=set
            local gender=set.gender or "MALE"
            if not InfUtil.FindInList(module.bodies[gender],var) then table.insert(module.bodies[gender],var) end
            module.LoadBodyInfos()
        end},
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
                    if type(infoTable.set) == "function" then infoTable.set(module,setVar,info.results) else --Run set function if there is one
                        if infoTable.set == nil then setVar = setVar..".lua" --Adds lua ext 
                        elseif infoTable.set == false then setVar = setVar --Doesn't add lua ext
                        elseif type(infoTable.set) == "string" then setVar = infoTable.set end --Set by table param
                        module[infoTable.var][setVar] = info.results 
                    end
                end
            end
        end	
    end
end
return this