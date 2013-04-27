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
	self.timer = 0
	
	self.imagered = self:makeRed()

end
function Component:setEntities(ent)
	self.entities = ent
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
	self.timer = .1
end	
function Component:makeRed()
	tmpimg = love.image.newImageData(self.imagename)
	tmpimg:mapPixel(makered)
	return love.graphics.newImage(tmpimg)
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
	if self.timer<=0 then
		love.graphics.draw(self.image,self.parent.x+tmpx,self.parent.y+tmpy, self.dir, sx,sy,self.ox,self.oy)
	else
		love.graphics.draw(self.imagered,self.parent.x+tmpx,self.parent.y+tmpy, self.dir, sx,sy,self.ox,self.oy)
	end

end

function Component:update(dt)
	self.timer = self.timer-dt
	return
end
