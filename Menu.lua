require("middleclass/middleclass")
require("Button")
--require("ToggleButton")
 
Menu = class("Menu")
 
Menu.static.STARTYCOORD = 10
Menu.static.YSPACE = 30
Menu.static.BUTTONIMAGEFILENAME = "BrigRedButton.png"
Menu.static.OVERLAYCOLOR = {0, 0, 0, 100}
 
function Menu:initialize(width, height)
  --we're fighting a war
  --against our MINDS
	--so how do we know when we're winning
	--and would we really be winning when we're winning
	--this is absolutely the best coding I've ever done
	--hey
	--hey
	--listen
	--hey
	--hey
	--what if there existed a world
	--where there were no "e"s
	--how about this s_nt_nc_
	--huh....
	--[[
	So when are we winning?
	Can you even win a war
	against yourself?
	Does someone have to lose
	for someone to win?
	Who makes the rules?
	What are the rules?
	Who knows the rules?
	And who will follow them?
	]]
	
	--[[
	The only solution is...a balance of power.
	We arm our side with exactly that much more.
	A balance of power...the trickiest, most difficult, dirtiest game of them all.
	But the only one that preserves both sides. 
	-capn' kirk
	]]
	
	
	self.buttons = {}
	--self.currentCoords = {width/2, Menu.STARTYCOORD}
	self.currentCoords = {width, height}
	self.width = width;
	self.height = height;
	--hardcoded
	
	print("Initializing buttons")
	self:addButton("Resume", love.graphics.newImage(Menu.BUTTONIMAGEFILENAME))
	self:addButton("Options", love.graphics.newImage(Menu.BUTTONIMAGEFILENAME))
	self:addButton("Hey", love.graphics.newImage(Menu.BUTTONIMAGEFILENAME))
	print("Buttons Initializored")
	
end
 
 
function Menu:goToNextCoords()
	print("Going to next button coords")
	self.currentCoords[2] = self.currentCoords[2] + Menu.YSPACE
end
 
function Menu:addButton(text, drawable)
	local b1 = Button:new(text, self.currentCoords[1], self.currentCoords[2], drawable:getWidth(), drawable:getHeight(), drawable)
	print("Atttempting to add button to list...")
	self.buttons[#self.buttons+1] = b1 --not sure if this works
	self:goToNextCoords()
end
 
function Menu:update(dt)
	for i in pairs(self.buttons) do
		self.buttons[i]:update(dt)
	end
end
 
function Menu:draw()
	--overlay
	love.graphics.setColor(Menu.OVERLAYCOLOR)
	love.graphics.rectangle("fill", 0, 0, self.width, self.height)
	--buttons
	for i in pairs(self.buttons) do
		self.buttons[i]:draw()	
	end
end
