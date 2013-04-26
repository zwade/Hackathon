require("Entities")

local keyList = {"up","down","left","right"," "}

exampleT = {imageList={
		{image="base1.png",
		x = -14,
		y = -64,
		o1 = 0,
		}
	}
} 

function love.load()
	love.graphics.setMode( 1024, 1024, false, true, 0 )
	love.graphics.setBackgroundColor(0,255,0)
	prot = Entity:new(0,0, {base="base1.png", head="head-generic.png", torso="torso-generic.png", right="right1.png", left="left1.png"})
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
	if key=="q" then
		print(prot.y)
	end
end
function love.draw()
	prot:render()
end 

function getKeys(keys)
	ret = {}
	for i in pairs(keyList) do
		v = keyList[i]
		ret[v] = love.keyboard.isDown(v)
	end
	return ret
end 
