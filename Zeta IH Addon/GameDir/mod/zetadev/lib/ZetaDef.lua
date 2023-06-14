--ZetaDef.lua
--Purpose: Where Zeta defines are. 
local this={
	--Module Info
	modVersion=20,
	modName="Zeta",
	modIntroText="( IH Add-on )",
	--Common Filepaths
	modFolder="zeta",
	modDevFolder="zetadev",
	modSvarSave="zeta_svars.lua",
	modPrevSvarSave="zeta_svars_prev.lua",
	--Common Defs
	settingsName = "ZetaSetting",
	customSettingsName = "ZetaCustomSetting",
	loadOrderName = "ZetaOrder",
	modActiveName = "Zeta",
	modFaveName = "ZetaFave",
	--Common Strings
	zetaMenuModToggle = "Active",
	zetaMenuModOrder = "Load Order",
	zetaMenuModFave = "Favorite",
	zetaMenuModToggleDesc = "Enables or disables ",
	zetaMenuModOrderDesc = "Changes the load order of ",
	zetaMenuModFaveDesc = "Add selected mod to Favorites menu!",
	settingOptionLabel = "Settings for ",
	errorLoadMsg = "Can not be loaded. Check the file for errors!",
}
--Purpose: Defining nil enums for merging
TppEquip.UD_None = TppEquip.UB_None
TppEquip.LS_None = TppEquip.LT_None
return this