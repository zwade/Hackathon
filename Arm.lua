Arm = Pivot:subclass("Arm")

function Arm:update(dt)
	mx = love.mouse:getX()
        my = love.mouse:getY()

	xv = self.x+self.parent.x
	yv = self.y+self.parent.y
	
	print(xv,yv)

        self.dir = math.atan((yv-my)/(xv-mx)) + math.pi/2

	if self.x<0 then
		self.z = 1
	else 
		self.z = -1
	end
        --if self.parent.x>mx and self.x<0 then
	--	self.z = -1
        --elseif self.parent.x>mx and self.x>0 then
	--	self.z = 1
	--elseif self.parent.x<mx and self.x<0 then
	--	self.z = 1
	--else
	--	self.z = -1
	--end
        if mx>xv then
                self.dir=self.dir+math.pi
        end
	

end
