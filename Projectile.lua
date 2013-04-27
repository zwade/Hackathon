require("middleclass/middleclass")
 
Projectile = class("Projectile")
--Projectile:include(Hitbox) --Hitbox is at bottom of file
 
function Projectile:initialize(x, y, vx, vy, image,par)
  --self.components = template
	self.image = image
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = x
	self.parent = par
	self.y = y
	self.vx = vx
	self.vy = vy
	self.exists = true
	self.age = 0
	print(">>>>>>>>>>>>>>>>")
end
 
function Projectile:move(nx,ny)
	self.x=self.x+nx
	self.y=self.y+ny
end
 
function Projectile:update(loe,dt)
	print(">>>>>",loe[0])
	self.age = self.age + 1
	tmp = self:checkHits(loe)
	self:move(self.vx*dt, self.vy*dt)
	if tmp then
		self.exists = false
		return tmp
	end
end

function Projectile:getAge()
	return self.age	
end

function Projectile:checkHits(listOfThingsToHit)
	for i in pairs(listOfThingsToHit) do
		for a in pairs(listOfThingsToHit[i]) do
		end	
	end
	if not(self.exists) then
		return
	end
	for i in pairs(listOfThingsToHit) do
		tmp = self:checkHit(listOfThingsToHit[i])
		if tmp then 
			return tmp
		end
	end
end
 
function Projectile:checkHit(thingHit)
	if  self:hasHit(thingHit)
		then
			return self:hitAction(thingHit)
		end
	return false
end
 
function Projectile:hasHit(thingWithHitbox)
	if thingWithHitbox.id == self.parent.id then
		return false
	end
	--[[ Apparently projectiles have no width/height. :(
	--if has hit thingWithHitbox
	local selfXY = self:minmaxXY()
	local otherXY = thingWithHitbox:minmaxXY()
	
	--if max of smaller greater than min of larger, then collision
	
	local XY = {min(selfXY[1], otherXY[1]),
		max(selfXY[2], otherXY[2]),
		min(selfXY[3], otherXY[3]),
		max(selfXY[4], otherXY[4])}
	
	if XY[2] < XY[3] return true else return false
	]]
	local hitXY = thingWithHitbox:minmaxXY()
	
	if self.x > hitXY[1] and self.x < hitXY[2]
	and self.y > hitXY[3] and self.y < hitXY[4]
	then
		print("YAY")
		return true	
	else
		print("BOO")
		return false
	end
end
 
function Projectile:hitAction(thingHit)
	thingHit:takeHit(1)
	return true
end
function Projectile:render()
	if self.exists then
		love.graphics.draw(self.image,self.x,self.y,0,1,1,self.width/2,self.height/2) 
	end
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
