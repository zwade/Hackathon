Zombie = Entity:subclass("Zombie")
function Zombie:initialize(nx,ny,template,map,prot)
	Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
end

function Zombie:behave(keys,dt)
	speed = math.random(13,25)
	if self.x > self.protagonist.x then
		self.vx = self.vx - speed 
	else 
		self.vx = self.vx + speed
	end
	self:coll(dt)
end
