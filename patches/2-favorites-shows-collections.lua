-- User patch: Make the Favorites menu item show all collections instead of just Favorites
-- Copy this file to koreader/patches/ on your device

local FileManagerCollection = require("apps/filemanager/filemanagercollection")

local orig_onShowColl = FileManagerCollection.onShowColl
FileManagerCollection.onShowColl = function(self, collection_name)
    -- If no specific collection requested (i.e., from Favorites menu), show all collections
    if collection_name == nil then
        return self:onShowCollList()
    end
    return orig_onShowColl(self, collection_name)
end
