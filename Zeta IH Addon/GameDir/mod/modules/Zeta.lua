--Zeta.lua
local this={}
if ZetaCore==nil then Script.LoadLibrary"/Assets/tpp/script/zeta/lib/ZetaStart.lua" end --Run boot process
if ZetaCore~=nil then return ZetaCore end --If Zeta successfully loaded, return ZetaCore as a module
return this --Otherwise, return an empty module. 