local composer = require( "composer" )
system.activate("multitouch")
local scene = composer.newScene()

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
  local touchCount = 0
  local touches = {}

-- create a single bug
local function newBug()

	-- need initial segment to start
	bug = display.newLine( -halfbuglength,0,halfbuglength,0 )

	-- default color and width (can also be modified later)
	bug:setStrokeColor( math.random(),math.random(),math.random(),math.random()+0.5 )
	bug.strokeWidth = bugwidth

	return bug
end
-- end newBug function

-- create bugs with random color and position
local function establishBugs()
	bugs = {}

	for i = 1, maxmaxbugs do

		local myBug = newBug()

		if i <= leadbugs then
			myBug.vel = maxvel
			myBug.strokeWidth = bugwidth
			myBug:setStrokeColor(0,0,0,0)
			myBug.dr = 0
		else
			myBug.vel = math.random((maxvel*100/bugdispersion),maxvel*100)/100
			myBug.strokeWidth = bugwidth
			if i <= maxbugs then
				myBug:setStrokeColor(math.random(),math.random(),math.random(),math.random()+0.2)
			else
				myBug:setStrokeColor(0,0,0,0)
			end
			myBug.dr = math.random((maxturn*100/bugdispersion),maxturn*100)/100
		end

		myBug.track = 0
		myBug.leadturn = maxturn + turnplus
		myBug.x = math.random( border, display.contentWidth - border )
		myBug.y = math.random( border, display.contentHeight - border )
		myBug.rotation = 0

		myBug.anchorX = 0
		myBug.anchorY = 0

		group:insert(myBug)

		table.insert( bugs, myBug )
	end
end
-- end establishBugs function

-- reset features of bugs
local function resetBugs()
	for i = 1, maxmaxbugs do
		if bugs[i] then
			if i > maxbugs then
				bugs[i]:setStrokeColor(0,0,0,0)
			else
				bugs[i].vel = math.random((maxvel*100/bugdispersion),maxvel*100)/100
				bugs[i]:setStrokeColor(math.random(),math.random(),math.random(),math.random()+0.2)
				bugs[i].dr = math.random((maxturn*100/bugdispersion),maxturn*100)/100
				bugs[i].strokeWidth = bugwidth
			end
		end
	end
end
-- end resetBugs function


establishBugs()

-- move all the bugs around
function bugs:enterFrame( event )
	--if bugchange then
	--	resetBugs()
	--	bugchange = false
	--end
	for i,v in ipairs( self ) do

		-- compute movement for the lead bug using my "track" algorithm
		if i <= leadbugs then
			leadx = v.x
			leady = v.y
			if v.track <= 0 then
				v.track = math.random ( mintrack, maxtrack )
				v.dr = math.random ( maxturn ) - (maxturn / 2)
				v.vel = maxvel
			end

			-- keep flipping the direction the lead bug turns at the border
			if v.track == 1 then
				v.leadturn = -v.leadturn
			end

			v.track = v.track - 1

			if math.abs(v.dr) < maxturn then
				if v.x < border then
					v.dr = v.leadturn
				end
				if v.x > (display.contentWidth - border) then
					v.dr = v.leadturn
				end
				if v.y < border then
					v.dr = v.leadturn
				end
				if v.y > (display.contentHeight - border) then
					v.dr = v.leadturn
				end
			end

			if (v.x > display.contentWidth + 10) or (v.x < -10) then
				v.x = display.contentWidth/2
			end
			if (v.y > display.contentHeight + 10) or (v.y < -10) then
			   	v.y = display.contentHeight/2
			end

			-- don't bother with "track" algorithm when turning from edge
			if math.abs(v.dr) >= maxturn then v.track = 0 end

			v.rotation = v.rotation + v.dr
		end

		-- compute movement for all other bugs to chase the lead bug
		if i > leadbugs and i <= maxbugs then
			if i <= maxleads then
				if bugreset then
					v.dr = math.random((maxturn/3),maxturn)
					v:setStrokeColor( math.random(), math.random(), math.random(), math.random() + 0.2)
				end
				if i == maxleads then
					bugreset = false
				end
			end
			local bugtofollow = (i%leadbugs) + 1
			angle = math.deg(math.atan2((bugs[bugtofollow].y - v.y),(bugs[bugtofollow].x - v.x)))
			if v.rotation > 180 then
				v.rotation = v.rotation - 360
			elseif v.rotation < -180 then
				v.rotation = v.rotation + 360
			end

			if v.rotation > (angle + v.dr) then
				if math.abs(v.rotation - angle) > 180 then
					v.rotation = v.rotation + v.dr
				else
					v.rotation = v.rotation - v.dr
				end
			elseif v.rotation < (angle - v.dr) then
				if math.abs(v.rotation - angle) > 180 then
					v.rotation = v.rotation - v.dr
				else
					v.rotation = v.rotation + v.dr
				end
			end
		end

		-- actually move all the bugs
		if i <= maxbugs then
			v.x = v.x + (v.vel * math.cos(math.rad(v.rotation)))
			v.y = v.y + (v.vel * math.sin(math.rad(v.rotation)))
		end
	end
end
-- end Bugs function

-- returns an element at some index in a dictionary
local function GetDictElAtIndex( dict, index )
  local temp = 0
  local ret  = nil
  for k, v in pairs(dict) do
    if( temp == index ) then
      ret = v
      break
    end
    temp = temp + 1
  end
  return ret
end
-- end GetDictElAtIndex function

local function onTouch( event )
  if composer.getSceneName( "current" ) == "bugmotion" then
    if touchCount == 0 then
      pretouchleads = leadbugs
    end

    if event.phase == "began" then
      touchCount = touchCount + 1
      touches[event.id] = event
    elseif event.phase == "moved" then
      if touches[event.id] then
        touches[event.id].x = event.x
        touches[event.id].y = event.y
      end
    elseif event.phase == "ended" then
      touchCount = touchCount - 1
      touches[event.id] = nil
    end

    if touchCount >= 1 then
      leadbugs = touchCount
    else
      leadbugs = pretouchleads
    end

    if leadtext ~= leadbugs then
      leadtext.text = leadbugs
    end

    for i = 1, leadbugs, 1 do
      local thistouch = GetDictElAtIndex( touches, i-1)
      bugs[i]:setStrokeColor(0,0,0,0)
      bugs[i].vel = 0
      bugs[i].track = 10
      if thistouch then
        bugs[i].x = thistouch.x
        bugs[i].y = thistouch.y
      end
    end
    return true
  end
end
-- end ontouch function

Runtime:addEventListener( "enterFrame", bugs )
Runtime:addEventListener( "touch", onTouch)

end
-- end scene creation

-- Called when scene is about to move offscreen:
function scene:exit( event )
	local group = self.view
  for i=1,maxbugs do
    if bugs[i] then
      bugs[i]:setStrokeColor(0,0,0,0)
    end
    bugs[i] = nil
  end
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
	local group = self.view
end

---------------------------------------------------------------------------------
-- END OF IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enter", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exit", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
