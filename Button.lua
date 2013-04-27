require("middleclass/middleclass")
 
Button = class('Button') --hmmmmm. 
 
Button.static.colorReg = {255, 255, 0}
Button.static.colorOver = {0, 255, 255}
Button.static.colorClicked = {255, 0, 255}
 
function Button:initialize(text, x, y, width, height, image)
  self.text = text --how do variables work I DON'T KNOW
	self.image = image
	self.hover = false
	self.click = false
	self.x = x --left
	self.y = y	--top
	self.width = width
	self.height = height
end
 
function Button:getState()
	return self.click
end
 
 
function Button:draw()
	--love.graphics.setFont()
	local textShiftX = 5
	local textShiftY = 5
	self:fixColor()
	love.graphics.draw(self.image, self.x, self.y)
	love.graphics.print(self.text, self.x + textShiftX, self.y + textShiftY)
 
end
 
function Button:fixColor()
	if self.click then love.graphics.setColor(Button.colorClicked)
	elseif self.hover then love.graphics.setColor(Button.colorOver)
	else love.graphics.setColor(Button.colorReg) end
end
 
function Button:update(dt)
	self.hover = false
	self.click = false
	
	local x = love.mouse.getX()
	local y = love.mouse.getY()
 
	if x > self.x
	and x < self.x + self.width
	and y > self.y
	and y < self.y + self.height then
		self.hover = true
	end
	
	if self.clicked("l") --which mouse to check for?
	then self.click = true
	end
end
 
function Button:clicked(button)
	if self.hover 
	and love.mouse.isDown(button)
	then
		return true
	end
	return false
end
