--ZetaMenu.lua
--Description: Adds functions that simplifies menu creation in IHHook's overlay.
local this={}
local Ivars=Ivars

--Menu Option Functions
function this.ReloadFunc() 
	if ZetaCore ~= nil then ZetaCore.ReloadMods()end
end
function this.NumberOption(itemMin,itemMax,itemInc,itemDefault,onFuncChange,onFuncSelect)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range={min=itemMin or -math.huge,max=itemMax or math.huge,increment=itemInc or 0.1},
		OnChange = onFuncChange or this.ReloadFunc,
		OnSelect = onFuncSelect,
		default = itemDefault or 0,
	} 
	return ret
end
function this.BoolOption(itemDefault,onFuncChange,onFuncSelect)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range=Ivars.switchRange,
		settingNames="set_switch",
		OnChange = onFuncChange or this.ReloadFunc,
		OnSelect = onFuncSelect,
		default = itemDefault or 0,
	} 
	return ret
end
function this.ListOption(itemSettings,itemDefault,onFuncChange,onFuncSelect,getSettingText)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		settings=itemSettings,
		OnChange = onFuncChange or this.ReloadFunc,
		OnSelect = onFuncSelect,
		GetSettingText = getSettingText,
		default = itemDefault or 0,
	} 
	return ret
end

--Internal Menu Functions
function this.CreateMenu(menu, menuParents, menuOptions, optionName, engName, engHelp)
	--Set the menu's parents and options
	local modSafeName = optionName.."Menu"
	local newParents = menuParents
	if type(newParents) ~= "table" then newParents = {menuParents,} end
	menu[menuOptions] = {}
	menu[modSafeName] = {
		parentRefs=newParents,
		options=menu[menuOptions]
	}
	--Display text
	this.CreateLangStrings( menu, modSafeName, optionName, engName, engHelp )
	--Register menu
	table.insert( menu.registerMenus, modSafeName )
end
function this.AddItemToMenu(menu, menuItem, menuOptions, optionName, engName, engHelp)
	--Register Ivars, add options to menu
	local modSafeName = optionName
	if type(menuItem) == "function" then
		modSafeName = ZetaUtil.firstToLower(optionName)
		table.insert( menu[menuOptions], "ZetaUI."..optionName )
	else
		table.insert( menu.registerIvars, optionName )
		table.insert( menu[menuOptions], "Ivars."..optionName )
	end
	--Callback
	local modFunc = { optionName, menuItem }
	menu[modFunc[1]] = modFunc[2]
	--Display text
	this.CreateLangStrings( menu, modSafeName, optionName, engName, engHelp )
end
function this.CreateLangStrings( menu, modSafeName, optionName, engName, engHelp)
	if engName ~= nil then menu.langStrings["eng"][modSafeName] = engName else menu.langStrings["eng"][modSafeName] = optionName end
	if engHelp ~= nil then menu.langStrings["help"]["eng"][modSafeName] = engHelp else menu.langStrings["help"]["eng"][modSafeName] = ZetaDef.settingOptionLabel..optionName end
end
function this.CreateModLoadMenu(menu, modDirectories, altDirectories )
	if ZetaIndex ~= nil then
		local zetaModules = ZetaIndex.luaModsFiles
		if zetaModules ~= nil and next(zetaModules) then
			for fileName,zetaModule in pairs(zetaModules)do
				--Mod enabled, Mod name, description, category, author
				local modOption = zetaModule.zetaUniqueName
				local modName = zetaModule.modName
				local modDesc = zetaModule.modDesc
				local modCategory = zetaModule.modCategory
				local modAuthor = zetaModule.modAuthor
				--Is mod disabled by default?
				local isModEnabled = 1
				if zetaModule.modDisabledByDefault == true then isModEnabled = 0 end			
				--Mod Menu Items		
				local menuItems = {{options = {},}}
				if zetaModule.ModMenu ~= nil then --Does the mod have its own menu options?
					local modSettings = zetaModule.ModMenu()
					if modSettings ~= nil and next(modSettings)then menuItems = modSettings end
				end
				local rootModMenu = menuItems[1]
				if rootModMenu ~= nil and next(rootModMenu) then
					if rootModMenu.options ~= nil then
						table.insert(rootModMenu.options,1,{ --Adds "Favorite" option right below the "Load Order" option
							ivar = ZetaDef.modFaveName..modOption,
							name = "Favorite",
							desc = "Add selected mod to Favorites menu!",
							default = 0,
							func = function() menu.ReloadMenu() end
						})
						table.insert(rootModMenu.options,1,{ --Adds "Load Order" option right below the "Active" option
							ivar = ZetaDef.loadOrderName..modOption, 
							name = "Load Order",
							desc = "Changes the load order of "..modName,
							number = {min=1,max=100,inc=1},
							default = 1,
						})
						if zetaModule.modIsToggleable ~= false then 
							table.insert(rootModMenu.options,1,{ --Adds "Active" option to the top
								ivar = ZetaDef.modActiveName..modOption, 
								name = "Active",
								desc = "Enables or disables "..modName,
								default = isModEnabled,
							})
						end
					end
				end
				--Mod author added to mod description
				if modAuthor ~= nil then 	
					local authorLabel = nil					
					if type(modAuthor) == "string" then
						authorLabel = modAuthor
					elseif type(modAuthor) == "table" then
						for x,curAuthor in ipairs(modAuthor)do
							if authorLabel ~= nil then authorLabel = authorLabel..", "..curAuthor else authorLabel = curAuthor end
						end
					end
					if authorLabel ~= nil then 
						if modDesc ~= nil then modDesc = modDesc.." Created by "..authorLabel.."." else modDesc = "Created by "..authorLabel.."." end
					end
				end			
				--Menu parents
				local parentRefs = {}
				if ZetaVar.Ivar({ivar=ZetaDef.modFaveName..modOption,default=0,evars=true}) >= 1 then table.insert(parentRefs, "ZetaUI.favoritesMenu" ) end
				--Mod directories ( Categories, authors, all )
				for i,modDir in ipairs(modDirectories) do
					local modDirectory = {}
					local menuLoc = {modDir.menu}
					local prefix = modDir.prefix
					if altDirectories ~= nil then --Use new menu parent
						if altDirectories.prefix ~= nil then prefix = altDirectories.prefix end
						if altDirectories.menu ~= nil then menuLoc = {altDirectories.menu} end
					end
					if modDir.sort == 2 then --By Category
						if modCategory ~= nil then 
							if type(modCategory) == "string" then table.insert(modDirectory, { menuName=modCategory, menuDesc="Mod category for "..modCategory.."."})
							elseif type(modCategory) == "table" then
								for x,curCategory in ipairs(modCategory)do table.insert(modDirectory, { menuName=curCategory, menuDesc="Mod category for "..curCategory.."."}) end
							end
						else table.insert(modDirectory, { menuName="(Uncategorized)", menuDesc="Mod category for uncategorized mods."}) end
					elseif modDir.sort == 3 then --By Author
						if modAuthor ~= nil then 	
							if type(modAuthor) == "string" then table.insert(modDirectory, { menuName=modAuthor, menuDesc="All mods by "..modAuthor.."."})
							elseif type(modAuthor) == "table" then
								for x,curAuthor in ipairs(modAuthor)do table.insert(modDirectory, { menuName=curAuthor, menuDesc="All mods by "..curAuthor.."."}) end
							end
						else table.insert(modDirectory, { menuName="(Various)", menuDesc="All mods by various modders."}) end
					end
					if modDirectory ~= nil and next(modDirectory) then
						for i,menuInfo in pairs(modDirectory)do
							local newMenuName = menuInfo.menuName..prefix
							if menu[newMenuName] == nil then
								this.CreateMenu(menu, menuLoc, newMenuName, newMenuName, menuInfo.menuName, menuInfo.menuDesc)
								if menu.modMenus ~= nil then table.insert(menu.modMenus, newMenuName) end
							end
							table.insert(parentRefs, "ZetaUI."..newMenuName.."Menu" )
						end	
					else table.insert(parentRefs, "ZetaUI."..prefix.."Menu" ) end
				end	
				this.RecursiveMenu(menu, menuItems, zetaModule, parentRefs, prefix ) 
			end
		end
	end
