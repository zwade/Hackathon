require("Entities")
require("component")
require("Pivot")
require("Arm")
require("Grid")

local keyList = {"up","down","left","right"," "}

exampleT = {imageList={
		{image="base1.png",
		x = -14,
		y = -64,
		o1 = 0,
		}
	}
} 

temp = { c1 = Component(love.graphics.newImage("Chasis.png"),0,0),
	 c2 = Component(love.graphics.newImage("Head.png"),0,-(65/2+13)),
	 c3 = Component(love.graphics.newImage("RocketSkate.png"),0,(65/2)+20),
	 a1 = Arm(love.graphics.newImage("Minigun.png"),-24,-12),
	 a2 = Arm(love.graphics.newImage("Minigun.png"),24,-12)
 }

function love.conf(t)
	t.screen.fullscreen = true
end
function love.load()
	love.graphics.setMode( 1024,768, false, true, 0 )
	love.graphics.setBackgroundColor(0,255,0)
	map = Grid(32,24)
	map:set(1,1,love.graphics.newImage("dirt.png"))
	map:set(0,0,love.graphics.newImage("dirt.png"))
	map:set(31,23,love.graphics.newImage("dirt.png"))
	prot = Entity:new(0,0,temp,map)
end

function love.update(dt)
	keys = getKeys(keyList)
	prot:behave(keys,dt)
	prot:moveV(dt)
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
		print(prot.y)
	end
end
function love.draw()
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
