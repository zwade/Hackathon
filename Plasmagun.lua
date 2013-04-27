Plasmagun = Arm:subclass("Plasmagun")

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

function Plasmagun:initialize(img,cx,cy,arm)
	Arm.initialize(self,img,cx,cy,arm)
	self.bullets = {}
end

function Plasmagun:render(sx,sy)
	Arm.render(self,sx,sy)
	for i in pairs(self.bullets) do
		self.bullets[i]:render()
	end
end

function Plasmagun:update(dt)
	while #self.bullets>25 do
		self.bullets = removeitem(self.bullets,1)
	end
	Arm.update(self,dt)
	for i in pairs(self.bullets) do
		self.bullets[i]:update(self.entities,dt)
	end
	if cooldown>0 then
		cooldown=cooldown-dt
end

function Plasmagun:fire(type)
	if type==self.weapon then
		if cooldown<=0 then
			vx = love.mouse:getX() - (self.x+self.parent.x)
			vy = love.mouse:getY() - (self.y+self.parent.y)
			mag = math.sqrt(vx*vx+vy*vy)
			vx = vx/mag
			vy = vy/mag
			self.bullets[#self.bullets+1] = Projectile(self.x+self.parent.x,self.y+self.parent.y,vx*1000,vy*1000,love.graphics.newImage("Plasma Bolt.png"),self.parent)
			cooldown=.2		

		end
	end
end
