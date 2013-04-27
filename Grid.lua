require("middleclass/middleclass")

Grid = class("Grid")

function Grid:initialize(width, height, elements)
	self.w = width
	print(width,height)
	self.h = height
	
	self.map = {}

	if elements then
		self.map = elements
	else 
		for i = 0, width do 
			self.map[i] = {}
			for a = 0, height do
				self.map[i][a] = false
			end
		end
	end

end

function Grid:get(px,py)
	return self.map[px][py]
end

function Grid:set(px,py,img)
	self.map[px][py] = img
end

function Grid:check(cy,cx,wid)
	tmpy=math.floor(cy/32)
	tmpy = tmpy-1
	if cy%32>8 then
		return false
	end
	tmpx1 = math.floor((cx+wid/2)/32)
	tmpx1 = tmpx1-1
	tmpx2 = math.floor((cx+wid/2)/32)
	tmpx2 = tmpx2-1
	for i = tmpx1, tmpx2 do
		print(tmpy,i)
		if self:get(i,tmpy) then
			print("YUP")
		end
	end
end

function Grid:render()
	for i in pairs(self.map) do
		for a in pairs(self.map[i]) do
			ti = self.map[i]
			ta = self.map[i][a]
			if (ta) then
				love.graphics.draw(ta,i*32,a*32)
			end
		end
	end
end
