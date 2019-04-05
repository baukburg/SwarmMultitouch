local widget = require( "widget" )
local composer = require( "composer" )
system.activate("multitouch")

-- set global values
mintrack = 2		  -- minimum distance lead bug tracks to a curve
maxtrack = 25		  -- maximum distance lead bug tracks to a curve
maxturn = 30		  -- maximum turning angle for a bug outside of border
turnplus = 5		  -- amount above maximum that lead bug will turn in border
maxvel = 12			  -- maximum velocity of a bug
maxbugs = 1000		-- number of bugs in the simulation
maxmaxbugs = 5000 -- number of bugs that the simulation can support
halfbuglength = 2	-- half the length in pixels of the line that is a bug
bugwidth = 1		  -- width of all bugs in pixels (lead bug is +1)
border = 40			  -- distance from edge of screen when lead bug will start turning away
leadbugs = 1		  -- number of independent lead bugs
maxleads = 9		  -- maximum number of lead bugs to divide swarm into
bugreset = false	-- determine if we just reset to 1 lead bug
bugchange = false -- determine if bug settings were recently changed
bugdispersion = 3 -- spread of speed and turn of the group

-- Add any objects that should appear on all scenes below:

local buttonPress = function( event )
  if leadbugs < maxleads then
		leadbugs = leadbugs + 1;
		bugreset = false;
	else
		leadbugs = 1;
		bugreset = true;
	end
	leadtext.text = leadbugs
end



local button = widget.newButton
{
	defaultFile = "button.png",
	overFile = "button.png",
	onPress = buttonPress,
	id = "arrow"
}

button.x = display.contentWidth - 10; button.y = display.contentHeight - 10
leadtext = display.newText(leadbugs, 0, 0, nil, 10 )
leadtext:setTextColor(200,200,200)
leadtext.x = display.contentWidth - 10
leadtext.y = display.contentHeight - 10

local settingPress = function( event )
  if setText.text == "S" then
    setText.text = "P"
    composer.gotoScene( "settings" )
  else
    setText.text = "S"
    bugchange = true
    composer.gotoScene( "bugmotion" )
	end
end


local settingButton = widget.newButton
{
	defaultFile = "button.png",
	overFile = "button.png",
	onPress = settingPress,
	id = "arrow"
}

settingButton.x = 10; settingButton.y = display.contentHeight - 10
setText = display.newText("S", 0, 0, nil, 10 )
setText:setTextColor(200,200,200)
setText.x = 11
setText.y = display.contentHeight - 10

composer.gotoScene( "bugmotion" )
