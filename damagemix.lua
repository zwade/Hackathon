require("middleclass/middleclass")

meleeDamage = {
	damage = function(self, other,range,damage)
		dist = math.sqrt((self.x-other.x)*(self.x-other.x)+(self.y-other.y)*(self.y-other.y))
		print(dist)
		if dist < range then
			other:takeHit(damage)
			print("HIT")
		end
	end
}
