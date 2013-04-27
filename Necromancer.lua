Necromancer = Entity:subclass("Necromancer")
function Necromancer:initialize(nx,ny,template,map,prot)
  Entity.initialize(self,ent,nx,ny,template,map)
	
	
	self.teleportTime = math.random(1., 20)
	self.summonTime = math.random(1., 4)
	self.attackTime = math.random(6., 12)
	self.protagonist = prot
	self.entities = ent
	--self.noGrav = true
end

function Necromancer:behave(keys,dt)
	
	self.teleportTime = self.teleportTime - dt
	self.summonTime = self.summonTime - dt
	self.attackTime = self.attackTime - dt
	
	if self.teleportTime < 0 then
		self:teleport()
		self.teleportTime = math.random(1., 20)
	end
	if self.summonTime < 0 then
		self:summon()
		self.summonTime =  math.random(1., 4)
	end
	self:coll(dt)
end

function Necromancer:teleport()
	self.x = math.random( 100, 924 )
end

function Necromancer:spawn(thingToSpawn)
	if thingToSpawn == "zombie" then
		tmp = {Walker()}
		temp = Zombie:new(math.random(3,29)*32,math.random(3,20)*32,{Walker()},self.grid,self.protagonist)
		temp.id = math.random(0,123231231)
		self.entities[#self.entities+1] = temp
	end
end

function Necromancer:summon()
	if math.random() < .375 then
		self:spawn("ghost")
	else 
		self:spawn("zombie")
	end
end


function Necromancer:moveV(dt,gravity)
	Entity.moveV(self,dt)
end
