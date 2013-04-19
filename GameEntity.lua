
GameEntity = {}
GameEntity.mt = {}

GameEntity.mt.__index = GameEntity

function GameEntity:new(nx,ny,axx,axy,image)
	nx = nx or 0
	ny = ny or 0
	axx = axx or true
	axy = axy or true
	template = {
		x = nx,
		y = ny,
		Xaxis = axx,
		Yaxis = axy,
		sprite = image,
	}
	return setmetatable(template,GameEntity.mt)
end

function GameEntity:move(Xax,Yax)
	if self.Xaxis then
		self.x = self.x+Xax
	end
	if self.Yaxis then
		self.y = self.y+Yax
	end
end

function GameEntity:render()
	if self.sprite then
		love.graphics.draw(self.sprite,self.x,self.y)
	end
end

