--ZetaInit.lua
--Purpose: Initiates start process of Zeta
local this={}
if InfCore ~= nil then --IH isn't installed
	--ZIP: It appears that both IH's "GetModuleName" and "LoadLibrary" are unable to load lua libraries externally.
	InfCore.GetModuleName = function(scriptPath) 
		local split=InfCore.Split(scriptPath,"/")
		local moduleName=split[#split]
		return string.sub(moduleName,1,string.len(moduleName) - string.len(".lua") )
	end
	InfCore.LoadExternalLibrary = function(path)
		local scriptPath=InfCore.paths.mod..path
		local ModuleChunk,loadError=LoadFile(scriptPath)
		if loadError then 
			InfCore.Log("ERROR: InfCore.LoadExternalLibrary:"..scriptPath..":"..loadError,false,true)
			return 
		end
		InfCore.Log("InfCore.LoadExternalLibrary "..tostring(scriptPath),false,true)
		local moduleName=InfCore.GetModuleName(scriptPath)
		_G[moduleName]=ModuleChunk()
	end
	InfCore.LoadExternalLibrary("zetadev/lib/ZetaStart.lua") --Run boot process
end
return this