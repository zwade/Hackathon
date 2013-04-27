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
function parseMap(filename)
	mp = Grid(32,24)
	enties = {}
	file = love.filesystem.read(filename)
	file = file:gsub("\n","")
	file = file:gsub("\r","")
	file = file:gsub(" ","")
	file = file:gsub("","")
	file = file:sub(2)
	ret = {}
	--print(file)
	--print("--------")
	for i=0, 31 do
		ret[i] = {}
		for a=0, 23 do
			char = file:sub(a*32+i,a*32+i)
			--print(char)
			if char == "0" then
				ret[i][a] = false
			elseif char=="6" or char=="7" or char=="8" then
				enties[#enties+1] = Zombie:new(i*32,a*32,{Walker(),},mp,prot)
				enties[#enties].is=a*32+i
			else
				mp:set(i,a, key_factory[char])
			end
		end
	end
	return mp,enties
end
function love.load()
	love.graphics.setMode( 1024,768, false, true, 0 )
	love.graphics.setBackgroundColor(0,0,0)
	test,size = love.filesystem.read("FactoryD1.txt")
	prot = Entity:new(0,0,temp)
	prot.id=0
	map,entities = parseMap("FactoryD1.txt")
	prot.grid = map
	--map = Grid(32,24,gr)
	--map:set(1,1,love.graphics.newImage("dirt.png"))
	--map:set(2,22,love.graphics.newImage("dirt.png"))
	--map:set(31,23,love.graphics.newImage("dirt.png"))
	--zomb = Zombie:new(100,100,temp1,map,prot)
	--ghost = Ghost:new(100,200,temp2,map,prot)
	--prot.id = 1
	--zomb.id = 2
	--ghost.id = 3
	--entities = {prot,zomb,ghost}
	--prot:passEntityList(entities)
	--zomb:passEntityList(entities)
	--ghost:passEntityList(entities)
	entities[#entities+1] = prot
	for i in pairs(entities) do
		entities[i]:passEntityList(entities)
	end
end

function love.update(dt)
	keys = getKeys(keyList)
	for i in pairs(entities) do
		en = entities[i]
		en:behave(keys,dt)
		if not(en.noGrav) then
			en.moveV(dt,true)
		else
			en.move(dt)
		en.moveH(dt)
	end
	-prot:behave(keys,dt)
	-prot:moveV(dt,true)
	-prot:moveH(dt)
	-zomb:behave(keys,dt)
	-zomb:moveV(dt,true)
	-zomb:moveH(dt)
	-ghost:behave(keys,dt)
	-ghost:moveV(dt)
	-ghost:moveH(dt)
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
	--prot:renderC()
	--zomb:renderC()
	--ghost:renderC()
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
