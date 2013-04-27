require("middleclass/middleclass")

Grid = class("Grid")

function Grid:initialize(width, height, elements)
	self.w = width
	self.h = height
	
	self.map = {}

	if elements then
		self.map = elements
	else 
		for i = 0, (width-1) do 
			self.map[i] = {}
			for a = 0, (height-1) do
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

function Grid:checkY(cy,cx,wid)
	tmpy=math.floor(cy/32)
	if cy%32~=32 and (cy%32>16 or cy%32==0)  then
		return false
	end
	tmpx1 = math.floor((cx-wid/2)/32)
	tmpx2 = math.floor((cx+wid/2)/32)
	if tmpx1<0 then
		tmpx1 = 0
	end
	if tmpx2>self.w then
		tmpx2 = self.w
	end
	for i = tmpx1, tmpx2 do
		if self:get(i,tmpy) then
			return (tmpy)*32
		end
	end
end

function Grid:checkX(cx,cy,wid,hei)
	l1 = math.floor((cx+wid/2)/32)
	l2 = math.floor((cx-wid/2)/32)
	h1 = math.floor((cy+hei/2)/32)
	h2 = math.floor((cy-hei/2)/32)
	if l1>self.w then
		l1 = self.w
	end
	if l1<0 then
		l1=0
	end
	if h1> self.h then
		h1 = self.h
	end
	if h1< 0 then
		h1 = 0
	end
	for i = h2,h1 do
		print(i)
		if self:get(l1,i) then
			print("yeahhhhhhh")
			return l1*32
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
