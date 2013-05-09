
local isTall = (("iPhone" == system.getInfo("model") or "iPod touch" == system.getInfo("model")) and ( display.pixelHeight > 960 ) )

if(isTall)then
application = {
	content = {
		width = 640,
		height = 1136, 
		scale = "letterBox",--letterBox zoomEven
		fps = 30,
		--[[
		imageSuffix = {
		    ["@2x"] = 2,
		}
		--]]
	},

    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]
}
else
application = {
	content = {
		width = 640,
		height = 960, 
		scale = "letterBox",
		fps = 30,
		--[[
        imageSuffix = {
		    ["@2x"] = 2,
		}
		--]]
	},

    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]
}
end
