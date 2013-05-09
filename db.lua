local _W = display.contentWidth
local _H = display.contentHeight

--Include sqlite
require "sqlite3"

--Open data.db.  If the file doesn't exist it will be created
local path = system.pathForFile("HighScore.db", system.DocumentsDirectory)
db = sqlite3.open( path )
 
--Handle the applicationExit event to close the db
local function onSystemEvent( event )
	if( event.type == "applicationExit" ) then              
    	db:close()
	end
end

--Setup the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, content);]]
db:exec( tablesetup )

v1 = 0
v2 = 0
highScore = 0

for row in db:nrows("SELECT * FROM test") do
	if( row.content )then
		v2 = tonumber(row.content)
	end
end

v1 = 0

--値を比較しhighScoreに代入
if(v1 < v2)then
	highScore = v2
elseif(v1 > v2)then
	highScore = v1
elseif(v1 == v2)then
	highScore = v1
end

--highScoreをdbに保存
local tablefill =[[INSERT INTO test VALUES (NULL, ']]..highScore..[['); ]]
db:exec( tablefill )

--dbを画面に表示
for row in db:nrows("SELECT * FROM test") do
	local text = row.content
	local judg = {}
	judg[row.id] = tonumber(row.content)
	if( highScore > judg[row.id] )then
		--
	elseif(highScore < judg[row.id])then
		highScore = judg[row.id]
	
	elseif(highScore == highScore)then
		--
	end
end

--setup the system listener to catch applicationExit
Runtime:addEventListener( "system", onSystemEvent )
---------------------------------------------------------------------------
function stageclear(score)
	v1 = score

	--値を比較しhighScoreに代入
	if(v1 < v2)then
		highScore = v2
	elseif(v1 > v2)then
		highScore = v1
	elseif(v1 == v2)then
		highScore = v1
	end
	
	--highScoreをdbに保存
	local tablefill =[[INSERT INTO test VALUES (NULL, ']]..highScore..[['); ]]
	db:exec( tablefill )
	
	--
	for row in db:nrows("SELECT * FROM test") do
		local text = row.content
		local judg = {}
		judg[row.id] = tonumber(row.content)
		
		if( highScore > judg[row.id] )then
			--
		elseif(highScore < judg[row.id])then
			highScore = judg[row.id]
		
		elseif(highScore == highScore)then
			--
		end
	end
	
end

---------------------------------------------------------------------------
function gameover(score)
	v1 = score

	--値を比較しhighScoreに代入
	if(v1 < v2)then
		highScore = v2
	elseif(v1 > v2)then
		highScore = v1
	elseif(v1 == v2)then
		highScore = v1
	end
	
	--highScoreをdbに保存
	local tablefill =[[INSERT INTO test VALUES (NULL, ']]..highScore..[['); ]]
	db:exec( tablefill )
	
	--
	for row in db:nrows("SELECT * FROM test") do
		local text = row.content
		local judg = {}
		judg[row.id] = tonumber(row.content)
		
		if( highScore > judg[row.id] )then
			--
		elseif(highScore < judg[row.id])then
			highScore = judg[row.id]
		
		elseif(highScore == highScore)then
			--
		end
	end
	
	return highScore
end








