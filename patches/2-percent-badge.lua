--[[ User patch for KOReader to add progress percentage badges in bottom left corner of cover ]]--
local Blitbuffer = require("ffi/blitbuffer")

--========================== [[Edit your preferences here]] ================================

local font_size = 10                        -- Font size for percentage text
local border_thickness = 1                  -- Adjust from 0 to 5
local border_corner_radius = 8              -- Adjust from 0 to 20
local text_color = Blitbuffer.colorFromString("#000000")
local border_color = Blitbuffer.colorFromString("#ffffff")
local background_color = Blitbuffer.COLOR_WHITE

--==========================================================================================
local userpatch = require("userpatch")
local logger = require("logger")
local TextWidget = require("ui/widget/textwidget")
local FrameContainer = require("ui/widget/container/framecontainer")
local Font = require("ui/font")
local Screen = require("device").screen
local Size = require("ui/size")
local BD = require("ui/bidi")

local function patchCoverBrowserProgressPercent(plugin)
    -- Grab Cover Grid mode and the individual Cover Grid items
    local MosaicMenu = require("mosaicmenu")
    local MosaicMenuItem = userpatch.getUpValue(MosaicMenu._updateItemsBuildUI, "MosaicMenuItem")

    -- Store original MosaicMenuItem paintTo method
    local orig_MosaicMenuItem_paint = MosaicMenuItem.paintTo

    -- Override paintTo method to add progress percentage badges
    function MosaicMenuItem:paintTo(bb, x, y)
        -- Call the original paintTo method to draw the cover normally
        orig_MosaicMenuItem_paint(self, bb, x, y)

        -- Get the cover image widget
        local target = self[1][1][1]
        if not target or not target.dimen then
            return
        end

        -- Show percent badge for books in progress (not completed)
        if not self.is_directory and self.percent_finished and self.status ~= "complete" and
           ((self.do_hint_opened and self.been_opened) or
            self.menu.name == "history" or
            self.menu.name == "collections") then

            -- Parse percent text
            local percent_text = string.format("%d%%", math.floor(self.percent_finished * 100))

            local percent_text_widget = TextWidget:new{
                text = percent_text,
                face = Font:getFace("cfont", font_size),
                bold = true,
                fgcolor = text_color,
            }

            local text_width = percent_text_widget:getSize().w

            -- Calculate minimum width (based on "00%" for consistent sizing)
            local min_width_text = TextWidget:new{
                text = "00%",
                face = Font:getFace("cfont", font_size),
                bold = true,
            }
            local min_text_width = min_width_text:getSize().w
            min_width_text:free()

            -- Extra horizontal padding for minimum width
            local base_padding = Screen:scaleBySize(2)
            local h_padding = base_padding
            if text_width < min_text_width then
                h_padding = h_padding + (min_text_width - text_width) / 2
            end

            local percent_badge = FrameContainer:new{
                linesize = Screen:scaleBySize(2),
                radius = Screen:scaleBySize(border_corner_radius),
                color = border_color,
                bordersize = border_thickness,
                background = background_color,
                padding_top = base_padding,
                padding_bottom = base_padding,
                padding_left = h_padding,
                padding_right = h_padding,
                margin = 0,
                percent_text_widget,
            }

            local badge_width = percent_badge:getSize().w
            local badge_height = percent_badge:getSize().h

            -- Same edge margin as series badge
            local edge_margin = Screen:scaleBySize(10)

            -- Position at bottom-left with equidistant margins (mirroring series badge on right)
            local badge_x = target.dimen.x + edge_margin
            local badge_y = target.dimen.y + target.dimen.h - badge_height - edge_margin

            -- Paint the badge
            percent_badge:paintTo(bb, badge_x, badge_y)
        end
    end
end
userpatch.registerPatchPluginFunc("coverbrowser", patchCoverBrowserProgressPercent)
