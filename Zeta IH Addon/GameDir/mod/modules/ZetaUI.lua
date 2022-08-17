--ZetaUI.lua
--Description: Gathers menus for all of the Zeta ports, and rolls them into one. Has settings for Zeta as well.
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
			modManagementMenu="Manage mods through Zeta",
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

if ZetaMenu ~= nil then
	--ZetaMenu.CreateMenu/ZetaMenu.CreateModLoadMenu creates strings, options and ivars for each mod file
	local sortType = ZetaVar.GetIvar("ZetaSettingModListViewType", 0, true )
	if sortType == 0 then 
		--Detailed mode: Adds menus for categories, authors, and all mods.
		local menuNames = {
			{ {"ZetaUI.modLoadMenu"}, "Enable", false, "Zeta", "Enables or disables "},
			{ {"ZetaUI.modPriorityMenu"}, "Priority", true, "ZetaOrder", "Changes the load order of " },
		}
		for i,menuName in ipairs(menuNames)do   
			local showAllMods = "showAllModsMenu"..menuName[2].."Options"
			local byCategory = "byCategoryMenu"..menuName[2].."Options"
			local byAuthor = "byAuthorMenu"..menuName[2].."Options"
			ZetaMenu.CreateMenu(this, menuName[1], showAllMods, "showAllMods"..menuName[2], "Show all mods", "Displays all installed mods.")
			ZetaMenu.CreateMenu(this, menuName[1], byCategory, "byCategory"..menuName[2], "By category", "Displays mods by category.")
			ZetaMenu.CreateMenu(this, menuName[1], byAuthor, "byAuthor"..menuName[2], "By author", "Displays mods by author.")
			ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.showAllMods"..menuName[2].."Menu"}, menuName[3], showAllMods, menuName[4], menuName[5], 1 ) --Show all mods
			ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.byCategory"..menuName[2].."Menu"}, menuName[3], byCategory, menuName[4], menuName[5], 2 ) --Show mods by author
			ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.byAuthor"..menuName[2].."Menu"}, menuName[3], byAuthor, menuName[4], menuName[5], 3 ) --Show mods by category
		end
	else 
		--Sorted mode: Displays all mods installed, by category, or by author.
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modLoadMenu"}, false, "loadOptions", "Zeta", "Enables or disables ", sortType )
		ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modPriorityMenu"}, true, "priorityOptions", "ZetaOrder", "Changes the load order of ", sortType )
	end
	
	--Zeta Settings
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1, function(self,setting) this.ReloadMods() end),  
	"generalSettingOptions", 
	"ZetaSettingZetaActive", 
	"Zeta", 
	"If disabled, mods will no longer apply. Some mods may require a restart to fully reset. (Enabled by default.)")

	local sortTypeRangeLabel = { "Detailed", "Show All mods", "By Category", "By Author" }
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.ListOption(sortTypeRangeLabel,0,function()InfMain.LoadExternalModules(true)end),  
	"generalSettingOptions", 
	"ZetaSettingModListViewType", 
	"List Appearance", 
	"Changes the appearance of the Mod List. (If changed, the IH menu will turn off so the Mod List can reset.)")	

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(0,function()InfMain.LoadExternalModules(true)end), 
	"generalSettingOptions", 
	"ZetaSettingModManagerInGame", 
	"Allow In-Game", 
	"When enabled, allows you to open the Zeta menu in-game. (Disabled by default. Could result in crashes! If changed, the IH menu will turn off so the Mod List can reset.)")	

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end),  
	"generalSettingOptions", 
	"ZetaSettingAcquireUpdates", 
	"Acquire Online Updates", 
	"Logs into Konami Server and retrieves additional updates after toggling mods that alter FOB items and/or weapons. (Enabled by default. Requires internet connection. Prevents broken iDroid development flow.)")

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
--Callback for both the mod menu and mod entries
function this.ReloadMods()
	if ZetaCore ~= nil then
		ZetaCore.ReloadMods({toggle=true,showMsg=true})
	end
end

return this
