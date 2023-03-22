--Zeta.lua
local this={}
if ZetaCore~=nil then return ZetaCore end --If Zeta successfully loaded, return ZetaCore as a module
InfCore.Log("[ERROR] Zeta failed to load! Reinstall Zeta to make sure other mods haven't overwritten any files.",true,true) 
return this --Otherwise, return an empty module. 