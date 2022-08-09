--ZetaMenu.lua
--Description: Adds functions that simplifies menu creation in IHHook's overlay.
local this={}
local Ivars=Ivars

--Presets
function this.NumberOption(itemMin,itemMax,itemInc,itemDefault,onFuncChange)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range={min=itemMin,max=itemMax,increment=itemInc},
		default=itemDefault,
		OnChange=onFuncChange,
	} 
	return ret
end

function this.BoolOption(itemDefault,onFuncChange)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range=Ivars.switchRange,
		default=itemDefault,
		settingNames="set_switch",
		OnChange=onFuncChange,
	} 
	return ret
end

function this.ListOption(itemSettings,itemDefault,onFuncChange)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		settings=itemSettings,
		--settingsTable=itemSettings,
		default=itemDefault,
		OnChange=onFuncChange,
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

--Menu
function this.CreateLangStrings( menu, modSafeName, optionName, altName, altHelp)
	if altName ~= nil then
		menu.langStrings["eng"][modSafeName] = altName 
		if altHelp ~= nil then
			menu.langStrings["help"]["eng"][modSafeName] = altHelp
		end
	else
		menu.langStrings["eng"][modSafeName] = optionName 
		--menu.langStrings["help"]["eng"][modSafeName] = ""
	end
end

function this.CreateMenu(menu, menuParents, menuOptions, optionName, altName, altHelp)
	--Set the menu's parents and options
	local modSafeName = this.firstToLower(optionName.."Menu")
	local newMenuOptions = this.firstToLower(menuOptions)
	local newParents = menuParents
	if type(newParents) ~= "table" then 
		newParents = {menuParents,} 
	end
	menu[newMenuOptions] = {}
	menu[modSafeName] = {
		parentRefs=newParents,
		options=menu[newMenuOptions]
	}
	
	--Display text
	this.CreateLangStrings( menu, modSafeName, optionName, altName, altHelp )
	
	--Register menu
	table.insert( menu.registerMenus, modSafeName )
end

function this.AddItemToMenu(menu, menuItem, options, optionName, altName, altHelp)
	--Register Ivars, add options to menu
	local newOptions = this.firstToLower(options)
	table.insert( menu.registerIvars, optionName )
	table.insert( menu[newOptions], "Ivars."..optionName )
	
	--Callback
	local modFunc = { optionName, menuItem }
	menu[modFunc[1]] = modFunc[2]
	
	--Display text
	this.CreateLangStrings( menu, optionName, optionName, altName, altHelp )
end

function this.CreateModLoadMenu(menu, menuName, itemType, options, safePrefix, altHelp, sortType )
	if ZetaIndex ~= nil then
		local mods = ZetaIndex.luaModsFiles
		if mods ~= nil and next(mods) then
			for i,curMod in ipairs(mods)do
				--Mod name, description, and category for menu
				local modOption = InfUtil.StripExt(curMod)
				local modName = modOption
				local modDesc = altHelp..modName
				local modCategory = nil
				local modAuthor = nil
				local isModEnabled = 1
				local modInfo = ZetaIndex.GetModInfo(curMod)
				if modInfo ~= nil then
					if modInfo["modName"] ~= nil then modName = modInfo["modName"] end
					if modInfo["modDesc"] ~= nil then modDesc = modInfo["modDesc"] end
					if modInfo["modCategory"] ~= nil then modCategory = modInfo["modCategory"] end
					if modInfo["modAuthor"] ~= nil then modAuthor = modInfo["modAuthor"] end
					if modInfo["modDisabledByDefault"] ~= nil then 
						if modInfo["modDisabledByDefault"] == true then isModEnabled = 0 end
					end
				end	
				
				--On change functions
				local onChange = function(self,settings)
					if ZetaCore ~= nil then
						ZetaCore.ReloadMods({force=true})
					end
				end 				
				local menuItem = this.BoolOption(isModEnabled,onChange)
				if itemType == true then
					menuItem = this.NumberOption(1,100,1,1,onChange)
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
		ZetaIndex.LoadAllModFiles()
		ZetaIndex.SafeForceFunc("ModMenu", menu )
	end
end

--modInfo: The Zeta module itself
--menu: ZetaMenu.lua
--altName: The English string for the mod menu
--altHelp: The English string for the mod menu's description
--subMenu: If defined, will create a submenu in the mod menu
function this.CreateModMenu( modInfo, menu, altName, altHelp, subMenu)
	local optionsName = modInfo.zetaUniqueName.."Options"
	local settingsName = modInfo.zetaUniqueName.."Settings"
	local parentsRef = {"ZetaUI.modCustomMenu"}

	--If menu name and description weren't set, use the mod's info.
	if altName == nil then
		local modName = modInfo.modName
		if modName ~= nil then altName = modName end
	end
	if altHelp == nil then
		local modDesc = modInfo.modDesc
		if modDesc ~= nil then altHelp = modDesc end
	end

	if subMenu ~= nil then 
		parentsRef = {settingsName.."Menu"} --Add sub menu to mod menu
		optionsName = modInfo.zetaUniqueName..subMenu.."Options" 
		settingsName = modInfo.zetaUniqueName..subMenu.."Settings" 
	end
	this.CreateMenu(menu, parentsRef, optionsName, settingsName, altName, altHelp)
end
--modInfo: The Zeta module itself
--menu: ZetaMenu.lua
--menuItem: Type of menu item
--optionName: The defined name for the menu item
--altName: The English string for the menu item
--altHelp: The English string for the menu item's description
--subMenu: If defined, will place the menu item in the submenu
function this.AddModItemToMenu( modInfo, menu, menuItem, optionName, altName, altHelp, subMenu)
	local optionsName = modInfo.zetaUniqueName.."Options"
	local itemName = "ZetaCustomSetting"..modInfo.zetaUniqueName..optionName
	if subMenu ~= nil then 
		optionsName = modInfo.zetaUniqueName..subMenu.."Options" 
		itemName = "ZetaCustomSetting"..modInfo.zetaUniqueName..subMenu..optionName
	end
	this.AddItemToMenu(menu, menuItem, optionsName, itemName, altName, altHelp)
end

--Lowers first letter of string
function this.firstToLower(str)
    return (str:gsub("^%l", string.lower))
end

return this