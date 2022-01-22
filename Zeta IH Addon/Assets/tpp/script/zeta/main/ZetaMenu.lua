--ZetaMenu.lua
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

function this.AddItemToMenu(menu, menuItem, options, safePrefix, optionName, altName, altHelp)
	--Register Ivars, add options to menu
	local newOptions = this.firstToLower(options)
	local modSafeName = safePrefix..optionName
	table.insert( menu.registerIvars, modSafeName )
	table.insert( menu[newOptions], "Ivars."..modSafeName )
	
	--Callback
	local modFunc = { modSafeName, menuItem }
	menu[modFunc[1]] = modFunc[2]
	
	--Display text
	this.CreateLangStrings( menu, modSafeName, optionName, altName, altHelp )
end

function this.CreateModLoadMenu(menu, menuName, itemType, options, safePrefix, altHelp )
	if ZetaIndex ~= nil then
		local sortType = this.GetIvar("ZetaSettingModListSortType", 1, true )
		local mods = ZetaIndex.luaModsFiles
		if mods ~= nil and next(mods) then
			for i,curMod in ipairs(mods)do
				--Mod name, description, and category for menu
				local modOption = InfUtil.StripExt(curMod)
				local modName = modOption
				local modDesc = altHelp..modName
				local modCategory = nil
				local modAuthor = nil
				local modInfo = ZetaIndex.GetModInfo(curMod)
				if modInfo ~= nil then
					if modInfo[1] ~= nil then modName = modInfo[1] end
					if modInfo[2] ~= nil then modDesc = modInfo[2] end
					if modInfo[3] ~= nil then modCategory = modInfo[3] end
					if modInfo[4] ~= nil then modAuthor = modInfo[4] end
				end	
				
				--On change functions
				local onChange = function(self,settings)
					if ZetaCore ~= nil then
						ZetaCore.ReloadMods({toggle=true,force=true})
					end
				end 				
				local menuItem = this.BoolOption(1,onChange)
				if itemType == true then
					menuItem = this.NumberOption(1,100,1,1,onChange)
				end
				
				--Sorting mode
				local newOptions = options
				local newSortedMenu = nil
				local newSortedMenuLabel = nil
				local newSortedMenuDesc = nil		
				
				--Sort types
				if sortType == 1 then
					--By Category
					if modCategory ~= nil then
						if type(modCategory) == "string" then
							newSortedMenuDesc = "Mod category for "..modCategory
						end
					else
						modCategory = "(Uncategorized)"
						newSortedMenuDesc = "Mod category for uncategorized mods"
					end				
					newSortedMenu = modCategory..options
					newSortedMenuLabel = modCategory
				elseif sortType == 2 then
					--By Author
					if modAuthor ~= nil then
						if type(modAuthor) == "string" then
							newSortedMenuDesc = "All mods originally created by "..modAuthor
						end
					else
						modAuthor = "(Various)" 
						newSortedMenuDesc = "All mods created by various modders"
					end			
					newSortedMenu = modAuthor..options
					newSortedMenuLabel = modAuthor
				end
				
				--Create new menu if sorted menu doesn't exist
				if newSortedMenu ~= nil then
					if menu[newSortedMenu] == nil then
						ZetaMenu.CreateMenu(menu, menuName, newSortedMenu, newSortedMenu, newSortedMenuLabel, newSortedMenuDesc)
					end
					newOptions = newSortedMenu
				end
				
				this.AddItemToMenu(menu, menuItem, newOptions, safePrefix, modOption, modName, modDesc )
			end
		end
	end
end

function this.CreateModMenus(menu)
	if ZetaIndex == nil then
		Script.LoadLibrary("/Assets/tpp/script/zeta/main/ZetaIndex.lua")
	end
	if ZetaIndex ~= nil then
		ZetaIndex.LoadAllModFiles()
		ZetaIndex.SafeFunc("ModMenu", menu )
	end
end

function this.GetIvar(selIvar,default,useEvars)
	--Checks ivars for settings
	if Ivars ~= nil then
		local modValue = Ivars[selIvar]
		if modValue ~= nil then
			return modValue:Get()
		end
	end
	
	--Check for evars as fallback
	if useEvars == true then
		if evars ~= nil then
			local modValue = evars[selIvar]
			if modValue ~= nil then
				return modValue
			end
		end
	end
	
	--If all else fails, use default value provided
	if default ~= nil then
		return default
	end
	return 0
end

function this.CreateModMenu(menu, menuOptions, optionName, altName, altHelp)
	this.CreateMenu(menu, {"ZetaUI.modCustomMenu"}, menuOptions, optionName, altName, altHelp)
end
function this.AddModItemToMenu( menu, menuItem, options, optionName, altName, altHelp)
	this.AddItemToMenu(menu, menuItem, options, "ZetaCustomSetting", optionName, altName, altHelp)
end
function this.GetModIvar(selIvar,default)
	return this.GetIvar("ZetaCustomSetting"..selIvar,default)
end

function this.firstToLower(str)
    return (str:gsub("^%l", string.lower))
end

return this