require("component")

Pivot = Component:subclass("Pivot")

function Pivot:initialize(img, cx, cy)
	Component.initialize(self,img,cx,cy)
	self.ox = self.w/2
	self.oy = self.w/2
end

