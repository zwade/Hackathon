require("component")
require("damagemix")
local num=false
SawC = Component:subclass("SawrC")
SawC:include(meleeDamage)
function SpiderC:initialize()
  Component.initialize(self,"Spike1.png",0,0,true)

end
function SawC:render(sx,sy)
  if self.parent.x<self.parent.protagonist.x then
		sx = -1
	else 
		sx = 1
	end
	Component.render(self,sx,sy)
	if(num)
		love.graphics.draw(self.image,self.parent.x+tmpx,self.parent.y+tmpy, self.dir, sx,sy,self.ox,self.oy)
	else
		love.graphics.draw("Spike2.png",self.parent.x+tmpx,self.parent.y+tmpy, self.dir, sx,sy,self.ox,self.oy)
end
function SawC:init(parent)
	--parent.speed = 100
end
function SawC:update(dt)
	self:damage(self.parent.protagonist,15,3)
	
	Component.update(self,dt)

end
