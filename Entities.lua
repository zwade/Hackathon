require("middleclass/middleclass")
require("Projectile")

Entity = class("Entity")


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
	
function Entity:initialize(nx,ny,template,map,w)
	self.components = template
	if #template==1 then
		self.components[1].torso = true
	end
	self.grid = map

	--self:setImage()
	tmp = self:getCollision()
	self.win = w
	self.G = 500
	self.F = 500
	self.bottom = tmp[1]
	self.invuln = 1
	self.health = 10
	self.width = tmp[2]
	self.speed = 300
	self.x = nx
	self.alive = true
	self.jh = -300
	self.y = ny
	self.canJump = false
	self.vx = 0
	self.ux = 0
	self.vy = 0
	self.ux = 0
	self.damagelimt = 0
	self.entities = {}
	for i in pairs(self.components) do
		self.components[i].parent = self
		self.components[i]:init(self)
	end
	self.projectiles = {}	
end

function Entity:jump()
	if self.canJump then
		self:alterVelocity(self.jh)
		self.canJump = false
	end
end
function Entity:move(nx,ny)
	self.x=self.x+nx
	self.y=self.y+ny
end

function Entity:setImageT()
	fin = love.image.newImageData(48,128)

	for i in self.template.body do
		fin:paste(i.image,i.x,i.y)
	end
	finimage = love.graphics.newImage(fin)
	self.image = finimage

end
function Entity:die()
	self.alive = false
end

function Entity:takeHit(dmg)
	dmg = dmg or 1
	if self.damagelimt > 0 then
		return
	end
	self.health = self.health - dmg
	self.damagelimt = self.invuln
	if self.health <= 0 then
		self:die()
	end
	for i in pairs(self.components) do
		self.components[i]:takeHit()
	end
end
function Entity:setImage()
	idb = love.image.newImageData(self.imageList["base"])
	idt = love.image.newImageData(self.imageList["torso"])
	idh = love.image.newImageData(self.imageList["head"])
	fin = love.image.newImageData(48,128)
	fin:paste(idb,0,76)
	fin:paste(idt,0,28)
	fin:paste(idh,10,0)
	finimage = love.graphics.newImage(fin)
	self.image = finimage
	
	idl = love.graphics.newImage(self.imageList["left"])
	idr = love.graphics.newImage(self.imageList["right"])
	
	self.leftarm = idl
	self.rightarm = idr

end



function Entity:set(nx, ny)
	if nx==0 and ny==0 then
		return
	end
	if nx==0 then
		self.y = ny
	end
	if ny==0 then
		self.x = nx
	end
	self.x = nx
	self.y = ny
end

function Entity:renderC(dt)
	if not(self.alive) then
		return
	end	
	sx = 1
	sy = 1
	if love.mouse:getX()<self.x then
		sx=sx*-1
	end
	for i in pairs(self.components) do
		if self.components[i].z < 0 then
			self.components[i]:render(sx,sy)
		end
	end
	for i in pairs(self.components) do
		if self.components[i].z == 0 then
			self.components[i]:render(sx,sy)
		end
	end
	for i in pairs(self.components) do
		if self.components[i].z > 0 then
			self.components[i]:render(sx,sy)
		end
	end
end

function Entity:getCollision()
	cx = 0
	bw = 0
	for i in pairs(self.components) do
		en = self.components[i]
		if en.y+en.h/2>cx then
			cx = en.y+en.h/2
			bw = en.w
		end
	end
	return {cx,bw}
end
function Entity:minmaxXY() 
	if not(self.alive) then
		return {-1,-1,-1,-1}
	end
	for i in pairs(self.components) do
		en = self.components[i]
		if en.torso then
			ret = {}
			ret[1] = self.x+en.x-en.w
			ret[2] = self.x+en.x+en.w
			ret[3] = self.y+en.y-en.h
			ret[4] = self.y+en.y+en.h
			return ret
		end
	end
end		
function Entity:fire(ms)
	for i in pairs(self.components) do
		en = self.components[i]
		en:fire(ms)
	end
