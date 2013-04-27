require("component")
Necro = Component:subclass("Necro")

function removeitem(list, index)
        ret = {}
        for i=1,(index-1) do
                ret[i] = list[i]
        end
        for i=(index+1),#list do
                ret[i-1] = list[i]
        end
        return ret
end

function Necro:initialize(att,parent)
	Component.initialize(self,"Necromancer.png",0,0)
	self.protagonist = prot
	self.parent = parent
	self.attack = att
	self.bullets = {}

end
function Necro:render(sx,sy)
        Component.render(self,sx,sy)
        for i in pairs(self.bullets) do
                self.bullets[i]:render()
        end
end

function Necro:init(parent)
	parent.invuln = .1
end
function Necro:update(dt)
	self.attack = self.attack-dt
	while #self.bullets>25 do
		self.bullets = removeitem(self.bullets,1)
	end
	for i in pairs(self.bullets) do
                self.bullets[i]:update(self.entities,dt)
        end
	vx = self.parent.protagonist.x - self.x
	vy = self.parent.protagonist.y - self.y
	mag = math.sqrt(vx*vx+vy*vy)
	vx = vx/mag
	vy = vy/mag
	if self.attack < 0 then
		self.attack = 2
		--self.bullets[#self.bullets+1] = Projectile(self.x,self.y,vx*100,vy*100,love.graphics.newImage("RedBullet.png"),self,2)
	end
end
