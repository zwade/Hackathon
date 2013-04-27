Necro = Entity:subclass("Necro")
function Necro:initialize(nx,ny,template,map,prot)
  Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
end
function Necro:init(parent)
	parent.invuln = .1
end
function Necro:behave(keys,dt)
	self:coll(dt)
end
