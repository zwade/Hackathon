require("component")

Walker = Component:subclass("Walker")

function Walker:initialize()
	Component.initialize(self,"walker.png",0,0,true)

end
function Walker:render(sx,sy)
	if self.parent.x<self.parent.protagonist.x then
		sx = -1
	else 
		sx = 1
	end
	Component.render(self,sx,sy)
end
function Walker:init(parent)
	parent.speed = 100
end
