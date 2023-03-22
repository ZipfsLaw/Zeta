--ZetaUI.lua
--Description: Generates menus for all of the Zeta modules, and rolls them into one. Has settings for Zeta as well.
local this={}
function this.Reload()
	--Initialize/clean up ivars, menus, lang, loose vars
	for funcName,menuFunc in pairs(this)do
		if type(menuFunc) == "table" then this[funcName] = nil end
	end
	this.registerIvars={} 
	this.registerMenus={}
	this.langStrings={eng={},help={eng={},}}
	if ZetaMenu == nil then return nil end --Return if ZetaMenu isn't loaded
	local zetaDirectory = { --Initialize Zeta Menu
		{ 
			ivar="zetaRoot",
			name="Zeta Menu",
			desc="Manage mods through Zeta",
			options = {
				{ 
					ivar="generalSettings",
					name="General Settings",
					desc="Change general settings for Zeta.",
					options = {
						{
							ivar=ZetaDef.settingsName.."ZetaActive",
							name="Zeta",
							desc="If disabled, mods will no longer apply. Some mods may require a restart to fully reset. (Enabled by default)",
							func=function()this.ReloadMenu()end,
							default=1,
						},
						{
							ivar=ZetaDef.settingsName.."UseZetaInFOB", 
							name="Zeta in FOB", 
							desc="When enabled, allows Zeta to run in FOB. (Disabled by default. Should be disabled to prevent online bans)",
							func=function()end,
						},
						{
							ivar=ZetaDef.settingsName.."UseCustomizedWeaponsInFOB",
							name="Customized Weapons in FOB",
							desc="When disabled, customized weapons are disabled in sortie prep until you return to ACC. (Enabled by default)",
							func=function()end,
							default=1,
						},
						{
							ivar=ZetaDef.settingsName.."ModListViewType", 
							name="List Appearance", 
							desc="Changes the appearance of the Mod Management menu.",
							list={ "Detailed", "Show All Mods", "By Category", "By Author" },
							func=function()this.ReloadMenu()end,
							default=2,
						},
						{
							ivar=ZetaDef.settingsName.."InDevMode", 
							name="Developer Mode", 
							desc="When enabled, logs additional information in ih_log.txt (Disabled by default)",
							func=function()this.ReloadMenu()end,
						},
					},
				},
				{
					ivar="modManagement",
					name="Mod Management",
					desc="Toggle, arrange and change the settings of mods.",
					options={},
				},
				{ivar="reloadMods",name="Reload Mods",desc="Reload all Zeta mods.",command=function() ZetaCore.ReloadMods{showMsg=true} end,},
				{ivar="favorites",name="Favorite Mods",desc="Keeps all of your favorite mods in one menu.",options={},},
			},
		},
	}
	ZetaMenu.RecursiveMenu(this, zetaDirectory, {"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"}, "" ) 
	--Mod Management
	local modDirectories = {
		{var="showAllMods", name="Show all mods", help="Displays all installed mods."}, --Show all mods
		{sort=function(modDirectory,modCategory,modAuthor,fileName) --By Category
			if modCategory ~= nil then 
				if type(modCategory) == "string" then table.insert(modDirectory, { menuName=modCategory, menuDesc="Mod category for "..modCategory.."."})
				elseif type(modCategory) == "table" then for x,curCategory in ipairs(modCategory)do table.insert(modDirectory, { menuName=curCategory, menuDesc="Mod category for "..curCategory.."."}) end
				end
			else table.insert(modDirectory, { menuName="(Uncategorized)", menuDesc="Mod category for uncategorized mods."}) end
		end,var="byCategory", name="Categories", help="Displays all categories for all installed mods."},
		{sort=function(modDirectory,modCategory,modAuthor,fileName) -- By Author
			if modAuthor ~= nil then 	
				if type(modAuthor) == "string" then table.insert(modDirectory, { menuName=modAuthor, menuDesc="All mods by "..modAuthor.."."})
				elseif type(modAuthor) == "table" then for x,curAuthor in ipairs(modAuthor)do table.insert(modDirectory, { menuName=curAuthor, menuDesc="All mods by "..curAuthor.."."}) end
				end
			else table.insert(modDirectory, { menuName="(Various)", menuDesc="All mods by various modders."}) end
		end,var="byAuthor", name="Authors", help="Displays all authors of all installed mods."},
		{sort=function(modDirectory,modCategory,modAuthor,fileName) -- By Disabled/Enabled ( Detailed sorting mode only )
			if ZetaIndex.IsModEnabled(fileName) == true then table.insert(modDirectory, { menuName="Enabled", menuDesc="All enabled Zeta mods."})
			else table.insert(modDirectory, { menuName="Disabled", menuDesc="All disabled Zeta mods."}) end
		end,var="byActive", name="Enabled/Disabled", help="Displays all enabled and disabled mods."},
	}
	--Detailed mode: Adds menus for categories, authors, and all mods.	
	--Sorted mode: Displays all mods installed, by category, or by author.
	local sortType = ZetaVar.Ivar{ivar=ZetaDef.settingsName.."ModListViewType",evars=true}
	if sortType > 0 then modDirectories = {modDirectories[sortType]} end
	this.CreateModManagementMenu( modDirectories ) 
