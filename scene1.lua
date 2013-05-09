-----------------------------------------------------------------------------------------
--
-- scene1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

--db読み込み
local db = require("db")

local _W = display.contentWidth
local _H = display.contentHeight
--------------------------------------------
--ボタン
local BTN,nextBTN
------------------
local score = 0
local scoreText
local highScoreText
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
		
		--db.luaのstageclear関数を呼出して、scoreを渡す
		stageclear(score)
		
		storyboard.removeAll()
		--scoreを代入した変数aを次のステージに渡す
		storyboard.gotoScene( "scene2", { effect = "slideLeft", time = 1000, params = { currentScore = a } })
		nextBTN:setFillColor(0,150,255)
	end
	return true
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--タッチで得点
local function onTouch(event)
	if("began" == event.phase)then
		BTN:setFillColor(190,80,5)
	elseif("ended" == event.phase)then
		score = score +10
		scoreText.text = score
		scoreText.x = _W/2
		if(isTall)then
			scoreText.y = display.screenOriginY +50
		else
			scoreText.y = 50
		end
		BTN:setFillColor(250,130,10)
	end
end

	
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
	
	BTN = display.newRect(0, 0, 100, 100)
	BTN:setFillColor(250,130,10)
	BTN.x = _W/2 ; BTN.y = _H/2 -200
	group:insert( BTN )
	------------------------------------------------------------------------
	nextBTN = display.newRect(0, 0, 100, 100)
	nextBTN:setFillColor(0,150,255)
	nextBTN.x = _W/2 ; nextBTN.y = _H/2 +200
	group:insert( nextBTN )
	------------------------------------------------------------------------
	scoreText = display.newText( "", 0, 0, nil, 50)
	scoreText.text = score
	scoreText.x = _W/2
	if(isTall)then
		scoreText.y = display.screenOriginY +50
	else
		scoreText.y = 50
	end
	group:insert( scoreText )
	------------------------------------------------------------------------
	highScoreText = display.newText("", 0, 0, native.systemFont, 30)
	highScoreText:setTextColor(125)
	
	--db.luaから帰って来たhighScoreを代入
    highScoreText.text = "HighScore:" .. highScore
	highScoreText.x = 120
	if(isTall)then
			highScoreText.y = display.pixelHeight -40
	else
		highScoreText.y = _H -40
	end
	group:insert( highScoreText )
	
end

----------------------------------------------------------------------------------------
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	-- remove previous
	storyboard.purgeScene( "previous" )
	
	--main.luaからcurrentScoreをもらう
	if(event.params.currentScore)then
		local currentScore = event.params.currentScore
    end
    
    --db.luaのgameover関数を呼出して、scoreを渡す
	gameover(score)
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	nextBTN:addEventListener ( "touch", touchToNext );
	BTN:addEventListener ( "touch", onTouch );
end

----------------------------------------------------------------------------------------
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	nextBTN:removeEventListener ( "touch", touchToNext )
	BTN:removeEventListener ( "touch", onTouch )
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