end
--Organizes options/settings
function this.RecursiveMenu(menu, results, module, prevParent, tabIndex)
	local parentFix = prevParent
	if type(prevParent) ~= "table" then parentFix = {prevParent,} end
	for i,modMenu in ipairs(results)do  
		--Mod lang entries
		local engName = modMenu.name
		local engHelp = modMenu.desc
		if modMenu.options ~= nil then --If menu name and description weren't set, use the mod's info.
			if engName == nil then
				local modName = module.modName
				if modName ~= nil then engName = modName end
			end
			if engHelp == nil then
				local modDesc = module.modDesc
				if modDesc ~= nil then engHelp = modDesc end
			end
		end
		--Menu vars must remain unique and in order
		local curTabIndex = tabIndex
		if curTabIndex == nil then curTabIndex = i end
		local uniqueName = module.zetaUniqueName
		local menuInfo = { 
			options = uniqueName..curTabIndex.."Options",
			settings = uniqueName..curTabIndex.."Settings",
			menu = "ZetaUI."..uniqueName..curTabIndex.."SettingsMenu",
		}
		--Menu
		if modMenu.options ~= nil then --If Options are set, it becomes a menu.
			local newTabIndex = tabIndex
			if newTabIndex ~= nil then newTabIndex = tabIndex..i else newTabIndex = i end
			local newMenuInfo = { 
				options = uniqueName..newTabIndex.."Options",
				settings = uniqueName..newTabIndex.."Settings",
				menu = "ZetaUI."..uniqueName..newTabIndex.."SettingsMenu",
			}
			this.CreateMenu(menu, parentFix, newMenuInfo.options, newMenuInfo.settings, engName, engHelp)
			this.RecursiveMenu(menu, modMenu.options, module, newMenuInfo.menu, newTabIndex)
		end
		--Option Types
		local optionVar = modMenu.var or modMenu.ivar --Looks for var or ivar
		if optionVar ~= nil then
			local menuItem = nil --Zeta menu option
			local defaultVal = modMenu.default or 0 --Option's default value
			local itemName = optionVar --Option var name
			if modMenu.var ~= nil then itemName = ZetaDef.customSettingsName..uniqueName..optionVar end --If var isn't nil, add setting prefix 
			if modMenu.command ~= nil then menuItem = module[modMenu.command] 
			elseif modMenu.list ~= nil then menuItem = this.ListOption(modMenu.list,defaultVal,modMenu.func,modMenu.select,modMenu.text) -- Creates an option index based on a list. Example: {"option 1","option 2", "option 3"}
			elseif modMenu.number and next(modMenu.number) ~= nil then menuItem = this.NumberOption(modMenu.number.min,modMenu.number.max,modMenu.number.inc,defaultVal,modMenu.func,modMenu.select) -- Example: Minimum, maximum, and increment. {min=0,max=100,inc=1} 
			else menuItem = this.BoolOption(defaultVal,modMenu.func) end --if modMenu.bool ~= nil or menuItem == nil then
			if menuItem ~= nil then this.AddItemToMenu(menu, menuItem, menuInfo.options, itemName, engName, engHelp) end
		end
	end
end
function this.ClearDuplicateMenuOptions(menuDef, reverse)
	if menuDef ~= nil then
		menuDef.options = ZetaUtil.RemoveDuplicates(menuDef.options, reverse) 
		if menuDef.parentRefs ~= nil then
			for k,parentRef in ipairs(menuDef.parentRefs)do
				local parentMenu= InfCore.GetStringRef(parentRef)
				if parentMenu ~= nil then this.ClearDuplicateMenuOptions(parentMenu, reverse) end
			end
		end
	end
end
return this