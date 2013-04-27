Saw = Entity:subclass("Saw")
function Spider:initialize(nx,ny,template,map,prot)
  Entity.initialize(self,nx,ny,template,map)
  self.protagonist = prot
end

function Saw:behave(keys,dt)
	self:coll(dt)
	
end
