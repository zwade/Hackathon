require("component")

Ghostie = Component:subclass("Ghostie")
Ghostie:include(meleeDamage)

function Ghostie:initialize()
  Component.initialize(self,"Ghost.png",0,0)

end

function Ghostie:init(parent)
	parent.speed = 100
	parent.health = 13
	parent.invulns = 0.5
end

function Ghostie:render(sx,sy)
        if self.parent.x<self.parent.protagonist.x then
                sx = 1
        else
                sx = -1
        end
        Component.render(self,sx,sy)
end

function Ghostie:update(dt)
        self:damage(self.parent.protagonist,40,3)
        Component.update(self,dt)

end
