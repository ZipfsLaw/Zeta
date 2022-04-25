--ZetaUI.lua
local this={}

this.registerIvars = {} 
this.registerMenus={
	"modManagementMenu",
	"generalSettingMenu",
	"modSettingMenu",
	
	"modLoadMenu",
	"modPriorityMenu",
	"modCustomMenu",
}

this.langStrings={
	eng={
		modManagementMenu="Zeta Menu",	
		generalSettingMenu="General Settings",
		modSettingMenu="Mod Management",
				
		modLoadMenu="Mod List",
		modPriorityMenu="Mod Load Order",
		modCustomMenu="Mod Settings",
		reloadMods="Reload Mods",
	},
	help={
		eng={
			modManagementMenu="The settings menu for Zeta. Manages every aspect of Zeta.",
			generalSettingMenu="Change general settings for Zeta.",
			modSettingMenu="Toggle, arrange and change the settings of mods.",

			modLoadMenu="Enable or disable mods.",
			modPriorityMenu="Arrange the load order of mods for compatibility.",
			modCustomMenu="Change settings of mods.",
			reloadMods="Reload all lua mods.",
		},
	}
}

this.modManagementOptions = {}
this.generalSettingOptions = {}
this.modSettingOptions = {"ZetaUI.ReloadMods",}

this.loadOptions = {}
this.priorityOptions = {}
this.customOptions = {}

this.sortTypeRangeLabel = { "Detailed", "Show All mods", "By Category", "By Author" }

if ZetaMenu ~= nil then
	--ZetaMenu.CreateMenu/ZetaMenu.CreateModLoadMenu creates strings, options and ivars for each mod file
	local sortType = ZetaVar.GetIvar("ZetaSettingModListViewType", 0, true )
	if sortType == 0 then 
		--Detailed mode: Adds menus for categories, authors, and all mods.
		ZetaMenu.CreateMenu(this, {"ZetaUI.modLoadMenu"}, "showAllModsMenuOptions", "showAllMods", "Show all mods", "Displays all installed mods.")
		ZetaMenu.CreateMenu(this, {"ZetaUI.modLoadMenu"}, "byAuthorMenuOptions", "byAuthor", "By author", "Displays mods by author.")
		ZetaMenu.CreateMenu(this, {"ZetaUI.modLoadMenu"}, "byCategoryMenuOptions", "byCategory", "By category", "Displays mods by category.")
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.showAllModsMenu"}, false, "showAllModsMenuOptions", "Zeta", "Enables or disables ", 1 ) --Show all mods
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.byCategoryMenu"}, false, "byCategoryMenuOptions", "Zeta", "Enables or disables ", 2 ) --Show mods by author
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.byAuthorMenu"}, false, "byAuthorMenuOptions", "Zeta", "Enables or disables ", 3 ) --Show mods by category
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modPriorityMenu"}, true, "priorityOptions", "ZetaOrder", "Changes the load order of ", 0 )
	else 
		--Sorted mode: Displays all mods installed, by category, or by author.
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modLoadMenu"}, false, "loadOptions", "Zeta", "Enables or disables ", sortType )
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modPriorityMenu"}, true, "priorityOptions", "ZetaOrder", "Changes the load order of ", sortType )
	end
	
	--Zeta general settings
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1, function(self,setting) this.ReloadMods() end),  
	"generalSettingOptions", 
	"ZetaSettingZetaActive", 
	"Zeta", 
	"If disabled, mods will no longer apply. Some mods may require a restart to fully reset. (Enabled by default.)")

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(0,function()InfMain.LoadExternalModules(true)end), 
	"generalSettingOptions", 
	"ZetaSettingModManagerInGame", 
	"Allow In-Game", 
	"When enabled, allows you to open the Zeta menu in-game. (Disabled by default. Could result in crashes! If changed, the IH menu will turn off so the Mod List can reset.)")

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.ListOption(this.sortTypeRangeLabel,0,function()InfMain.LoadExternalModules(true)end),  
	"generalSettingOptions", 
	"ZetaSettingModListViewType", 
	"List Appearance", 
	"Changes the appearance of the Mod List. (If changed, the IH menu will turn off so the Mod List can reset.)")	

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end),  
	"generalSettingOptions", 
	"ZetaSettingDevFlowProtection", 
	"Dev Flow Protection", 
	"Logs into Konami Server and retrieves additional updates after toggling mods that alter FOB items and/or weapons. (Enabled by default. Requires internet. Prevents broken iDroid development flow.)")

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end), 
	"generalSettingOptions", 
	"ZetaSettingFOBProtection", 
	"FOB Protection", 
	"Temporarily disables all mods while in FOB. (Enabled by default. Should be enabled to prevent online bans)")	

	ZetaMenu.CreateModMenus(this)
end

--While it's suggested to use Zeta's mod manager in the ACC, you can use it in-game if enabled in general settings.
local zetaParentRefs={"InfMenuDefs.safeSpaceMenu"} --ACC only
if ZetaVar.GetIvar("ZetaSettingModManagerInGame", 0, true ) == 1 then
	zetaParentRefs={"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"} --ACC, In-game, Cutscene
end
this.modManagementMenu={
	parentRefs=zetaParentRefs, --ACC only
	options=this.modManagementOptions
}

this.generalSettingMenu={
  parentRefs={"ZetaUI.modManagementMenu"},
  options=this.generalSettingOptions
}

this.modSettingMenu={
  parentRefs={"ZetaUI.modManagementMenu"},
  options=this.modSettingOptions
}

this.modLoadMenu={
  parentRefs={"ZetaUI.modSettingMenu"},
  options=this.loadOptions
}

this.modPriorityMenu={
  parentRefs={"ZetaUI.modSettingMenu"},
  options=this.priorityOptions
}

this.modCustomMenu={
  parentRefs={"ZetaUI.modSettingMenu"},
  options=this.customOptions
}

--Mod load functions
--Callback for both the mod menu and mod entries
function this.ReloadMods()
	if ZetaCore ~= nil then
		ZetaCore.ReloadMods({toggle=true,showMsg=true})
	end
end

return this
