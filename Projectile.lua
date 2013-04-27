require("middleclass/middleclass")
 
Projectile = class("Projectile")
--Projectile:include(Hitbox) --Hitbox is at bottom of file
 
function Projectile:initialize(x, y, vx, vy, image)
  --self.components = template
	self.image = image
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = x
	self.y = y
	self.vx = vx
	self.vy = vy
end
 
function Projectile:move(nx,ny)
	self.x=self.x+nx
	self.y=self.y+ny
end
 
function Projectile:update(loe,dt)
	self:checkHits(loe)
	self:move(self.vx*dt, self.vy*dt)
end
 
function Projectile:checkHits(listOfThingsToHit)
	for i = 1, #listOfThingsToHit do
		self:checkHit(listOfThingsToHit[i])
	end
end
 
function Projectile:checkHit(thingHit)
	if self.hasHit(thingHit)
		then
			self.hitAction(thingHit)
		end
end
 
function Projectile:hasHit(thingWithHitbox)
	--[[ Apparently projectiles have no width/height. :(
	--if has hit thingWithHitbox
	local selfXY = self.minmaxXY()
	local otherXY = thingWithHitbox.minmaxXY()
	
	--if max of smaller greater than min of larger, then collision
	
	local XY = {min(selfXY[1], otherXY[1]),
		max(selfXY[2], otherXY[2]),
		min(selfXY[3], otherXY[3]),
		max(selfXY[4], otherXY[4])}
	
	if XY[2] < XY[3] return true else return false
	]]
	local hitXY = thingWithHitbox.minmaxXY()
	
	if self.x > hitXY[1] and self.x < hitXY[2]
	and self.y > hitXY[3] and self.z < hitXY[4]
	then
		return true	
	else
		return false
	end
end
 
function Projectile:hitAction(thingHit)
	--do something	
end
function Projectile:render()
	love.graphics.draw(self.image,self.x,self.y,0,1,1,self.width/2,self.height/2) 
end
 
 
Hitbox = {
	getX = function(self)
		return self.x
	end,
	
	getY = function(self)
		return self.y	
	end,
	
	getHitWidth = function(self)
		return self.width	
	end,
	
	getHitHeight = function(self)
		return self.height	
	end,
	
	minmaxXY = function(self)
	return {self.getX() - self.getHitWidth()/2, --smallX (1)
		self.getX() + self.getHitWidth()/2, --largeX (2)
		self.getY() - self.getHitHeight()/2, --smallY (3)
		self.getY() + self.getHitHeight()/2}	--largeY (4)
	end
}
