require("Entities")
require("component")
require("Pivot")
require("Arm")
require("Grid")
require("Zombie")
require("Walker")
require("Ghost")
require("Ghostie")
require("Minigun")
require("Shotgun")
--require("Fairy")
--require("PFairy")


local keyList = {"up","down","left","right"," "}

exampleT = {imageList={
		{image="base1.png",
		x = -14,
		y = -64,
		o1 = 0,
		}
	}
} 

entities = {}
temp1 = { Walker(),
 }

temp2 = {  Ghostie(), }

--temp3 = {PFairy()}

temp = { Component( "Chasis.png",0,0,true),
	 Component( "Head.png",0,-(65/2+13)),
	 Component( "RocketSkate.png",0,(65/2)+20),
	 Minigun( "Minigun.png",-24,-12,"l",entities),
	 Shotgun( "Shotgun.png",24,-12,"r",entities)
 }
function love.conf(t)
	t.screen.fullscreen = true
end


key_factory = {}
key_factory["1"]=love.graphics.newImage("crate32_1.png")
key_factory["2"]=love.graphics.newImage("crate32_metal1.png")
key_factory["3"]=love.graphics.newImage("factorytile_32_1.png")
key_factory["4"]=love.graphics.newImage("factorytile_32_2.png")
key_factory["5"]=love.graphics.newImage("machinery1.png")
key_factory["6"]=love.graphics.newImage("machinery1.png")
key_factory["7"]=love.graphics.newImage("machinery1.png")
key_factory["8"]=love.graphics.newImage("machinery1.png")
function parseMap(filename,key)
	file = love.filesystem.read(filename)
	file = file:gsub("\n","")
	file = file:gsub("\r","")
	file = file:gsub(" ","")
	file = file:gsub("","")
	file = file:sub(2)
	ret = {}
	enties = {}
	count = 1
	--print(file)
	--print("--------")
	for i=0, 32 do
		ret[i] = {}
		for a=0, 24 do
			char = file:sub(a*32+i,a*32+i)
			if char == "0" then
				ret[i][a] = false
			elseif char=="6" or char=="7" or char=="8" then
				local tmp = {Walker()}
				enties[count] = Zombie(i*32,a*32,tmp,{},prot)
				enties[count].id = i*24+a
				count = count+1
			else 
				ret[i][a] = key[char]
			end
		end
	end
	return ret,enties
end
function love.load()
	love.graphics.setMode( 1024,768, false, true, 0 )
	loadlevel("FactoryD2.txt",key_factory)
end

function loadlevel(level,key)
	prot = Entity:new(0,0,temp,map)
	prot.id = 0
	gr,entities = parseMap(level,key)
	love.graphics.setBackgroundColor(0,0,0)
	map = Grid(32,24,gr)
	prot.grid = map
	prot:passEntityList(entities)
	for i in pairs(entities) do
		entities[i].grid = map
	end
	for i in pairs(entities) do
		entities[i]:passEntityList(entities)
	end
end

function love.update(dt)
	keys = getKeys(keyList)
	for i in pairs(entities) do
		en = entities[i]
		en:behave(keys,dt)
		en:moveV(dt,true)
		en:moveH(dt)
	end
	prot:behave(keys,dt)
	prot:moveV(dt,true)
	prot:moveH(dt)
	
end
function love.keypressed(key)
	if key==" " then
		prot:alterVelocity(-500)
	end
	if key=="escape" then
		love.event.push("quit")
	end
	if key=="q" then
		prot:takeHit()
		print(prot.y)
	end
end
function love.mousepressed(x,y,type)
	prot:fire(type)
end
function love.draw()
	for i in pairs(entities) do
		entities[i]:renderC()

	end
	prot:renderC()
	map:render()
end 

function getKeys(keys)
	ret = {}
	for i in pairs(keyList) do
		v = keyList[i]
		ret[v] = love.keyboard.isDown(v)
	end
	return ret
end 
