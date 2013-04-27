require("component")
require("damagemix")

SpiderC = Component:subclass("SpiderC")
SpiderC:include(meleeDamage)
function SpiderC:initialize()
  Component.initialize(self,"Spyderp.png",0,0,true)

end
function SpiderC:render(sx,sy)
	if self.parent.x<self.parent.protagonist.x then
		sx = -1
	else 
		sx = 1
	end
	Component.render(self,sx,sy)
end
function SpiderC:init(parent)
	parent.speed = 100
end
function SpiderC:update(dt)
	self:damage(self.parent.protagonist,15,2)
	Component.update(self,dt)

end
