--ZetaUI.lua
--Description: Generates menus for all of the Zeta modules, and rolls them into one. Has settings for Zeta as well.
local this={}
this.registerIvars={} 
this.registerMenus={
	"zetaRootMenu",
	"generalSettingMenu",
	"modManagementMenu",
}
this.langStrings={
	eng={
		zetaRootMenu="Zeta Menu",	
		generalSettingMenu="General Settings",
		modManagementMenu="Mod Management",				
		reloadMods="Reload Mods",
	},
	help={
		eng={
			zetaRootMenu="Manage mods through Zeta",
			generalSettingMenu="Change general settings for Zeta.",
			modManagementMenu="Toggle, arrange and change the settings of mods.",
			reloadMods="Reload all lua mods.",
		},
	}
}
this.zetaRootOptions = {"ZetaUI.ReloadMods",}
this.generalSettingOptions = {}
this.modManagementOptions = {}

--Dynamic Options
if ZetaMenu ~= nil then
	--Zeta Settings
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()this.ReloadMenu(this.generalSettingMenu)end),  
	"generalSettingOptions", 
	"ZetaSettingZetaActive", 
	"Zeta", 
	"If disabled, mods will no longer apply. Some mods may require a restart to fully reset. (Enabled by default. IH Menu will close if changed! )")
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(0,function()end), 
	"generalSettingOptions", 
	"ZetaSettingUseZetaInFOB", 
	"Zeta in FOB", 
	"When enabled, allows Zeta to run in FOB. (Disabled by default. Should be disabled to prevent online bans)")	
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end), 
	"generalSettingOptions", 
	"ZetaSettingUseCustomizedWeaponsInFOB", 
	"Customized Weapons in FOB", 
	"When disabled, customized weapons are disabled in sortie prep until you return to ACC. (Enabled by default. If you have any weapon mods active, you should enable this to prevent online bans)")	
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(0,function()this.ReloadMenu(this.generalSettingMenu)end), 
	"generalSettingOptions", 
	"ZetaSettingModManagerInGame", 
	"Allow In-Game", 
	"When enabled, allows you to open the Zeta menu in-game. (Disabled by default. Could result in crashes!  IH Menu will close if changed!)")	
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end),  
	"generalSettingOptions", 
	"ZetaSettingAcquireUpdates", 
	"Acquire Online Updates", 
	"Logs into Konami Server and retrieves additional updates after toggling mods that alter FOB items and/or weapons. (Enabled by default. Requires internet connection. Prevents broken iDroid development flow.)")
	local sortTypeRangeLabel = { "Detailed", "Show All Mods", "By Category", "By Author" }
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.ListOption(sortTypeRangeLabel,2,function()this.ReloadMenu(this.generalSettingMenu)end),  
	"generalSettingOptions", 
	"ZetaSettingModListViewType", 
	"List Appearance", 
	"Changes the appearance of the Mod Management menu. (IH Menu will close if changed!)")	

	--ZetaMenu.CreateMenu/ZetaMenu.CreateModLoadMenu creates strings, options and ivars for each mod file
	local menuLoc = {"ZetaUI.modManagementMenu"}
	local sortType = ZetaVar.GetIvar("ZetaSettingModListViewType", 0, true )
	if sortType == 0 then 
		--Detailed mode: Adds menus for categories, authors, and all mods.
		ZetaMenu.CreateMenu(this, menuLoc, "showAllModsMenuOptions", "showAllMods", "Show all mods", "Displays all installed mods.")
		ZetaMenu.CreateMenu(this, menuLoc, "byCategoryMenuOptions", "byCategory", "By category", "Displays mods by category.")
		ZetaMenu.CreateMenu(this, menuLoc, "byAuthorMenuOptions", "byAuthor", "By author", "Displays mods by author.")
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.showAllModsMenu"}, "showAllMods", 1 ) --Show all mods
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.byCategoryMenu"}, "byCategory", 2 ) --Show mods by author
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.byAuthorMenu"}, "byAuthor", 3 ) --Show mods by category
	else 
		--Sorted mode: Displays all mods installed, by category, or by author.
		ZetaMenu.CreateModLoadMenu(this, menuLoc, "modManagement", sortType )
	end
end

--While it's suggested to use Zeta's mod manager in the ACC, you can use it in-game if enabled in general settings.
local zetaParentRefs={"InfMenuDefs.safeSpaceMenu"} --ACC only
if ZetaVar ~= nil then
	if ZetaVar.GetIvar("ZetaSettingModManagerInGame", 0, true ) == 1 then
		zetaParentRefs={"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"} --ACC, In-game, Cutscene
	end
end
this.zetaRootMenu={
	parentRefs=zetaParentRefs,
	options=this.zetaRootOptions
}
this.generalSettingMenu={
	parentRefs={"ZetaUI.zetaRootMenu"},
	options=this.generalSettingOptions
}
this.modManagementMenu={
	parentRefs={"ZetaUI.zetaRootMenu"},
	options=this.modManagementOptions
}
--Callback for both the mod menu and mod entries
function this.ReloadMods()
	if ZetaCore ~= nil then ZetaCore.ReloadMods({showMsg=true}) end
end
--Reloads menu, then opens it again
function this.ReloadMenu(curMenu) InfMain.LoadExternalModules(true) end --TODO: Make it return to last menu
return this
