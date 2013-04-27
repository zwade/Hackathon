require("middleclass/middleclass")

Component = class("Component")

function Component:initialize(imgname,cx,cy,isTorso)
	self.torso = isTorso or false
	self.image = love.graphics.newImage(imgname)
	self.imagename = imgname
	self.x = cx
	self.y = cy
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.ox = self.w/2
	self.oy = self.h/2
	self.dir = 0
	self.z = 0
end
function Component:fire()

end
function Component:init(parent)
	
end
function makered(x,y,r,g,b,a)
	return r,0,0,a
end
function brighten( x, y, r, g, b, a )
   return r,g,b,a
end
function Component:takeHit()
	tmpimg = love.image.newImageData(self.imagename)
	tmpimg:mapPixel(makered)
	self.image = love.graphics.newImage(tmpimg)
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