end
--Purpose: Creates a series of menus for categories, authors, mods, settings.
function this.CreateModManagementMenu( modDirectories )
	if ZetaIndex == nil then return nil end --Make sure ZetaIndex loads
	local zetaModules = ZetaIndex.luaModsFiles
	if zetaModules ~= nil and next(zetaModules) then
		local modManagementPrefix = nil
		if #modDirectories > 1 then --Creates menus for all categories, authors, etc
			for i,modDir in ipairs(modDirectories) do ZetaMenu.CreateMenu(this, {"ZetaUI.modManagementMenu"}, modDir.var.."MenuOptions", modDir.var, modDir.name, modDir.help) end 
		else modManagementPrefix = "modManagement" end --If there's only one, use the mod management menu.
		for fileName,zetaModule in pairs(zetaModules)do
			--Mod enabled, Mod name, description, category, author
			local modOption = zetaModule.zetaUniqueName
			local modName = zetaModule.modName or ""
			local modDesc = zetaModule.modDesc or ""
			local modCategory = zetaModule.modCategory or ""
			local modAuthor = zetaModule.modAuthor or ""
			--Mod author(s) added to mod description
			if zetaModule.modAuthor ~= nil then 	
				local authorLabel = nil	
				if type(zetaModule.modAuthor) == "table" then 
					for x,curAuthor in ipairs(zetaModule.modAuthor)do
						if authorLabel ~= nil then authorLabel = authorLabel..", "..curAuthor else authorLabel = curAuthor end
					end
				elseif type(zetaModule.modAuthor) == "string" then authorLabel = zetaModule.modAuthor end --A single entry
				if authorLabel ~= nil then modDesc = modDesc.." Created by "..authorLabel.."." end 
			end
			--Is mod disabled by default?
			local isModEnabled = 1
			if zetaModule.modDisabledByDefault == true then isModEnabled = 0 end	
			local modLoadOrder = zetaModule.modLoadOrder or 1 --Is set to 1 if no modLoadOrder is found.		
			--Mod Menu Items		
			local menuItems = {{options = {},}}
			if zetaModule.ModMenu ~= nil then --Does the mod have its own menu options?
				local modSettings = zetaModule.ModMenu()
				if modSettings ~= nil and next(modSettings)then menuItems = modSettings end
			end
			local rootModMenu = menuItems[1]
			if rootModMenu ~= nil and next(rootModMenu) then
				if rootModMenu.name == nil then rootModMenu.name = modName end
				if rootModMenu.desc == nil then rootModMenu.desc = modDesc end
				if rootModMenu.options ~= nil then
					local activeOption = { --Adds "Active" option to the top
						ivar = ZetaDef.modActiveName..modOption, 
						name = "Active",
						desc = "Enables or disables "..modName,
						default = isModEnabled,
						func = function() 
							ZetaMenu.ReloadFunc()
							this.ReloadMenu() 
						end
					}
					if zetaModule.modIsToggleable == false then activeOption = {} end --Empty options do nothing
					local modMenuItems = { 
						{ --Adds "Favorite" option right below the "Load Order" option
							ivar = ZetaDef.modFaveName..modOption,
							name = "Favorite",
							desc = "Add selected mod to Favorites menu!",
							default = 0,
							func = function() this.ReloadMenu() end
						},
						{ --Adds "Load Order" option right below the "Active" option
							ivar = ZetaDef.loadOrderName..modOption, 
							name = "Load Order",
							desc = "Changes the load order of "..modName,
							number = {min=1,max=100,inc=1},
							default = modLoadOrder,
						},
						activeOption, --Adds "Active" option to the top
					}
					for i,modMenuItem in ipairs(modMenuItems) do table.insert(rootModMenu.options,1,modMenuItem) end	
					--[[table.insert(rootModMenu.options,{ --Adds "Go back" option for the Zeta Mnu
						ivar = ZetaDef.settingsName.."ReturnToMenu", 
						name = "Go back to Zeta Menu",
						desc = "Go back to the Zeta Menu",
						command = function() InfMenu.GoMenu(menu.zetaRootMenu,true) end,
					})]]					
				end
			end	
			--Menu parents
			local parentRefs = {}
			if ZetaVar.Ivar({ivar=ZetaDef.modFaveName..modOption,default=0,evars=true}) >= 1 then table.insert(parentRefs, "ZetaUI.favoritesMenu" ) end
			for i,modDir in ipairs(modDirectories) do --Mod directories ( Categories, authors, all )
				local modDirectory = {}
				local prefix = modManagementPrefix or modDir.var --If it's a single menu, don't create a new menu. Use the mod management menu itself.
				local menuLoc = {"ZetaUI."..prefix.."Menu"}
				if modDir.sort ~= nil then modDir.sort(modDirectory,modCategory,modAuthor,fileName) end --Run sort function
				if modDirectory ~= nil and next(modDirectory) then
					for i,menuInfo in pairs(modDirectory)do
						local newMenuName = menuInfo.menuName..prefix
						if this[newMenuName] == nil then ZetaMenu.CreateMenu(this, menuLoc, newMenuName, newMenuName, menuInfo.menuName, menuInfo.menuDesc) end
						table.insert(parentRefs, "ZetaUI."..newMenuName.."Menu" )
					end	
				else table.insert(parentRefs, "ZetaUI."..prefix.."Menu" ) end
			end	
			ZetaMenu.RecursiveMenu(this, menuItems, parentRefs, nil, zetaModule ) 
		end
	end
