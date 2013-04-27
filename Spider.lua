Spider = Entity:subclass("Spider")
function Spider:initialize(nx,ny,template,map,prot)
  Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
	self.speed = math.random(8,20)
end

function Spider:behave(keys,dt)
	if self.y > self.protagonist.y then
		self.vy = self.vy + self.speed 
	else 
		self.vy = self.vy + self.speed
	end
	self:coll(dt)
end
