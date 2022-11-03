--ZetaIH.lua
--Description: Utilizes IH's modules
local this={
    soldierFaceAndBodyInfos = {
        {funcName="BodyInfo", var="bodyInfos"},
        {funcName="FovaInfo", var="fovaInfos"},
    }
}
function this.Reload()	
    --InfSoldierFaceAndBody
    for x, infoTable in ipairs( this.soldierFaceAndBodyInfos ) do 
        local newInfos = ZetaIndex.ModGetWithModules(infoTable.funcName, this) 
        if newInfos ~= nil and next(newInfos) then
            for y, info in ipairs( newInfos ) do InfSoldierFaceAndBody[infoTable.var][info.module.zetaUniqueName..".lua"] = info.results end
        end	
    end
end
return this