require("component")

Walker = Component:subclass("Walker")

function Walker:initialize()
	Component.initialize(self,"walker.png",0,0,true)

end

function Walker:init(parent)
	parent.speed = 100
end
