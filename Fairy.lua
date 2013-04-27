Fairy = Entity:subclass("Fairy")
function Fairy:initialize(nx,ny,template,map,prot)
	Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
	self.bullets={}
end

function Fairy:behave(keys,dt)
	if self.y+200 > self.protagonist.y then
		self.vy = self.vy - 5
	else if self.y-200 < self.protagonist.y then
		self.vy = self.vy + 5
	if self.x+200 > self.protagonist.x then
		self.vx = self.vx - 5
	else if self.x-200 < self.protagonist.x then
		self.vx = self.vx + 5
	end
	while #self.bullets>25 do
		self.bullets = removeitem(self.bullets,1)
		print(#self.bullets)
	end
	Entity.behave(self,dt)
	for i in pairs(self.bullets) do
		self.bullets[i]:update({},dt)
	end
	self:coll(dt)
end

function removeitem(list, index)
        ret = {}
        for i=1,(index-1) do
                ret[i] = list[i]
        end
        for i=(index+1),#list do
                ret[i-1] = list[i]
        end
        return ret
end

function Fairy:renderC(dt)
	Entity.renderC(dt)
	for i in pairs(self.bullets) do
		self.bullets[i]:render()
	end
end

function Fairy:fire(type)
	if type==self.weapon then
		vx = self.prot.x-self.x
		vy = self.prot.x-self.y
		mag = math.sqrt(vx*vx+vy*vy)
		vx = vx/mag
		vy = vy/mag
		self.bullets[#self.bullets+1] = Projectile(self.x,self.y,vx*2000,vy*2000,love.graphics.newImage("shot.png"))
		print(self.bullets[#self.bullets+1])
	end
end
