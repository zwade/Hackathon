require("GameEntity")

function love.load()
	x = GameEntity:new(0,0,true,true,love.graphics.newImage("sprite.png"))
	print(x.x)
	print(x.y)
	x:move(100,100)
	print(x.x)
	print(x.y)
end

function love.draw()
	x:render()
end

