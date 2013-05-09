--ステータスバーを隠す
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

--currentScore（当初は０）を次のステージに渡す
storyboard.gotoScene( "scene1", { effect = "fade", time = 1000, params = { currentScore = 0 }  })

--[[
fade
zoomOutIn
zoomOutInFade
zoomInOut
zoomInOutFade
flip
flipFadeOutIn
zoomOutInRotate
zoomOutInFadeRotate
zoomInOutRotate
zoomInOutFadeRotate
fromRight (over original scene)
fromLeft (over original scene)
fromTop (over original scene)
fromBottom (over original scene)
slideLeft (pushes original scene)
slideRight (pushes original scene)
slideDown (pushes original scene)
slideUp (pushes original scene)
crossFade
]]--