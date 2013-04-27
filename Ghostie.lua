require("component")

Ghostie = Component:subclass("Ghostie")

function Ghostie:initialize()
  Component.initialize(self,"Ghost.png",0,0)

end

function Ghostie:init(parent)
	parent.speed = 100
end
