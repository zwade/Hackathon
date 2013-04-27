require("Entities")
require("component")
require("Pivot")
require("Arm")
require("Grid")
require("Zombie")
require("Walker")
require("Ghostie")

local keyList = {"up","down","left","right"," "}

exampleT = {imageList={
		{image="base1.png",
		x = -14,
		y = -64,
		o1 = 0,
		}
	}
} 

temp1 = { c1 = Walker(),
 }
temp = { c1 = Component( "Chasis.png",0,0,true),
	 c2 = Component( "Head.png",0,-(65/2+13)),
	 c3 = Component( "RocketSkate.png",0,(65/2)+20),
	 a1 = Arm( "Minigun.png",-24,-12),
	 a2 = Arm( "Minigun.png",24,-12)
 }

function love.conf(t)
	t.screen.fullscreen = true
end
function love.load()
	love.graphics.setMode( 1024,768, false, true, 0 )
	love.graphics.setBackgroundColor(0,255,0)
	map = Grid(32,24)
	map:set(1,1,love.graphics.newImage("dirt.png"))
	map:set(2,22,love.graphics.newImage("dirt.png"))
	map:set(31,23,love.graphics.newImage("dirt.png"))
	prot = Entity:new(0,0,temp,map)
	zomb = Zombie:new(100,100,temp1,map,prot)
end

function love.update(dt)
	keys = getKeys(keyList)
	prot:behave(keys,dt)
	prot:moveV(dt)
	prot:moveH(dt)
	zomb:behave(keys,dt)
	zomb:moveV(dt)
	zomb:moveH(dt)
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
function love.mousepressed()
	prot:fire()
end
function love.draw()
	prot:renderC()
	zomb:renderC()
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
