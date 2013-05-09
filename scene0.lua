-----------------------------------------------------------------------------------------
--
-- scene0.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local db = require("db")

local _W = display.contentWidth
local _H = display.contentHeight
------------------
--ボタン
local nextBTN
------------------
--変数
local currentScore
local score = 0
local highScoreText
local yourScore
local yourScoreText
--変数
local isTall
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

--次のステージへ画面遷移
local function touchToNext(event)
	if("began" == event.phase)then
		nextBTN:setFillColor(0,84,147)
	elseif("ended" == event.phase)then
		--変数aにscoreを代入
		local a = score
		print("Push currentScore = " .. a)
		
		storyboard.removeAll()
		--scoreを代入した変数aを次のステージに渡す
		storyboard.gotoScene( "scene1", { effect = "slideLeft", time = 1000, params = { currentScore = score } })
		nextBTN:setFillColor(0,150,255)
	end
	return true
end
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	--端末のモデルを取得iPhone５サイズなら変数isTallに追加
	isTall = (("iPhone" == system.getInfo("model") or "iPod touch" == system.getInfo("model")) and ( display.pixelHeight > 960 ) )
	
	nextBTN = display.newRect(0, 0, 100, 100)
	nextBTN:setFillColor(0,150,255)
	nextBTN.x = _W/2 ; nextBTN.y = _H/2 +200
	group:insert( nextBTN )
	------------------------------------------------------------------------
	--前ステージのスコアを代入
	yourScore = event.params.currentScore
    
	yourScoreText = display.newText("", 0, 0, native.systemFont, 50)
	yourScoreText.text = "Your Score：" .. yourScore
	yourScoreText.x = _W/2; yourScoreText.y = _H *2/3 -250
	group:insert( yourScoreText )
	
	highScoreText = display.newText(" ", 0, 0, native.systemFont, 50)
	highScoreText.x = _W/2
	if(isTall)then
		highScoreText.y = display.screenOriginY +50
	else
		highScoreText.y = 50
	end
	group:insert( highScoreText )
	
	--今回のスコアとdbのハイスコアを比較
	if( yourScore >= highScore )then
		highScoreText.text = "New High Score：" .. highScore
		
		yourScoreText.text = "Congratulations !!"
		yourScoreText.x = _W/2; yourScoreText.y = _H *2/3 -250
	
	elseif( yourScore < highScore )then
		highScoreText.text = "Current High Score：" .. highScore
	end
	
end

----------------------------------------------------------------------------------------
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	-- remove previous
	storyboard.purgeScene( "previous" )
	
	--前のステージのcurrentScoreをもらい、変数currentScoreに代入
	currentScore = event.params.currentScore
    print( "Got currentScore = " .. currentScore )
    
    --変数scoreにcurrentScoreを代入
    score = currentScore
	print("score = " .. score)
	
	--db.luaのgameover関数を呼出して、scoreを渡す
	gameover(score)
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	nextBTN:addEventListener ( "touch", touchToNext );
	
end

----------------------------------------------------------------------------------------
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	nextBTN:removeEventListener ( "touch", touchToNext )

end

----------------------------------------------------------------------------------------
-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene
