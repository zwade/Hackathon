require("GameEntity")
require("Methods")

PlayerEntity    = {}
PlayerEntity.mt = {}

PlayerEntity.mt.__index = PlayerEntity

function PlayerEntity:new(nx,ny,axx,axy,sprites)
	template = GameEntity:new(nx,ny,axx,axy,sprites)
	oldmt = getmetatable(template)
	PlayerEntity.mt = mergeTables(oldmt,PlayerEntity.mt)
	return setmetatable(template,PlayerEntity.mt)
end

function PlayerEntity:print()
	print(self.x,self.y)
end




