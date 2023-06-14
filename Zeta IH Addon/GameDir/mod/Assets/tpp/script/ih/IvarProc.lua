--IvarProc.lua
--Purpose: Overrides IH's IvarProc, runs Zeta right after evars are loaded.
Script.LoadLibrary"/Assets/tpp/script/ih/IvarProc.lua" --Internally load IvarProc ( since the external version isn't loaded yet )
if IvarProc == nil then 
	InfCore.Log("[ERROR] Can't load '/Assets/tpp/script/ih/IvarProc.lua'! Check if Infinite Heaven is installed properly!",true,true) --Make error if missing
	return nil --Return if file's missing
end 
local LoadEvars = IvarProc.LoadEvars --Save LoadEvars function
IvarProc.LoadEvars = function() --Override LoadEvars function
	LoadEvars() --Run saved LoadEvars function
	IvarProc.LoadEvars = LoadEvars --Restore LoadEvars function
	Script.LoadLibrary"/Assets/tpp/script/zeta/ZetaInit.lua" --Load packed ZetaInit lua script.
end
local ApplyProfile = IvarProc.ApplyProfile --Save ApplyProfile function
IvarProc.ApplyProfile = function(...) --Override ApplyProfile function
	if ZetaIndex ~= nil then ZetaIndex.blockRebuilding = true end --Prevent hitch caused by ApplyProfile
	ApplyProfile(...) --Run saved ApplyProfile function
	if ZetaIndex ~= nil then ZetaIndex.blockRebuilding = false end --Prevent hitch caused by ApplyProfile
end
return IvarProc --Return internally loaded IvarProc instead.