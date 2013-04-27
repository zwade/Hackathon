require("middleclass/middleclass")

meleeDamage = {
	damage = function(self, other,range,damage)
		if not(self.parent.alive) then
			return
		end
		dist = math.sqrt((self.parent.x-other.x)*(self.parent.x-other.x)+(self.parent.y-other.y)*(self.parent.y-other.y))
		if dist < range then
			other:takeHit(damage)
			print("HIT")
		end
	end
}
