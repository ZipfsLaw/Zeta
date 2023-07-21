--ZetaMenu.lua
--Description: Adds functions that simplifies menu creation in IHHook's overlay.
local this={}
local Ivars=Ivars
--Menu Option Functions
function this.ReloadFunc() 
	if ZetaCore ~= nil then ZetaCore.ReloadMods{reloadFiles=false,}end --Don't reload files by default!
end
-- Default IH Ivar Option
function this.IvarOption(params)
	local ret = {
		inMission = true,
		save = params.save or IvarProc.CATEGORY_EXTERNAL,
		OnChange = params.onFuncChange or this.ReloadFunc,
		OnSelect = params.onFuncSelect,
		SkipValues = params.skipValues,
		default = params.itemDefault or 0,
	}
	return ret
end
-- By default, options are booleans. If you must set anything for a boolean, it is its default value.
function this.BoolOption(params)
	local ret = this.IvarOption(params)
	ret.range=Ivars.switchRange
	ret.settingNames="set_switch"
	return ret
end
-- A number within a range that has a set Minimum, maximum, and increment. Example: number={min=0,max=100,inc=1},
function this.NumberOption(params)
	local ret = this.IvarOption(params)
	ret.range={min=params.itemMin or -math.huge,max=params.itemMax or math.huge,increment=params.itemInc or 0.1}
	return ret
end
-- Creates an option index based on a list. Example: list={"option 1","option 2", "option 3"},
function this.ListOption(params) 
	local ret = this.IvarOption(params)
	ret.settings=params.itemSettings
	ret.GetSettingText=params.getSettingText
	return ret
end
--[[ 
	Same as list, but applies a profile on change. Example:
	presets={
		settings={"ProfileFileName1","ProfileFileName2","ProfileFileName3"}, --Profile lua filename. ( found in \MGS_TPP\mod\profiles )
		labels={"Profile One","Profile Two","Profile Three"}, --Profile labels
	}
]]
function this.PresetOption(params)
	local ret = this.IvarOption(params)
	ret.settings=params.itemSettings.settings
	local onChange = ret.onFuncChange
	ret.OnChange=function(self,setting)
		local profileNames,profileInfos=unpack(InfCore.PCall(IvarProc.SetupInfProfiles))
		if profileInfos ~= nil and next(profileInfos) then
			local profileName=self.settings[setting+1]
			local profileInfo=profileInfos[profileName..".lua"]
			if profileInfo ~= nil then
				IvarProc.ApplyProfile(profileInfo.profile)
				if ZetaUI ~= nil then ZetaUI.ReloadMenu(false) end
			end
		end
		if onChange ~= nil then onChange(self,setting) end
	end	
	ret.GetSettingText=function(self,setting) return params.itemSettings.labels[setting+1] end --Show preset label instead
	return ret
end
--Internal Menu Functions
function this.CreateMenu(menu, menuParents, menuOptions, optionName, nameLang, helpLang)
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
	this.CreateLangStrings( menu, modSafeName, optionName, nameLang, helpLang )
	--Register menu
	table.insert( menu.registerMenus, modSafeName )
end
function this.AddItemToMenu(menu, menuItem, menuOptions, optionName, nameLang, helpLang)
	--Register Ivars, add options to menu
	local modSafeName = optionName
	if type(menuItem) == "function" then
		modSafeName = ZetaUtil.firstToLower(optionName)
		table.insert( menu[menuOptions], "ZetaUI."..optionName )
	else
		table.insert( menu.registerIvars, optionName )
		table.insert( menu[menuOptions], "Ivars."..optionName )
		ZetaVar.defaultValues[optionName] = menuItem.default --Save default value in case IVars aren't accessible yet
	end
	--Callback function when menu item is used
	local modFunc = { optionName, menuItem }
	menu[modFunc[1]] = modFunc[2]
	--Display text for menu item
	this.CreateLangStrings( menu, modSafeName, optionName, nameLang, helpLang )
end
--Purpose: Creates lang strings for menu items. Supports languages other than English.
--[[(Language IDs)
	eng--English
	ara--arabic
	cht--chinese traditional
	fre--french
	ger--german
	ita--italian
	jpn--japanese
	kor--korean
	por--portugese
	rus--russian
	spa--spanish
]]
function this.CreateLangStrings( menu, modSafeName, optionName, nameLang, helpLang)
	if nameLang ~= nil then --Visible Title of Menu Item
		if type(nameLang) == "table" and next(nameLang) then --Does this menu item support multiple languages?
			for langId,langEntry in pairs(nameLang)do menu.langStrings[langId][modSafeName] = langEntry end
		else menu.langStrings["eng"][modSafeName] = nameLang end --If not, fallback to English.
	else menu.langStrings["eng"][modSafeName] = optionName end
	if helpLang ~= nil then --Help/Description of Menu Item
		if type(helpLang) == "table" and next(helpLang) then --Does this menu item support multiple languages?
			for langId,langEntry in pairs(helpLang)do menu.langStrings["help"][langId][modSafeName] = langEntry end
		else menu.langStrings["help"]["eng"][modSafeName] = helpLang end --If not, fallback to English.
	else menu.langStrings["help"]["eng"][modSafeName] = ZetaDef.settingOptionLabel..optionName end
