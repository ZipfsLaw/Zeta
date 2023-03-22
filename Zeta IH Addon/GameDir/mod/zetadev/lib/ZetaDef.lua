--ZetaDef.lua
--Purpose: Where Zeta defines are. 
local this={
	--Module Info
	modVersion=20,
	modName="Zeta",
	modIntroText="( IH Add-on )",
	--Module Filepaths
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
	--Messages
	settingOptionLabel = "Settings for ",
	errorLoadMsg = "Can not be loaded. Check the file for errors!",
}
return this