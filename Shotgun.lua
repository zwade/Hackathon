Shotgun = Arm:subclass("Shotgun")
 
local cooldown=0 
 
function removeitem(list, index)
        ret = {}
        for i=1,(index-1) do
                ret[i] = list[i]
        end
        for i=(index+1),#list do
                ret[i-1] = list[i]
        end
        return ret
end
 
function Shotgun:initialize(img,cx,cy,arm)
  Arm.initialize(self,img,cx,cy,arm)
	self.bullets = {}
end
 
function Shotgun:render(sx,sy)
	Arm.render(self,sx,sy)
	for i in pairs(self.bullets) do
		self.bullets[i]:render()
	end
end
 
function Shotgun:update(dt)
	while #self.bullets>25 do
		self.bullets = removeitem(self.bullets,1)
		print(#self.bullets)
	end
	Arm.update(self,dt)
	for i in pairs(self.bullets) do
		self.bullets[i]:update(self.entities,dt)
	end
	if cooldown>0 then
		cooldown=cooldown-dt
	end
end
 
Shotgun.static.SPREAD_FACTOR = 300
Shotgun.static.NUM_PELLETS = 8
Shotgun.static.SPEED_MODIFIER = 2000
 
function Shotgun:fire(type)
	if type==self.weapon then
		if cooldown<=0 then
			self.bullets[#self.bullets+1]  = self:randomProjectile()
			self.bullets[#self.bullets+1]  = self:randomProjectile()
			self.bullets[#self.bullets+1]  = self:randomProjectile()
			self.bullets[#self.bullets+1]  = self:randomProjectile()
			cooldown=.3
		end
	end
end
 
function Shotgun:randomProjectile()
    vx = love.mouse:getX() - (self.x+self.parent.x)
  	vy = love.mouse:getY() - (self.y+self.parent.y)
		mag = math.sqrt(vx*vx+vy*vy)
		vx = vx/mag
		vy = vy/mag
		return Projectile(self.x+self.parent.x,self.y+self.parent.y,vx*Shotgun.SPEED_MODIFIER + self:randomDeviation(Shotgun.SPREAD_FACTOR),vy*Shotgun.SPEED_MODIFIER + self:randomDeviation(Shotgun.SPREAD_FACTOR),love.graphics.newImage("shot.png"),self.parent,10)
end
 
function Shotgun:randomDeviation(spreadfactor)
    return math.random(-spreadfactor, spreadfactor)
end
