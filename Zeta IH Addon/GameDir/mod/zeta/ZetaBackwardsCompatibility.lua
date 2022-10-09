local this ={
	modName = "Backwards Compatibility",
	modDesc = "Toggle and arrange the load order of Non-Zeta mods.",
	modCategory = "Extensions",
	modAuthor = "ZIP",
	isZetaModule = true,
}
if ZetaNativeOverride ~= nil then ZetaNativeOverride.SetupBackwardsCompatibility(this) end
return this