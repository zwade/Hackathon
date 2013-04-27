require("middleclass/middleclass")

meleeDamage = {
	damage = function(self, other,range,damage)
		if not(self.parent.alive) then
			return
		end
		print(self.parent.x,self.y)
		print(other.x,other.y)
		dist = math.sqrt((self.parent.x-other.x)*(self.parent.x-other.x)+(self.parent.y-other.y)*(self.parent.y-other.y))
		print(dist)
		if dist < range then
			other:takeHit(damage)
			print("HIT")
		end
	end
}
