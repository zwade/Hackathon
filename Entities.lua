require("middleclass/middleclass")

Entity = class("Entity")

Entity.static.G = 500
Entity.static.F = 500

function Entity:initialize(nx,ny,sprite,template)
	--self.components = template

	self.imageList = sprite

	self:setImage()

	self.horizlimit = 300
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = nx
	self.y = ny
	self.vx = 0
	self.ux = 0
	self.vy = 0
	self.ux = 0
	
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

function love.draw()
	love.graphics.draw(image,0,0)
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

function Entity:renderT(mx,my)
	scalex = 1
	scaley = 1
	if self.x>mx then
		scalex = scalex*-1
	end
	if mx>self.x then
		renderRight(mx,my,scalex,scaley)
		renderBody(mx,my,scalex,scaley)
		renderLeft(mx,my,scalex,scaley)
	else
		renderLeft(mx,my,scalex,scaley)
		renderBody(mx,my,scalex,scaley)
		renderRight(mx,my,scalex,scaley)
	end
end
		
function Entity:renderLeft(mx,my,scalex,scaley)
	for i in self.templateLeft do
		dir = math.atan((i.y+self.y-my)/(i.x+self.x-mx))+math.pi/2
		if mx>self.x then
			d1=d1+math.pi
		end
		love.graphics.draw(i.image,i.x+self.x,i.y+self.y,dir,scalex,scaley,i.ox,i,oy)
	end
end

function Entity:renderRight(mx,my,scalex,scaley)
	for i in self.templateRight do
		dir = math.atan((i.y+self.y-my)/(i.x+self.x-mx))+math.pi/2
		if mx>self.x then
			d1=d1+math.pi
		end
		love.graphics.draw(i.image,i.x+self.x,i.y+self.y,dir,scalex,scaley,i.ox,i,oy)
	end
end

function Entity:renderBody(mx,my,scalex,scaley)
	love.graphics.draw(self.image,self.x,self.y,0,scalex,scaley,self.image:getWidth()/2,self.image:getHeight()/2)
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
function Entity:behave(keys,dt)
	nx = 0
	ny = 0
	if keys["left"] then
		self.vx=self.vx-25
	end
	if keys["right"] then
		self.vx=self.vx+25
	end
end

function Entity:getCoord()
	return {self.x,self.y}
end
function Entity:moveH(dt, friction)
	friction = friction or true
	if self.vx > 0 and friction then
		self.vx = self.vx-dt*Entity.F
	end
	if self.vx < 0 and friction then
		self.vx = self.vx+dt*Entity.F
	end
	if self.vx > self.horizlimit then
		self.vx = self.horizlimit
	end
	if self.vx < -self.horizlimit then
		self.vx = -self.horizlimit
	end
	nx = self.vx*dt
	self:move(nx,0)
		
end
function Entity:moveV(dt,gravity)
	gravity = gravity or true
	if gravity then
		self.vy = self.vy+dt*Entity.G
		ny = self.vy*dt
	end
	if self.y <= 1024 then
		self:move(0,ny)
	end
	if self.y > 1024 then
		self.vy = 0
		self:set(self.x,1024)
	end
end
