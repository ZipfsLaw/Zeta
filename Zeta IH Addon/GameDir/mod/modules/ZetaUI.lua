--ZetaUI.lua
--Description: Generates menus for all of the Zeta modules, and rolls them into one. Has settings for Zeta as well.
local this={}
function this.Reload()
	--Initialize/clean up ivars, menus, lang, loose vars
	for funcName,menuFunc in pairs(this)do
		if type(menuFunc) == "table" then this[funcName] = nil end
	end
	if InfLang ~= nil then --ZIP: Infinite Heaven always falls back to English due to a condition that checks if a langaugeId has been set in Ivars.
		local languages = {"eng","ara","cht","fre","ger","ita","jpn","kor","por","rus","spa" } --ZIP: Declare help strings for other languages.
		for i,langId in ipairs(languages)do 
			if Ivars[langId] == nil then --If language hasn't been setup yet
				if InfLang[langId] == nil then InfLang[langId] = {} end --Names
				if InfLang["help"][langId] == nil then InfLang["help"][langId] = {} end --Descriptions
				Ivars[langId] = true --Allow language to be used.
			end
		end
	end
	this.registerIvars={} 
	this.registerMenus={}
	this.langStrings={eng = {},ara = {},cht = {},fre = {},ger = {},ita = {},jpn = {},kor = {},por = {},rus = {},spa = {},help = {eng = {},ara = {},cht = {},fre = {},ger = {},ita = {},jpn = {},kor = {},por = {},rus = {},spa = {}}}
	if ZetaMenu == nil then return nil end --Return if ZetaMenu isn't loaded
	local zetaDirectory = { --Initialize Zeta Menu
		ivar="zetaRoot",name="Zeta Menu",desc="Manage mods through Zeta",
		options = {
			{ 
				ivar="generalSettings",name=ZetaDef.generalSettings.name,desc=ZetaDef.generalSettings.desc,
				options = {
					{
						ivar=ZetaDef.settingsName.."ZetaActive",
						name="Zeta", desc="If disabled, Zeta mods will no longer apply. Some mods might require a restart to disabled. (Enabled by default)",
						func=function()this.ReloadMenu()end,
						default=1,
					},
					{
						ivar=ZetaDef.settingsName.."UseZetaInFOB", 
						name="Zeta in FOB", desc="When enabled, allows Zeta to run in FOB. (Disabled by default. Should be disabled to prevent online bans)",
						func=function()end,
					},
					{
						ivar=ZetaDef.settingsName.."UseCustomizedWeaponsInFOB",
						name="Customized Weapons in FOB", desc="When disabled, customized weapons are disabled in sortie prep until you return to ACC. (Enabled by default)",
						func=function()end,
						default=1,
					},
					{
						ivar=ZetaDef.settingsName.."ModListViewType", 
						name="List Appearance", desc="Changes the list appearance of the Mod Management menu.",
						list={ "Detailed", "Show All Mods", "By Category", "By Author" },
						func=function()this.ReloadMenu()end,
						default=2,
					},
					{
						ivar=ZetaDef.settingsName.."InDevMode", 
						name="Developer Mode", desc="When enabled, logs additional information in ih_log.txt (Disabled by default)",
						func=function()this.ReloadMenu()end,
					},
				},
			},
			{ivar="modManagement",name=ZetaDef.modManagement.name,desc=ZetaDef.modManagement.desc,options={},},
			{ivar="reloadMods",name=ZetaDef.reloadMods.name,desc=ZetaDef.reloadMods.desc,command=function() ZetaCore.ReloadMods{showMsg=true} end,},
			{ivar="favorites",name=ZetaDef.favoriteMods.name,desc=ZetaDef.favoriteMods.desc,options={},},
		},
	}
	ZetaMenu.RecursiveMenu(this, zetaDirectory, {"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"}, "Main" ) 
	--Mod Management
	local modDirectories = {
		{var="showAllMods", name=ZetaDef.showAllMods.name, help=ZetaDef.showAllMods.desc}, --Show all mods
		{sort=function(modDirectory,modCategory,modAuthor,fileName) --By Category
			if modCategory ~= nil then 
				if type(modCategory) == "string" then table.insert(modDirectory, { menuName=modCategory, menuDesc="Mod category for "..modCategory.."."})
				elseif type(modCategory) == "table" then for x,curCategory in ipairs(modCategory)do table.insert(modDirectory, { menuName=curCategory, menuDesc="Mod category for "..curCategory.."."}) end
				end
			else table.insert(modDirectory, { menuName="(Uncategorized)", menuDesc="Mod category for uncategorized mods."}) end
		end,var="byCategory", name=ZetaDef.categories.name, help=ZetaDef.categories.desc},
		{sort=function(modDirectory,modCategory,modAuthor,fileName) -- By Author
			if modAuthor ~= nil then 	
				if type(modAuthor) == "string" then table.insert(modDirectory, { menuName=modAuthor, menuDesc="All mods by "..modAuthor.."."})
				elseif type(modAuthor) == "table" then for x,curAuthor in ipairs(modAuthor)do table.insert(modDirectory, { menuName=curAuthor, menuDesc="All mods by "..curAuthor.."."}) end
				end
			else table.insert(modDirectory, { menuName="(Various)", menuDesc="All mods by various modders."}) end
		end,var="byAuthor", name=ZetaDef.authors.name, help=ZetaDef.authors.desc},
		{sort=function(modDirectory,modCategory,modAuthor,fileName) -- By Disabled/Enabled ( Detailed sorting mode only )
			if ZetaIndex.IsModEnabled(fileName) == true then table.insert(modDirectory, { menuName="Enabled", menuDesc="All enabled Zeta mods."})
			else table.insert(modDirectory, { menuName="Disabled", menuDesc="All disabled Zeta mods."}) end
		end,var="byActive", name=ZetaDef.enabledDisabled.name, help=ZetaDef.enabledDisabled.desc},
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
			local menuItems = {} --Loaded mod menu items.
			if zetaModule.ModMenu ~= nil then --Does the mod have its own menu options?
				local success,result = pcall(zetaModule["ModMenu"]) --Looks for mod menu function. If none is found, or if there's an issue, it will create a menu anyways.
				if success == false then ZetaCore.Log(modOption..".ModMenu","Error") elseif result ~= nil and next(result) then 
					for x,menuItem in ipairs(result) do 
						if menuItem.options ~= nil and next(menuItem.options) and menuItem.name == nil then --Menus with no name will have their options added to the root menu.
							for y,innerMenuItem in ipairs(menuItem.options) do table.insert(menuItems,innerMenuItem) end 
						else table.insert(menuItems,menuItem) end --If it's a defined menu, or options meant to be added.
					end	
				end 
			end
			if menuItems.options == nil then menuItems = {options = menuItems,} end --If the table returned is a menu, build upon it instead.
			if menuItems ~= nil and next(menuItems) then
				if menuItems.name == nil then menuItems.name = modName end
				if menuItems.desc == nil then menuItems.desc = modDesc end
				if menuItems.options ~= nil then
					--Default mod menu. Adds options found in Zeta module.
					local modMenuItems = { 
						--{ivar=ZetaDef.settingsName.."ReturnToMenu",name="Back to Zeta Menu",desc="Return to the Zeta Menu",command=function() InfMenu.GoMenu(this.zetaRootMenu,true) end }, --Adds "Go back" option for the Zeta Menu
						{ivar=ZetaDef.modFaveName..modOption,name=ZetaDef.zetaMenuModFave.name,desc=ZetaDef.zetaMenuModFave.desc,default = 0,func=function() this.ReloadMenu() end }, --Adds "Favorite" option right below the "Load Order" option
						{ivar=ZetaDef.loadOrderName..modOption,name=ZetaDef.zetaMenuModOrder.name,desc=ZetaDef.zetaMenuModOrder.desc(modName),number={min=1,max=100,inc=1},default=modLoadOrder},--Adds "Load Order" option right below the "Active" option
						{ivar=ZetaDef.modActiveName..modOption,name=ZetaDef.zetaMenuModToggle.name,desc=ZetaDef.zetaMenuModToggle.desc(modName),default=isModEnabled, func=function() --Adds "Active" option to the top
								ZetaMenu.ReloadFunc()
								this.ReloadMenu() 
							end
						},
					}
					if zetaModule.modHasLoadOrder == false then modMenuItems[2] = {} end --Empty options do nothing
					if zetaModule.modIsToggleable == false then modMenuItems[3] = {} end --Empty options do nothing
					for i,modMenuItem in ipairs(modMenuItems) do table.insert(menuItems.options,1,modMenuItem) end					
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
			ZetaMenu.RecursiveMenu(this, menuItems, parentRefs, zetaModule.zetaUniqueName ) 
		end
	end
end
--Purpose: Refreshes Zeta menu, reloads Ivars and IH menus
function this.ReloadMenu(refreshFileList) 
	if InfMenu ~= nil then
		if InfMenu.currentMenu ~= nil and InfMenu.currentIndex ~= nil then
			if refreshFileList ~= false then InfCore.PCallDebug(InfCore.RefreshFileList) end --Reload files
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