end
--Purpose: Refreshes Zeta menu, reloads Ivars and IH menus
function this.ReloadMenu() 
	if InfMenu ~= nil then
		if InfMenu.currentMenu ~= nil and InfMenu.currentIndex ~= nil then
			local menuWasOn = InfMenu.menuOn
			local lastLoc = { menu = InfMenu.currentMenu, option = InfMenu.currentIndex } --Cache current menu/option
			local cacheLogFunc = TppUiCommand.AnnounceLogView --Cache AnnounceLogView
			TppUiCommand.AnnounceLogView = function()end --Override so no notifications show
			if menuWasOn == true then InfMenu.MenuOff() end --Turn off menu
			this.Reload() --Reload Zeta's UI
			for i, coreModuleName in ipairs(InfModules.coreModules) do --Execute PostAllModulesLoad for core IH modules.
				local ihModule = _G[coreModuleName]
				if ihModule ~= nil then 
					if ihModule.PostAllModulesLoad ~= nil then ihModule.PostAllModulesLoad() end 
				end
			end
			for i,ihModule in ipairs(InfModules) do --Remove duplicate menu options in all active IH modules
				if ihModule.registerMenus ~= nil and next(ihModule.registerMenus) then
					for j,name in ipairs(ihModule.registerMenus)do
						local menuDef = ihModule[name]
						if menuDef ~= nil then
							if InfMenuDefs.IsMenu(menuDef) then ZetaMenu.ClearDuplicateMenuOptions(menuDef) end
						end
					end
				end
			end
			if menuWasOn == true then --Was the menu on? Reset menu view.
				InfMenu.menuOn = true --Must be set.
				InfMenu.OnActivate() --Turn off menu
				InfMenu.GoMenu(lastLoc.menu) --Go back to last menu before reload
				InfMenu.currentIndex = lastLoc.option --Go back to the last option selected before reload
				InfMenu.GetSetting() --Gets current setting
				InfMenu.DisplayCurrentSetting() --Displays current setting
			end
			TppUiCommand.AnnounceLogView = cacheLogFunc --Return AnnounceLogView
		end
	end
end --Reloads Zeta UI module seperately
this.Reload() --Load Menu
return this