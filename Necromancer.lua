Necromancer = Entity:subclass("Necromancer")
function Necromancer:initialize(nx,ny,template,map,prot)
  Entity.initialize(self,nx,ny,template,map)
	
	
	self.teleportTime = math.random(1., 20)
	self.summonTime = math.random(1., 4)
	self.attackTime = math.random(6., 12)
	self.protagonist = prot
	--self.noGrav = true
end

function Necromancer:behave(keys,dt)
	
	self.teleportTime = self.teleportTime - dt
	self.summonTime = self.summonTime - dt
	self.attackTime = self.attackTime - dt
	
	if teleportTime < 0 then
		self:teleport()
		self.teleportTime = math.random(1., 20)
	end
	if summonTime < 0 then
		self:summon()
		self.summonTime =  math.random(1., 4)
	end
	if attackTime < 0 then
		self.attack()
		self.attackTime = math.random(6., 12)
	end
	self:coll(dt)
end

function Necromancer:teleport()
	self.x = math.random( 100, 924 )
end

function Necromancer:spawn(thingToSpawn)
	--SPAWN!?!?!?!?!
end

function Necromancer:summon()
	if math.random() < .375 then
		span("ghost")
	else 
		span("zombie")
	end
end

function Necromancer:attack()
	if type==self.weapon then
		vx = self.protagonist.x - self.x
		vy = love.mouse:getY() - (self.y+self.parent.y)
		mag = math.sqrt(vx*vx+vy*vy)
		vx = vx/mag
		vy = vy/mag
		self.bullets[#self.bullets+1] = Projectile(self.x+self.parent.x,self.y+self.parent.y,vx*100,vy*100,love.graphics.newImage("RedBullet.png"),self.parent)
	end
end

function Necromancer:moveV(dt,gravity)
	Entity.moveV(self,dt)
end