end
--Purpose: Generates IVars based on a simplified format made for Zeta.
--menu: The IH module you wish to register menu and ivars in.
--menuItems: List of Zeta-formated menu options to generate Ivars for
--parentRefs: Parent menu(s) for generated menus.
--tabIndex: Root menu name. Used for nesting menus.
--root: Used to cache tabIndex (Do not set)
function this.RecursiveMenu(menu, menuItems, parentRefs, tabIndex, root)
	local parentFix = parentRefs --In case parentRefs aren't in tables
	if type(parentRefs) ~= "table" then parentFix = {parentRefs,} end
	local newMenuItems = menuItems --If we're handling a menu, build it.
	if menuItems.options ~= nil then newMenuItems = {menuItems,} end 
	local tabIndexFix = tabIndex or "" --Use empty quotes if no tab exists.
	local rootMenu = root or tabIndexFix --Keep root menu name for Ivars.
	for i,modMenu in ipairs(newMenuItems)do
		if modMenu.root ~= nil then rootMenu = modMenu.root end --If menu provides root, change root.
		local optionVar = modMenu.var or modMenu.ivar --Looks for var or ivar
		local newTabIndex = tabIndexFix or i --Past menu name/indexing
		if modMenu.options ~= nil then --If Options are set, it becomes a menu.
			if newTabIndex ~= nil then newTabIndex = newTabIndex..i end --New tab index for created menu
			if optionVar ~= nil then newTabIndex = optionVar end --Use set i/var name for menu
			this.CreateMenu(menu, parentFix, newTabIndex.."Options", newTabIndex, modMenu.name, modMenu.desc)
			this.RecursiveMenu(menu, modMenu.options, "ZetaUI."..newTabIndex.."Menu", newTabIndex, rootMenu)
		elseif optionVar ~= nil then --Otherwise, check if there's a var.
			local menuItem = nil --Zeta menu option
			local defaultVal = modMenu.default or 0 --Option's default value
			if modMenu.var ~= nil then optionVar = ZetaDef.customSettingsName..rootMenu..optionVar end --If var isn't nil, add Zeta custom setting prefix 
			if modMenu.command ~= nil then menuItem = modMenu.command --A menu command that runs a function. Example: command=function() this.someScriptFunction() end
			elseif modMenu.list ~= nil then menuItem = this.ListOption{itemSettings=modMenu.list,itemDefault=defaultVal,onFuncChange=modMenu.func,onFuncSelect=modMenu.select,getSettingText=modMenu.text,skipValues=modMenu.skip,save=modMenu.save}
			elseif modMenu.presets ~= nil then menuItem = this.PresetOption{itemSettings=modMenu.presets,itemDefault=defaultVal,onFuncChange=modMenu.func,onFuncSelect=modMenu.select,skipValues=modMenu.skip,save=modMenu.save}
			elseif modMenu.number ~= nil then menuItem = this.NumberOption{itemMin=modMenu.number.min,itemMax=modMenu.number.max,itemInc=modMenu.number.inc,itemDefault=defaultVal,onFuncChange=modMenu.func,onFuncSelect=modMenu.select,skipValues=modMenu.skip,save=modMenu.save}
			else menuItem = this.BoolOption{itemDefault=defaultVal,onFuncChange=modMenu.func,onFuncSelect=modMenu.select,save=modMenu.save} end --If no var type is set, the menu option defaults to bool.
			if menuItem ~= nil then this.AddItemToMenu(menu, menuItem, newTabIndex.."Options", optionVar, modMenu.name, modMenu.desc) end --Menu vars must remain unique and in order
		end
	end
end
--Purpose: Removes duplicate menu options after Zeta menus refresh.
function this.ClearDuplicateMenuOptions(menuDef, reverse)
	if menuDef ~= nil then
		menuDef.options = ZetaUtil.RemoveDuplicates(menuDef.options, reverse) 
		if menuDef.parentRefs ~= nil then
			for k,parentRef in ipairs(menuDef.parentRefs)do
				local parentMenu = InfCore.GetStringRef(parentRef)
				if parentMenu ~= nil then this.ClearDuplicateMenuOptions(parentMenu, reverse) end
			end
		end
	end
end
return this