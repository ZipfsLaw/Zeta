local this ={}
this.modName = "Backwards Compatibility"
this.modDesc = "Toggle and arrange the load order of Non-Zeta mods."
this.modCategory = "Extensions"
this.modAuthor = "(ZIP)"

if ZetaNativeOverride ~= nil then
	ZetaNativeOverride.SetupBackwardsCompatibility(this)
end

return this