Zombie = Entity:subclass("Zombie")
function Zombie:initialize(nx,ny,template,map,prot)
	Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
	self.speed = math.random(13,35)
end
function Zombie:init(parent)
	parent.invuln = .1
end
function Zombie:behave(keys,dt)
	if self.x > self.protagonist.x then
		self.vx = self.vx - self.speed 
	else 
		self.vx = self.vx + self.speed
	end
	if math.random(0,100) == 42 then
		self:jump()
	end
	self:coll(dt)
end

