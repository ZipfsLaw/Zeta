--ZetaMenu.lua
--Description: Adds functions that simplifies menu creation in IHHook's overlay.
local this={}
local Ivars=Ivars

--Menu Option Functions
function this.NumberOption(itemMin,itemMax,itemInc,itemDefault,onFuncChange,onFuncSelect)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range={min=itemMin,max=itemMax,increment=itemInc},
		OnChange = function()
			if ZetaCore ~= nil then ZetaCore.ReloadMods()end
		end,
		default = 0,
	} 
	if itemDefault ~= nil then ret.default = itemDefault end
	if onFuncChange ~= nil then ret.OnChange = onFuncChange	end
	if onFuncSelect ~= nil then ret.OnSelect = onFuncSelect end
	return ret
end
function this.BoolOption(itemDefault,onFuncChange,onFuncSelect)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range=Ivars.switchRange,
		settingNames="set_switch",
		OnChange = function()
			if ZetaCore ~= nil then ZetaCore.ReloadMods()end
		end,
		default = 0,
	} 
	if itemDefault ~= nil then ret.default = itemDefault end
	if onFuncChange ~= nil then ret.OnChange = onFuncChange	end
	if onFuncSelect ~= nil then ret.OnSelect = onFuncSelect end
	return ret
end
function this.ListOption(itemSettings,itemDefault,onFuncChange,onFuncSelect,getSettingText)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		settings=itemSettings,
		OnChange = function()
			if ZetaCore ~= nil then ZetaCore.ReloadMods()end
		end,
		default = 0,
	} 
	if itemDefault ~= nil then ret.default = itemDefault end
	if onFuncChange ~= nil then ret.OnChange = onFuncChange	end
	if onFuncSelect ~= nil then ret.OnSelect = onFuncSelect end
	if getSettingText ~= nil then ret.GetSettingText = getSettingText end
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
	if engName ~= nil then
		menu.langStrings["eng"][modSafeName] = engName 
		if engHelp ~= nil then menu.langStrings["help"]["eng"][modSafeName] = engHelp end
	else
		menu.langStrings["eng"][modSafeName] = optionName 
		menu.langStrings["help"]["eng"][modSafeName] = "Mod settings for "..optionName
	end
end
function this.CreateModLoadMenu(menu, parentMenu, menuOptions, sortType )
	if ZetaIndex ~= nil then
		local zetaModules = ZetaIndex.luaModsFiles
		if zetaModules ~= nil and next(zetaModules) then
			for fileName,zetaModule in pairs(zetaModules)do
				--Mod enabled, Mod name, description, category, author
				local modOption = zetaModule.zetaUniqueName
				local modName = modOption
				local modDesc = "Settings for "..modOption
				local modCategory = zetaModule.modCategory
				local modAuthor = zetaModule.modAuthor
				if zetaModule.modName ~= nil then modName = zetaModule.modName end
				if zetaModule.modDesc ~= nil then modDesc = zetaModule.modDesc end
				--Is mod disabled by default?
				local isModEnabled = 1
				if zetaModule.modDisabledByDefault ~= nil then 
					if zetaModule.modDisabledByDefault == true then isModEnabled = 0 end
				end				
				--Mod Menu Items		
				local menuItems = {{options = {},}}
				if zetaModule.ModMenu ~= nil then --Does the mod have its own menu options?
					local modSettings = zetaModule.ModMenu()
					if modSettings ~= nil and next(modSettings)then menuItems = modSettings end
				end
				local rootModMenu = menuItems[1]
				if rootModMenu ~= nil and next(rootModMenu) then
					if rootModMenu.options ~= nil then
						table.insert(rootModMenu.options,1,{ --Adds "Load Order" option right below the "Active" option
							var = ZetaDef.loadOrderName..modOption,
							name = "Load Order",
							desc = "Changes the load order of "..modName,
							number = {min=1,max=100,inc=1},
							nonCustomVar = true, --Prevents ZetaCustomSetting prefix from being added to Ivar
							default = 1,
						})
						if zetaModule.modIsToggleable ~= false then 
							table.insert(rootModMenu.options,1,{ --Adds "Active" option to the top
								var = ZetaDef.modActiveName..modOption,
								name = "Active",
								desc = "Enables or disables "..modName,
								nonCustomVar = true, --Prevents ZetaCustomSetting prefix from being added to Ivar
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
					for i,menuInfo in pairs(modDirectory)do
						this.CreateNewModMenu(menu, zetaModule, menuItems, parentMenu, menuOptions, menuInfo)	
					end	
				else
					this.CreateNewModMenu(menu, zetaModule, menuItems, parentMenu, menuOptions, nil)	
				end		
			end
		end
	end
end
function this.CreateNewModMenu(menu, zetaModule, menuItems, parentMenu, menuOptions, menuInfo )
	--Create new menu if sorted menu doesn't exist
	local newOptions = menuOptions
	if menuInfo ~= nil then
		local newSortedMenu = menuInfo.menuName..menuOptions
		if newSortedMenu ~= nil then
			newOptions = newSortedMenu
			if menu[newOptions] == nil then
				this.CreateMenu(menu, parentMenu, newOptions, newOptions, menuInfo.menuName, menuInfo.menuDesc)
				if menu.modMenus ~= nil then table.insert(menu.modMenus, newOptions) end
			end
		end
	end
	this.RecursiveMenu(menu, menuItems, zetaModule, "ZetaUI."..newOptions.."Menu", newOptions )
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
			local itemName = ZetaDef.customSettingsName..uniqueName..optionVar
			if modMenu.nonCustomVar == true then itemName = optionVar end --Don't use the setting prefix
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