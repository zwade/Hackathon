Ghost = Entity:subclass("Ghost")
function Ghost:initialize(nx,ny,template,map,prot)
	Entity.initialize(self,nx,ny,template,map)
	self.protagonist = prot
end

function Ghost:behave(keys,dt)
	if math.abs(self.x+40-self.protagonist.x)<200 then
                if self.x+40 > self.protagonist.x then
                        self.vx = self.vx - 40
                else
                        self.vx = self.vx + 40
                end
        else
                if self.x+40 > self.protagonist.x then
                        self.vx = self.vx - 25
                else
                        self.vx = self.vx + 25
                end
	end
	if math.abs(self.y+35-self.protagonist.y)<200 then
		if self.y+35 > self.protagonist.y then
			self.vy = self.vy - 5
		else 
			self.vy = self.vy + 5
		end
	else
		if self.y+35 > self.protagonist.y then
                        self.vy = self.vy - 2
                else
                        self.vy = self.vy + 2
		end
	end
	self:coll(dt)
end

function Ghost:moveV(dt,gravity)
	Entity.moveV(self,dt)
end
