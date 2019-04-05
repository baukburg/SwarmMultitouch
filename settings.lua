local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

-- Our scene
function scene:create( event )
	local group = self.view
	local leftMargin = 115
	local topMargin = 25
	local vertSpace = 50
	local textSize = 14
	local buttonOffset = -5

  -- First stepper
	local function setting01do( event )
		local phase = event.phase
		text01.text = "Swarm Volatility : " .. event.value
    maxtrack = (11 - event.value) * 3
	end

  local setting01 = widget.newStepper
  {
      left = 10,
      top = topMargin + buttonOffset,
      initialValue = 1,
      minimumValue = 1,
      maximumValue = 10,
      onPress = setting01do,
  }
  group:insert(setting01)
	text01 = display.newText("Swarm Volatility : " .. 1, leftMargin, topMargin, nil, textSize)
	text01.anchorX = 0
	text01.anchorY = 0
  text01:setTextColor(255,255,255,255)
  group:insert(text01)


  -- Second stepper
	local function setting02do( event )
		local phase = event.phase
		text02.text = "Swarm Velocity : " .. event.value
    maxvel = event.value * 3
	end

  local setting02 = widget.newStepper
  {
      left = 10,
      top = topMargin + buttonOffset + vertSpace,
      initialValue = 5,
      minimumValue = 1,
      maximumValue = 10,
      onPress = setting02do,
  }
  group:insert(setting02)
	text02 = display.newText("Swarm Velocity : " .. 5, leftMargin, topMargin + vertSpace, nil, textSize)
	text02.anchorX = 0
	text02.anchorY = 0
  text02:setTextColor(255,255,255,255)
  group:insert(text02)

-- Third stepper
	local function setting03do( event )
		local phase = event.phase
		text03.text = "Swarm Size : " .. 100 * event.value
    maxbugs = 100 * event.value
	end

  local setting03 = widget.newStepper
  {
      left = 10,
      top = topMargin + buttonOffset + (2*vertSpace),
      initialValue = 10,
      minimumValue = 1,
      maximumValue = maxmaxbugs/100,
      onPress = setting03do,
  }
  group:insert(setting03)
	text03 = display.newText("Swarm Size : " .. maxbugs, leftMargin, topMargin + (2*vertSpace), nil, textSize)
	text03.anchorX = 0
	text03.anchorY = 0
  text03:setTextColor(255,255,255,255)
  group:insert(text03)

-- Fourth stepper
	local function setting04do( event )
		local phase = event.phase
		text04.text = "Turn Tightness : " .. event.value
    maxturn = 10 * event.value
	end

  local setting04 = widget.newStepper
  {
      left = 10,
      top = topMargin + buttonOffset + (3*vertSpace),
      initialValue = 3,
      minimumValue = 1,
      maximumValue = 10,
      onPress = setting04do,
  }
  group:insert(setting04)
	text04 = display.newText("Turn Tightness : " .. 3, leftMargin, topMargin + (3*vertSpace), nil, textSize)
	text04.anchorX = 0
	text04.anchorY = 0
  text04:setTextColor(255,255,255,255)
  group:insert(text04)

-- Fifth stepper
	local function setting05do( event )
		local phase = event.phase
		text05.text = "Element Width : " .. event.value
    bugwidth = event.value
	end

  local setting05 = widget.newStepper
  {
      left = 10,
      top = topMargin + buttonOffset + (4*vertSpace),
      initialValue = bugwidth,
      minimumValue = 1,
      maximumValue = 3,
      onPress = setting05do,
  }
  group:insert(setting05)
	text05 = display.newText("Element Width : " .. bugwidth, leftMargin, topMargin + (4*vertSpace), nil, textSize)
	text05.anchorX = 0
	text05.anchorY = 0
  text05:setTextColor(255,255,255,255)
  group:insert(text05)

-- Sixth stepper
	local function setting06do( event )
		local phase = event.phase
		text06.text = "Swarm Dispersion : " .. event.value
    bugdispersion = event.value
	end

  local setting06 = widget.newStepper
  {
      left = 10,
      top = topMargin + buttonOffset + (5*vertSpace),
      initialValue = bugdispersion,
      minimumValue = 1,
      maximumValue = 10,
      onPress = setting06do,
  }
  group:insert(setting06)
	text06 = display.newText("Swarm Dispersion : " .. bugdispersion, leftMargin, topMargin + (5*vertSpace), nil, textSize)
	text06.anchorX = 0
	text06.anchorY = 0
  text06:setTextColor(255,255,255,255)
  group:insert(text06)


	credits = display.newText("Created by Brett Aukburg", display.contentWidth/2, display.contentHeight-10, nil, textSize-2)
	credits.anchorX = 0.5
	credits.anchorY = 0.5
	credits:setTextColor(0.2,0.2,0.2,1)
	group:insert(credits)

end

scene:addEventListener( "create" )

return scene