end
function Entity:render()										

	scalex = 1
	scaley = 1

	ox = self.image:getWidth()/2
	oy = self.image:getHeight()/2


	o1 = self.rightarm:getWidth()/2
	o2 = self.leftarm:getWidth()/2

	x1 = (self.x+self.width/2+self.rightarm:getWidth()/3)-o1
	x2 = (self.x-self.leftarm:getWidth()/3)-o2

	y1 = self.y-oy+28*scaley+o1
	y2 = self.y-oy+28*scaley+o2

	mx = love.mouse:getX()
	my = love.mouse:getY()

	d1 = math.atan((y1-my)/(x1-mx))+math.pi/2
	d2 = math.atan((y2-my)/(x2-mx))+math.pi/2

	if self.x>mx then
		scalex = scalex*-1
	end
	if mx>x1 then
		d1=d1+math.pi
	end
	if mx>x2 then
		d2=d2+math.pi
	end
	
	if mx>self.x then
		love.graphics.draw(self.rightarm,x1,y1,d1,scalex,scaley,o1,o1)
		love.graphics.draw(self.image,self.x,self.y,0,scalex,scaley,ox,oy)
		love.graphics.draw(self.leftarm,x2,y2,d2,scalex,scaley,o2,o2)
	else 
		love.graphics.draw(self.leftarm,x2,y2,d2,scalex,scaley,o2,o2)
		love.graphics.draw(self.image,self.x,self.y,0,scalex,scaley,ox,oy)
		love.graphics.draw(self.rightarm,x1,y1,d1,scalex,scaley,o1,o1)
	end
end
function Entity:alterVelocity(v)
	self.vy=self.vy+v
end
function Entity:passEntityList(ent)
	self.entities = ent
	for i in pairs(self.components) do
		self.components[i]:setEntities(ent)
	end
end
function Entity:behave(keys,dt)
	nx = 0
	ny = 0
	if keys["left"] or keys["a"] then
		self.vx=self.vx-25
	end
	if keys["right"] or keys["d"] then
		self.vx=self.vx+25
	end
	self:coll(dt)
end
function Entity:coll(dt)
	self.damagelimt = self.damagelimt - dt
	tmp = self.grid:check(self.y+self.bottom,self.x,self.width)
	if tmp and self.vy>0 then
		self.y=(tmp-self.bottom)
		if self.vy>0 then
			self.vy = 0
			self.canJump = true
		end
	end
	for i in pairs(self.components) do
		self.components[i]:update(dt)
	end
end

function Entity:getCoord()
	return {self.x,self.y}
end
function Entity:moveH(dt, friction)
	friction = friction or true
	if self.vx > 0 and friction then
		self.vx = self.vx-dt*self.F
	end
	if self.vx < 0 and friction then
		self.vx = self.vx+dt*self.F
	end
	if self.vx > self.speed then
		self.vx = self.speed
	end
	if self.vx < -self.speed then
		self.vx = -self.speed
	end
	if self.vx < 1 and self.vx > -1 then
		self.vx = 0
	end
	nx = self.vx*dt
	self:move(nx,0)
	if self.x<25 then
		self.x=25
		self.vx=0
	end
	if self.x>999 then
		if self:areDead() then
			print("All Dead!")
			print(self.level)
			self:win(self.level)
		end
		self.x=999
		self.vx=0
	end
		
end
function Entity:areDead()
	for i in pairs(self.entities) do	
		if self.entities[i].alive then
			print(self.entities[i])
			return false
		end
	end
	return true
end
function Entity:moveV(dt,gravity)
	if gravity then
		self.vy = self.vy+dt*self.G
	end
	ny = self.vy*dt
	if self.y <= (768-self.bottom) then
		self:move(0,ny)
	end
	if self.y > (768-self.bottom) then
		self.vy = 0
		self.canJump = true
		self:set(self.x,(768-self.bottom))
	end
	if (self.y < 0 ) then
		self.vy = 0
		self.y = 0
	end
end
