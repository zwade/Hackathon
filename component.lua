require("middleclass/middleclass")

Component = class("Component")

function Component:initialize(img,cx,cy)
	self.image = img
	self.x = cx
	self.y = cy
	self.w = img:getWidth()
	self.h = img:getHeight()
	self.ox = self.w/2
	self.oy = self.h/2
	self.dir = 0
	self.z = 0
end

function Component:render(sx,sy)
	tmpx = self.x
	tmpy = self.y
	if sx<0 then
		tmpx = -tmpx
	end
	if sy<0 then
		tmpy = -tmpy
	end
	love.graphics.draw(self.image,self.parent.x+tmpx,self.parent.y+tmpy, self.dir, sx,sy,self.ox,self.oy)
end

function Component:update(dt)
	return
end
