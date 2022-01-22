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

this.sortTypeRangeLabel = { "Show All", "By Category", "By Author" }

if ZetaMenu ~= nil then
	--Create Mod Load Menu adds strings, options and ivars for each mod file
	ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modLoadMenu"}, false, "loadOptions", "Zeta", "Enables or disables " )
	ZetaMenu.CreateModLoadMenu(this, {"ZetaUI.modPriorityMenu"}, true, "priorityOptions", "ZetaOrder", "Changes the load order of " )
	
	--Zeta general settings
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1, function(self,setting) 
		if ZetaCore ~= nil then ZetaCore.SetModsEnabled(setting) end
	end),  
	"generalSettingOptions", 
	"ZetaSetting", 
	"SetAllMods", 
	"Set all mods", 
	"Enable or disable all mods.")

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end), 
	"generalSettingOptions", 
	"ZetaSetting", 
	"FOBProtection", 
	"FOB Protection", 
	"Disables mods temporarily for FOB. (Should be enabled to prevent online bans)")	

	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.BoolOption(1,function()end),  
	"generalSettingOptions", 
	"ZetaSetting", 
	"DevFlowProtection", 
	"Dev Flow Protection", 
	"Logs in and retrieves additional updates after toggling mods. (Requires internet. Prevents broken iDroid development flow.)")
	
	ZetaMenu.AddItemToMenu(
	this, 
	ZetaMenu.ListOption(this.sortTypeRangeLabel,1,function()InfMain.LoadExternalModules(true)end),  
	"generalSettingOptions", 
	"ZetaSetting", 
	"ModListSortType", 
	"Mod List Sorted By", 
	"Change how the mod list is sorted. By category will sort mods based on what the type of mod it is. By Author based on who created the mod.")
	
	ZetaMenu.CreateModMenus(this)
end

--Would put this menu in the customize menu, but the emblem options aren't in their own menu
--parentRefs={"InfMainTppIvars.customizeMenu"},
--parentRefs={"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"},
this.modManagementMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
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
