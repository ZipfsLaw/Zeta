--Zeta.lua
local this={}

if ZetaCore==nil then 
	Script.LoadLibrary"/Assets/tpp/script/zeta/main/ZetaStart.lua"
end
if ZetaCore ~= nil then
	return ZetaCore
end

return this