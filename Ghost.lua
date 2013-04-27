Ghost = Entity:subclass("Ghost")
function Ghost:initialize(nx,ny,template,map,prot)
	Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
end

function Ghost:behave(keys,dt)
	if self.x > self.protagonist.x then
		self.vx = self.vx - 25
	else 
		self.vx = self.vx + 25
	end
	if self.y > self.protagonist.y then
		self.vy = self.vy - 25
	else 
		self.vy = self.vy + 25
	end
	self:coll(dt)
end
