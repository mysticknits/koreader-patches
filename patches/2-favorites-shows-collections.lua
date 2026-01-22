-- User patch: Make the Favorites menu item show all collections instead of just Favorites
-- Copy this file to koreader/patches/ on your device

local FileManagerCollection = require("apps/filemanager/filemanagercollection")

local orig_addToMainMenu = FileManagerCollection.addToMainMenu
FileManagerCollection.addToMainMenu = function(self, menu_items)
    orig_addToMainMenu(self, menu_items)
    -- Override the favorites callback to show all collections
    menu_items.favorites.callback = function()
        self:onShowCollList()
    end
end
