Zombie = Entity:subclass("Zombie")
function Zombie:initialize(nx,ny,template,map,prot)
	Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
end

function Zombie:behave(keys,dt)
	if self.x > self.protagonist.x then
		self.vx = self.vx - 25
	else 
		self.vx = self.vx + 25
	end
	self:coll(dt)
end
