require("component")

Ghostie = Component:subclass("PFairy")

function PFairy:initialize()
  Component.initialize(self,"Fairy.png",0,0)

end

function PFairy:init(parent)
  parent.speed = 100
end
