function love.load()
	idb = love.image.newImageData("base.png")
	idt = love.image.newImageData("torso.png")
	idh = love.image.newImageData("head.png")
	idl = love.image.newImageData("left.png")
	idr = love.image.newImageData("right.png")
	fin = love.image.newImageData(96,128)
	fin:paste(idb,24,76)
	fin:paste(idt,24,28)
	fin:paste(idh,34,0)
	fin:paste(idl,0,28)
	fin:paste(idr,72,28)
	image = love.graphics.newImage(fin)
end

function love.draw()
	love.graphics.draw(image,0,0)
end

