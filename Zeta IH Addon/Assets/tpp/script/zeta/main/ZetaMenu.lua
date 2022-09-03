--ZetaMenu.lua
--Description: Adds functions that simplifies menu creation in IHHook's overlay.
local this={}
local Ivars=Ivars

--Menu Option Functions
function this.NumberOption(itemMin,itemMax,itemInc,itemDefault,onFuncChange,onFuncSelect)
	local optionFunc = onFuncChange
	if optionFunc == nil then 
		optionFunc = function()ZetaCore.ReloadMods()end	
	end
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range={min=itemMin,max=itemMax,increment=itemInc},
		default=itemDefault,
		OnChange=optionFunc,
		OnSelect=onFuncSelect,
	} 
	return ret
end
function this.BoolOption(itemDefault,onFuncChange,onFuncSelect)
	local optionFunc = onFuncChange
	if optionFunc == nil then 
		optionFunc = function()ZetaCore.ReloadMods()end	
	end
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range=Ivars.switchRange,
		default=itemDefault,
		settingNames="set_switch",
		OnChange=optionFunc,
		OnSelect=onFuncSelect,
	} 
	return ret
end
function this.ListOption(itemSettings,itemDefault,onFuncChange,onFuncSelect,getSettingText)
	local onChange = onFuncChange
	if onChange == nil then 
		onChange = function()ZetaCore.ReloadMods()end	
	end
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		settings=itemSettings,
		default=itemDefault,
		OnChange=onChange,
		OnSelect=onFuncSelect,
		GetSettingText=getSettingText,
	} 
	return ret
end
--function this.ListLabelOption(itemSettings,itemSettingsTable,itemDefault,onFuncChange)
--	local ret = {
--		inMission=true,
--		save=IvarProc.CATEGORY_EXTERNAL,
--		settings=itemSettings,
--		settingsTable=itemSettingsTable,
--		default=itemDefault,
--		OnChange=onFuncChange,
--	} 
--	return ret
--end

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
	if engName ~= nil then
		menu.langStrings["eng"][modSafeName] = engName 
		if engHelp ~= nil then
			menu.langStrings["help"]["eng"][modSafeName] = engHelp
		end
	else
		menu.langStrings["eng"][modSafeName] = optionName 
		--menu.langStrings["help"]["eng"][modSafeName] = ""
	end
end
function this.CreateModLoadMenu(menu, menuName, itemType, options, safePrefix, engHelp, sortType )
	if ZetaIndex ~= nil then
		local modInfos = ZetaIndex.modInfos
		if modInfos ~= nil and next(modInfos) then
			for i,info in ipairs(modInfos)do
				--Mod enabled, Mod name, description, category, author, disabled by default
				local isModEnabled = 1
				local modOption = info.zetaUniqueName
				local modName = modOption
				local modDesc = engHelp..modName
				local modCategory = info.modCategory
				local modAuthor = info.modAuthor
				if info.modName ~= nil then modName = info.modName end
				if info.modDesc ~= nil then modDesc = info.modDesc end
				if info.modDisabledByDefault ~= nil then 
					if info.modDisabledByDefault == true then isModEnabled = 0 end
				end		
				--On change functions
				local onChange = function(self,settings)
					if ZetaCore ~= nil then ZetaCore.ReloadMods({force=true}) end
				end 				
				local menuItem = this.BoolOption(isModEnabled,onChange)
				if itemType == true then menuItem = this.NumberOption(1,100,1,1,onChange) end
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
				--Mod directory
				local modDirectory = {}
				if sortType == 2 then --By Category
					if modCategory ~= nil then 
						if type(modCategory) == "string" then
							table.insert(modDirectory, { menuName=modCategory, menuDesc="Mod category for "..modCategory.."."})
						elseif type(modCategory) == "table" then
							for x,curCategory in ipairs(modCategory)do
								table.insert(modDirectory, { menuName=curCategory, menuDesc="Mod category for "..curCategory.."."})
							end
						end
					else table.insert(modDirectory, { menuName="(Uncategorized)", menuDesc="Mod category for uncategorized mods."}) end
				elseif sortType == 3 then --By Author
					if modAuthor ~= nil then 	
						if type(modAuthor) == "string" then
							table.insert(modDirectory, { menuName=modAuthor, menuDesc="All mods by "..modAuthor.."."})
						elseif type(modAuthor) == "table" then
							for x,curAuthor in ipairs(modAuthor)do
								table.insert(modDirectory, { menuName=curAuthor, menuDesc="All mods by "..curAuthor.."."})
							end
						end
					else table.insert(modDirectory, { menuName="(Various)", menuDesc="All mods by various modders."}) end
				end
				if modDirectory ~= nil and next(modDirectory) then
					for index,modInfo in pairs(modDirectory)do
						this.CreateNewModMenu(menu, menuItem, options, safePrefix..modOption, modName, modDesc, menuName, modInfo)	
					end	
				else
					this.CreateNewModMenu(menu, menuItem, options, safePrefix..modOption, modName, modDesc, menuName, nil)	
				end		
			end
		end
	end
