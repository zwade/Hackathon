require("middleclass/middleclass")

Component = class("Component")

function Component:Initialize(img,cx,cy)
	self.image = img
end

function Component:render(parent,x,y,w,h,sx,sy,dt)
	
	
