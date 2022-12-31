--ZetaUI.lua
--Description: Generates menus for all of the Zeta modules, and rolls them into one. Has settings for Zeta as well.
local this={
	modMenus = {}, --Collects mod menus for refreshes
	modDirectories = { --ZetaMenu.CreateMenu/ZetaMenu.CreateModLoadMenu creates strings, options and ivars for each mod file
		{options="showAllModsMenuOptions", prefix="showAllMods", name="Show all mods", help="Displays all installed mods.",menu="ZetaUI.showAllModsMenu"},
		{options="byCategoryMenuOptions", prefix="byCategory",  name="By category", help="Displays mods by category.", menu="ZetaUI.byCategoryMenu"},
		{options="byAuthorMenuOptions", prefix="byAuthor",  name="By author", help="Displays mods by author.", menu="ZetaUI.byAuthorMenu"},
	},
}
function this.Reload()
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
	if this.modMenus ~= nil and next(this.modMenus) then --Were there mod menus? Clear them
		for i,modMenu in ipairs(this.modMenus) do this[modMenu] = nil end
		this.modMenus = {}
	end
	this.zetaRootOptions = {"ZetaUI.ReloadMods",}
	this.generalSettingOptions = {}
	this.modManagementOptions = {}
	this.zetaRootMenu={parentRefs={"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"},options=this.zetaRootOptions}
	this.generalSettingMenu={parentRefs={"ZetaUI.zetaRootMenu"},options=this.generalSettingOptions}
	this.modManagementMenu={parentRefs={"ZetaUI.zetaRootMenu"},options=this.modManagementOptions}
	if ZetaMenu ~= nil then
		--Zeta Settings
		ZetaMenu.AddItemToMenu(
		this, 
		ZetaMenu.BoolOption(1,function()this.ReloadMenu()end),  
		"generalSettingOptions", 
		"ZetaSettingZetaActive", 
		"Zeta", 
		"If disabled, mods will no longer apply. Some mods may require a restart to fully reset. (Enabled by default)")
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
		"When disabled, customized weapons are disabled in sortie prep until you return to ACC. (Enabled by default)")	
		local sortTypeRangeLabel = { "Detailed", "Show All Mods", "By Category", "By Author" }
		ZetaMenu.AddItemToMenu(
		this, 
		ZetaMenu.ListOption(sortTypeRangeLabel,2,function()this.ReloadMenu()end),  
		"generalSettingOptions", 
		"ZetaSettingModListViewType", 
		"List Appearance", 
		"Changes the appearance of the Mod Management menu.")	
		ZetaMenu.AddItemToMenu(
		this, 
		ZetaMenu.BoolOption(0,function()this.ReloadMenu()end), 
		"generalSettingOptions", 
		"ZetaSettingInDevMode", 
		"Developer Mode", 
		"When enabled, logs additional information in ih_log.txt (Disabled by default)")	
		--Dynamic Options
		local menuLoc = {"ZetaUI.modManagementMenu"}
		local sortType = ZetaVar.Ivar({ivar=ZetaDef.settingsName.."ModListViewType",default=0,evars=true})
		if sortType == 0 then --Detailed mode: Adds menus for categories, authors, and all mods.
			for i,modDir in ipairs(this.modDirectories) do
				ZetaMenu.CreateMenu(this, menuLoc, modDir.options, modDir.prefix, modDir.name, modDir.help)
				ZetaMenu.CreateModLoadMenu(this, {modDir.menu}, modDir.prefix, i ) --Show all mods
			end
		else --Sorted mode: Displays all mods installed, by category, or by author.
			ZetaMenu.CreateModLoadMenu(this, menuLoc, "modManagement", sortType ) 
		end 
	end
end
--Purpose: Refreshes Zeta menu, reloads Ivars and IH menus
function this.ReloadMenu() 
	if InfMenu ~= nil then
		if InfMenu.currentMenu ~= nil and InfMenu.currentIndex ~= nil then
			local lastLoc = { menu = InfMenu.currentMenu, option = InfMenu.currentIndex } --Cache current menu/option
			local cacheLogFunc = TppUiCommand.AnnounceLogView --Cache AnnounceLogView
			TppUiCommand.AnnounceLogView = function()end --Override so no notifications show
			this.Reload() --Reload Zeta's UI
			InfMenu.MenuOff() --Turn off menu
			for i, coreModuleName in ipairs(InfModules.coreModules) do --Execute PostAllModulesLoad for core IH modules. ( All are related to Ivar Setup )
				local ihModule = _G[coreModuleName]
				if ihModule ~= nil then 
					if ihModule.PostAllModulesLoad ~= nil then ihModule.PostAllModulesLoad() end --Initializes Ivars
				end
			end
			--Loaded last, since it isn't considered a core module. Updates Lang entries.
			InfLangProc.PostAllModulesLoad() 
			InfMenu.PostAllModulesLoad() 	
			--Remove duplicate menu options in all active IH modules
			for i,ihModule in ipairs(InfModules) do
				if ihModule.registerMenus ~= nil and next(ihModule.registerMenus) then
					for j,name in ipairs(ihModule.registerMenus)do
						local menuDef = ihModule[name]
						if menuDef ~= nil then
							if InfMenuDefs.IsMenu(menuDef) then ZetaMenu.ClearDuplicateMenuOptions(menuDef) end
						end
					end
				end
			end
			InfMenu.menuOn = true --Must be set.
			InfMenu.OnActivate() --Turn off menu
			InfMenu.GoMenu(lastLoc.menu) --Go back to last menu before reload
			InfMenu.currentIndex = lastLoc.option --Go back to the last option selected before reload
			TppUiCommand.AnnounceLogView = cacheLogFunc --Return AnnounceLogView
		end
	end
end --Reloads Zeta UI module seperately
--Purpose: Callback for both the mod menu and mod entries
function this.ReloadMods()
	if ZetaCore ~= nil then ZetaCore.ReloadMods({showMsg=true}) end
end
this.Reload() --Load Menu
return this