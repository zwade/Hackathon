Zombie = Entity:subclass("Zombie")


function Zombie:behave(keys,dt)
	self:coll(dt)
end
