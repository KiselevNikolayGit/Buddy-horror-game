function fillt()
	function pixnoi(x, y, r, g, b, a)
		local power = love.math.random(-24, 24)
		local r = (255 / 2) - power
		local g = (255 / 2) - power
		local b = (255 / 2) - power
		local a = (255 / 5)
		return r,g,b,a
	end
	local w, h = love.window.getMode()
	local pimap = love.image.newImageData(w / 5, h / 5)
	pimap:mapPixel(pixnoi)
	fillter = love.graphics.newImage(pimap)
	fillter:setFilter("nearest")
end

function butcoll(x, y, text, fun)
	if x > text.x and y > text.y and x < text.x + text.w and y < text.y + text.h then
		fun()
	end
end

function love.load()
	do -- Window
		-- love.window.setFullscreen(true)
		local wid, hid = love.window.getMode()
		size = hid
		side = (wid - size) / 2
	end
	do -- Draw
		font = love.graphics.newFont("Press_Start_2P/PressStart2P-Regular.ttf", 50)
		font:setFilter("nearest")
		do -- Title
			title = {}
			title.t = love.graphics.newText(font, "Buddy Horror Story")
			title.rw = ((size - 20) / title.t:getWidth())
			title.rh = 1
			title.x = 10
			title.y = 20
			title.w = title.t:getWidth() * title.rw
			title.h = title.t:getHeight() * title.rh
		end
		do -- Start
			start = {}
			start.t = love.graphics.newText(font, "Start over")
			start.rw = ((size - 200) / start.t:getWidth())
			start.rh = 0.5
			start.x = 100
			start.y = 30 + title.h
			start.w = start.t:getWidth() * start.rw
			start.h = start.t:getHeight() * start.rh
		end
		love.graphics.setBackgroundColor(30, 25, 33)
	end
	do -- Sides
		backimg = love.graphics.newImage("iso/back.bmp")
		backimg:setWrap("repeat")
		backimg:setFilter("nearest")
		local w, h = love.window.getMode()
		local iw, ih = backimg:getDimensions()
		iw = iw * 3
		ih = ih * 3
		local vertices = {
			{ -- top-left
				0, 0,
				0, 0,
				255, 255, 255},
			{ -- top-right
				side, 0,
				side / iw, 0,
				255, 255, 255},
			{ -- bottom-right
				side, h,
				side / iw, h / ih,
				255, 255, 255},
			{ -- bottom-left
				0, h,
				0, h / ih,
				255, 255, 255}
		}
		mesh = love.graphics.newMesh(vertices, "fan")
		mesh:setTexture(backimg)
	end
	do -- Fillter
		fillt()
	end
	do -- World
		World = love.physics.newWorld(0, 15)
	end		
	do -- Edges
		bors = {}
		bors[1] = {
			b = love.physics.newBody(World, 0, 0, "static"),
			s = love.physics.newEdgeShape(0, 0, size, 0),
		}
		bors[2] = {
			b = love.physics.newBody(World, 0, 0, "static"),
			s = love.physics.newEdgeShape(size, 0, size, size),
		}
		bors[3] = {
			b = love.physics.newBody(World, 0, 0, "static"),
			s = love.physics.newEdgeShape(0, 0, 0, size),
		}
		bors[4] = {
			b = love.physics.newBody(World, 0, 0, "static"),
			s = love.physics.newEdgeShape(0, size, size, size),
		}
		for i, border in ipairs(bors) do
			border.f = love.physics.newFixture(border.b, border.s)
		end
	end
	do -- Audio
		local a = {}
		a.main = love.audio.newSource("sou/run.ogg", "static")
		love.audio.play(a.main)
	end
end

function love.update(dt)
	do -- World
		World:update(dt)
	end
	do -- Fillt
		if isfillter == nil or isfillter >= 1 then
			fillt()
			isfillter = 0
		else
			isfillter = isfillter + dt
		end
	end
end

function love.wheelmoved(x, y)
end

function love.keypressed(key, scancode, isrepeat)
	do -- Window control
		if key == "escape" then
			love.window.close()
		end
	end
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button, isTouch)
	x = x - side
	do -- Buttons
		butcoll(x, y, title, function() print("roar") end)
		butcoll(x, y, start, function() print("start") end)
	end
end

function love.mousereleased(x, y, button, isTouch)
end

function love.textinput(text)
end

function love.draw()
	do -- Sides
		love.graphics.setColor(255, 255, 255)		
		love.graphics.translate(side, 0)
		love.graphics.draw(mesh, -side, 0)
		love.graphics.draw(mesh, size, 0)
	end
	do -- Menu
		love.graphics.setColor(109, 84, 103)
		love.graphics.setFont(font)
		love.graphics.print(tostring(love.timer.getFPS()), -side + 10, 10, -0.06, 0.2, 0.2)
		love.graphics.draw(title.t, title.x, title.y, 0, title.rw, title.rh)
		love.graphics.draw(start.t, start.x, start.y, 0, start.rw, start.rh)
	end
	do -- Fillter
		love.graphics.setColor(255 / 2, 255 / 2, 255 / 2)		
		love.graphics.draw(fillter, -side, 0, 0, 5, 5)
	end
end