end
function this.CreateNewModMenu(menu, menuItem, options, modOption, modName, modDesc, menuName, modInfo )
	--Create new menu if sorted menu doesn't exist
	local newOptions = options
	if modInfo ~= nil then
		local newSortedMenu = modInfo.menuName..options
		if newSortedMenu ~= nil then
			if menu[newSortedMenu] == nil then
				ZetaMenu.CreateMenu(menu, menuName, newSortedMenu, newSortedMenu, modInfo.menuName, modInfo.menuDesc)
			end
			newOptions = newSortedMenu
		end
	end
	this.AddItemToMenu(menu, menuItem, newOptions, modOption, modName, modDesc )
end
function this.CreateModMenus(menu)
	if ZetaIndex == nil then
		Script.LoadLibrary("/Assets/tpp/script/zeta/main/ZetaIndex.lua")
	end
	--Enable all mods so that they can create mod menus regardless of whether the user's enabled them or not.
	if ZetaIndex ~= nil then
		ZetaIndex.LoadAllModFiles(true)
		local modMenuTables = ZetaIndex.ModGetWithModules("ModMenu", this)
		if modMenuTables ~= nil and next(modMenuTables) then
			for i,entry in ipairs(modMenuTables)do  
				this.RecursiveMenu(menu, entry.results, entry.module, "ZetaUI.modCustomMenu" )
			end
		end
		ZetaIndex.LoadAllModFiles()
	end
end

--Organizes options/settings
function this.RecursiveMenu(menu, results, module, prevParent, tabIndex)
	for i,modMenu in ipairs(results)do  
		--Mod lang entries
		local engName = modMenu.name
		local engHelp = modMenu.desc
		if modMenu.options ~= nil then 
			--If menu name and description weren't set, use the mod's info.
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
			this.CreateMenu(menu, {prevParent,}, newMenuInfo.options, newMenuInfo.settings, engName, engHelp)
			this.RecursiveMenu(menu, modMenu.options, module, newMenuInfo.menu, newTabIndex)
		end

		--Option Types
		local optionVar = modMenu.var
		if optionVar ~= nil then
			local menuItem = nil
			local defaultVal = modMenu.default
			if defaultVal == nil then defaultVal = 0 end
			local itemName = "ZetaCustomSetting"..uniqueName..optionVar
			if modMenu.command ~= nil then menuItem = module[modMenu.command] end
			if modMenu.list ~= nil then menuItem = this.ListOption(modMenu.list,defaultVal,modMenu.func,modMenu.select,modMenu.text) end
			if modMenu.number and next(modMenu.number) ~= nil then 
				menuItem = this.NumberOption(modMenu.number.min,modMenu.number.max,modMenu.number.inc,defaultVal,modMenu.func,modMenu.select)
			end
			if modMenu.bool ~= nil or menuItem == nil then menuItem = this.BoolOption(defaultVal,modMenu.func) end
			if menuItem ~= nil then this.AddItemToMenu(menu, menuItem, menuInfo.options, itemName, engName, engHelp) end
		end
	end
end

--modInfo: The Zeta module itself
--menu: ZetaMenu.lua
--engName: The English string for the mod menu
--engHelp: The English string for the mod menu's description
--subMenu: The variable name for the sub menu
--subParent: The variable name for the sub menu's parent
function this.CreateModMenu( modInfo, menu, engName, engHelp, subMenu, subParent)
	local optionsName = modInfo.zetaUniqueName.."Options"
	local settingsName = modInfo.zetaUniqueName.."Settings"
	local parentsRef = {"ZetaUI.modCustomMenu"}
	--If menu name and description weren't set, use the mod's info.
	if engName == nil then
		local modName = modInfo.modName
		if modName ~= nil then engName = modName end
	end
	if engHelp == nil then
		local modDesc = modInfo.modDesc
		if modDesc ~= nil then engHelp = modDesc end
	end
	if subMenu ~= nil then
		local newParent = settingsName
		if subParent ~= nil then newParent = modInfo.zetaUniqueName..subParent.."Settings" end
		parentsRef = {"ZetaUI."..newParent.."Menu"} --Add sub menu to mod menu
		optionsName = modInfo.zetaUniqueName..subMenu.."Options" 
		settingsName = modInfo.zetaUniqueName..subMenu.."Settings" 
	end
	this.CreateMenu(menu, parentsRef, optionsName, settingsName, engName, engHelp)
end
--modInfo: The Zeta module itself
--menu: ZetaMenu.lua
--menuItem: Type of menu item
--optionName: The defined name for the menu item
--engName: The English string for the menu item
--engHelp: The English string for the menu item's description
--subMenu: The variable name for the sub menu
function this.AddModItemToMenu( modInfo, menu, menuItem, optionName, engName, engHelp, subMenu)
	local menuName = modInfo.zetaUniqueName.."Options"
	local itemName = "ZetaCustomSetting"..modInfo.zetaUniqueName..optionName
	if subMenu ~= nil then
		menuName = modInfo.zetaUniqueName..subMenu.."Options" 
		itemName = "ZetaCustomSetting"..modInfo.zetaUniqueName..subMenu..optionName
	end
	if type(menuItem) == "string" then menuItem = modInfo[menuItem] end
	this.AddItemToMenu(menu, menuItem, menuName, itemName, engName, engHelp)
end

return this