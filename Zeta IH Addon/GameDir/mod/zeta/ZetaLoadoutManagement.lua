--ZetaLoadoutManagement.lua
local this ={
	modName = "Loadout Management",
	modDesc = "Import, export sortie loadouts. Can load each slot individually, or all slots. (NOTE: Can be used in sortie!)",
	modCategory = "Extensions",
	modAuthor = "ZIP",
	isZetaModule = true,
    modIsToggleable = false,
    modHasLoadOrder = false,
    --Sortie info
    sortieSlotSize = 36, --Max size of sortie slot
    sortiePath = "loadouts", --\MGS_TPP\mod\loadouts
}
function this.ModMenu() --Creates options dynamically
    local sortieSelection = {}
    local sortieFiles=InfCore.GetFileList(InfCore.files[this.sortiePath],".lua") --Load loadout profiles
    if sortieFiles ~= nil and next(sortieFiles) then 
        for i,fileName in ipairs(sortieFiles)do 
            local newOption = this.CreateSortieOption(fileName)
            if newOption ~= nil then table.insert( sortieSelection, newOption ) end
        end 
    end
    return{
        {var="SavedLoadouts",name="Saved Loadouts",desc="View your saved sortie loadouts.",options=sortieSelection,},
        {var="SaveSortie",name="Save Current Loadout",desc="Saves your current sortie loadout.",command=this.SaveSortieInfo,},
        {var="ResetAllLoadouts",name="Reset Current Loadout",desc="Sets all loadout slots to default items.",command=function() 
                if ZetaPlayer ~= nil then ZetaPlayer.ResetSortieLoadouts() end
            end,
        },
    }
end
--Purpose: Creates a menu for a sortie.
function this.CreateSortieOption(sortieFileName)
    local infoName = InfUtil.StripExt(sortieFileName)
    local infoMenu = {
        name=infoName,
        desc="Options for "..infoName,
        options={{
            var=infoName.."ApplyAll",
            name="Apply All",desc="Replaces your current loadout with the loaded profile.",
            command=function()this.ApplySortieToSlot(sortieFileName)end,
        }}
    }
    for slotNum=1,3,1 do        
        local newOption = {
            var=infoName.."Apply"..slotNum,
            name="Apply Slot "..slotNum,desc="Replaces slot "..slotNum.." of your current loadout with the loaded profile.",
            command=function()this.ApplySortieToSlot(sortieFileName,slotNum)end,
        }
        table.insert(infoMenu.options,newOption)
    end
    return infoMenu
end
--Purpose: Gets loadout info and saves it to a lua file.
function this.SaveSortieInfo()
    local playersLoadout = ZetaUtil.VarsToTable("sortieLoadoutInfoU16buf")
    if playersLoadout ~= nil then 
        local newFilename = "sortie_"..os.time()..".lua"
        ZetaUtil.ExportTableToFile{ --Saves current loadout
            fileName = newFilename,
            filePurpose = "A saved player loadout for sortie.",
            fileLocation = InfCore.paths[this.sortiePath], --\MGS_TPP\mod\loadouts
            fileVars = playersLoadout,
            fileMinified = true, --No tabs and newlines.
        }
        if ZetaUI ~= nil then ZetaUI.ReloadMenu() end --Refresh profile options and reload sortie files
        TppUiCommand.AnnounceLogView(ZetaDef.modName..": Saved current sortie to: "..newFilename)
    end
end
--Purpose: Loads sortie from lua file, then applies it based on the provided slot number. If none is provided, it's applied to all slots.
function this.ApplySortieToSlot(sortieFileName, slotNum)
    if ZetaUtil ~= nil then 
        local sortieInfo = ZetaUtil.ImportFileAsTable{
            fileName = sortieFileName,
            fileLocation = InfCore.paths[this.sortiePath], --\MGS_TPP\mod\loadouts
        }
        if sortieInfo ~= nil then
            local newSortie = {}
            local minSortie = 0
            local maxSortie = ( this.sortieSlotSize * 3 ) - 1 --TODO: See if values past 108 should be saved/loaded.
            if slotNum ~= nil then --If a slotNum is provided, then we can clamp contents
                minSortie = this.sortieSlotSize * (slotNum-1)
                maxSortie = ( this.sortieSlotSize * slotNum ) - 1
            end
            for i,eqpID in pairs(sortieInfo)do
                if i >= minSortie and i <= maxSortie then newSortie[i] = eqpID end
            end
            if newSortie ~= nil and next(newSortie) then
                if ZetaPlayer ~= nil then ZetaPlayer.ResetSortieLoadouts(newSortie) end
                local subMsg = "" --For announcelog on screen
                if slotNum ~= nil then subMsg = "slot "..slotNum.." of " end
                TppUiCommand.AnnounceLogView(ZetaDef.modName..": Replaced "..subMsg.."loadout with "..sortieFileName)
            end
        end
    end
end
return this