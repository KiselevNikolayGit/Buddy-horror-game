-- function funstart()&&	function love.wheelmoved(x, y)&&	end&&	function love.keypressed(key, scancode, isrepeat)&&	end&&	function love.keyreleased(key)&&	end&&	function love.mousepressed(x, y, button, isTouch)&&		x = x - side&&	end&&	function love.mousereleased(x, y, button, isTouch)&&		x = x - side&&	end&&	function love.textinput(text)&&	end&&	function love.draw()&&		preeffects()&&   aftereffects()&&	end&&end

function radio(y)
	filltboolean = not filltboolean
	if math.abs(filltop) >= 200 then
		filltop = 199
		wheelpos = nil
	end
	if wheelpos ~= nil then
		if wheelpos < (255 - 55) * 25.5 and wheelpos > (-255 + 55) * 25.5 then
			wheelpos = wheelpos + (y / 12.23) + ((50 - love.math.random(0, 100)) / 150)
		end
	else
		wheelpos = math.floor(filltop / 25.5)
	end
	filltop = math.abs(wheelpos) * 25.5
end

function fillt()
	filltop = filltop - ((23 - (love.math.random(0, 60))) / 23)	
	function pixnoi(x, y, r, g, b, a)
		local power = love.math.random(-24, 24)
		local r = (255 / 2) - power
		local g = (255 / 2) - power
		local b = (255 / 2) - power
		local a = (255)
		return r,g,b,a
	end
	local w, h = love.window.getMode()
	local pimap = love.image.newImageData(w / 5, h / 5)
	pimap:mapPixel(pixnoi)
	fillter = love.graphics.newImage(pimap)
	fillter:setFilter("nearest")
end

function vermesh(iw, ih, vert)
	meshvert = {}
	for i = 1, #vert / 2 do
		i = i * 2
		local mx = vert[i - 1]
		local my = vert[i]
		meshvert[#meshvert + 1] = {mx, my, mx / iw, my / ih, 255, 255, 255}
	end
	return meshvert
end

function butcoll(x, y, text, fun)
	if x > text.x and y > text.y and x < text.x + text.w and y < text.y + text.h then
		fun()
	end
end

function but(x, y, text)
	if x > text.x and y > text.y and x < text.x + text.w and y < text.y + text.h then
		return true
	else
		return false
	end
end

function butses()
	x, y = love.mouse.getPosition()
	x = x - side
	if but(x, y, title) then
		acurs = true
	elseif but(x, y, start) then
		acurs = true
	elseif but(x, y, exit) then
		acurs = true
	else
		acurs = false
	end
end

function preeffects()
	love.graphics.translate(side, 0)
end

function aftereffects()
	love.graphics.setColor(255, 255, 255, 255)		
	love.graphics.draw(mesh, -side, 0)
	love.graphics.draw(mesh, size, 0)
	love.graphics.print(tostring(love.timer.getFPS()), -side + 5 * em, 5 * em, -0.06, 0.2, 0.2)	
	love.graphics.setColor(255, 255, 255, filltop + 25)		
	love.graphics.draw(fillter, -side, 0, 0, 5, 5)
	love.graphics.setColor(255, 255, 255, 255)
	if acurs then
		love.graphics.draw(imcursa, love.mouse.getX() - side, love.mouse.getY(), 0, 5, 5, imcursa:getWidth() / 2, imcursa:getHeight() / 2)
	else
		love.graphics.draw(imcurs, love.mouse.getX() - side, love.mouse.getY(), 0, 5, 5, imcurs:getWidth() / 2, imcurs:getHeight() / 2)
	end
end

function toup(dt)
end

function love.load()
	do -- Window
		love.window.setFullscreen(true)
		local wid, hid = love.window.getMode()
		size = hid
		side = (wid - size) / 2
		em = size / 600
		acurs = false
		love.mouse.setVisible(false)
		imcursa = love.graphics.newImage("iso/cam-a.bmp")
		imcursa:setFilter("nearest")		
		imcurs = love.graphics.newImage("iso/cam.bmp")
		imcurs:setFilter("nearest")		
	end
	do -- Draw
		background = love.graphics.newImage("iso/menu.bmp")
		background:setWrap("repeat")
		background:setFilter("nearest")
		font = love.graphics.newFont("Press_Start_2P/PressStart2P-Regular.ttf", 50)
		font:setFilter("nearest")
		do -- Title
			title = {}
			title.t = love.graphics.newText(font, "Ужасная История Бадди")
			title.rw = ((size - 20) / title.t:getWidth())
			title.rh = 1
			title.x = 10 * em
			title.y = 20 * em
			title.w = title.t:getWidth() * title.rw
			title.h = title.t:getHeight() * title.rh
		end
		do -- Start
			start = {}
			start.t = love.graphics.newText(font, "Начать снова")
			start.rw = 0.5
			start.rh = 0.5
			start.x = 300 * em
			start.y = (200 * em) + title.h
			start.w = start.t:getWidth() * start.rw
			start.h = start.t:getHeight() * start.rh
		end
		do -- Exit
			exit = {}
			exit.t = love.graphics.newText(font, "Выйти")
			exit.rw = 0.5
			exit.rh = 0.4
			exit.x = 500 * em
			exit.y = start.x + (10 * em)
			exit.w = exit.t:getWidth() * exit.rw
			exit.h = exit.t:getHeight() * exit.rh
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
		filltspeed = 0.4
		wheelpos = nil
		filltop = 180
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
end

function love.update(dt)
	time = love.timer.getTime()	
	do -- World
		World:update(dt)
	end
	do -- Fillt
		if isfillter == nil or isfillter >= filltspeed then
			fillt()
			isfillter = 0
		else
			isfillter = isfillter + dt
		end
	end
	butses()
	toup(dt)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		love.event.quit()
	end
end

function love.mousepressed(x, y, button, isTouch)
	x = x - side
	do -- Buttons
		butcoll(x, y, title, funtitle)
		butcoll(x, y, start, funstart)
		butcoll(x, y, exit, function() love.event.quit() end)
	end
end

function love.wheelmoved(x, y)
	radio(y)
end

function love.draw()
	preeffects()
	do -- Menu
		love.graphics.setColor(109, 84, 103)
		love.graphics.setFont(font)
		love.graphics.draw(title.t, title.x, title.y, 0, title.rw, title.rh)
		love.graphics.draw(start.t, start.x, start.y, 0, start.rw, start.rh)
		love.graphics.draw(exit.t, exit.x, exit.y, 0, exit.rw, exit.rh)
		-- love.graphics.draw(background, 0, 0, 0, size / background:getHeight())		
	end
	aftereffects()	
end

function funtitle()
	do -- Audio
		local a = {}
		a.main = love.audio.newSource("sou/run.ogg", "static")
		love.audio.play(a.main)
	end
end

function funstart()
	wheelpos = nil
	filltop = 100
	do -- Load message
		loadmess = love.graphics.newText(font, "Загрузка...")		
	end
	do -- Terrain
		terraimg = love.graphics.newImage("iso/cl-g.bmp")
		terraimg:setWrap("repeat")
		terraimg:setFilter("nearest")
		local iw, ih = terraimg:getDimensions()
		sw = 600 * em
		sh = 200 * em
		iw = iw * 5
		ih = ih * 5
		local vertices = vermesh(iw, ih, {0, 0, 0, sh, sw, sh, sw, 0})
		terra = love.graphics.newMesh(vertices, "fan")
		terra:setTexture(terraimg)
	end
	do -- Back
		background = love.graphics.newImage("iso/cl.bmp")
		background:setWrap("repeat")
		background:setFilter("nearest")
	end
	do -- Kate
		pfd = {0, 0, 0, 0, 0, 0}
		kate = {img = love.graphics.newImage("iso/tyan.bmp")}
		kate.w = kate.img:getWidth()
		kate.h = kate.img:getHeight()
		kate.img:setFilter("nearest")
	end
	function love.mousepressed(x, y, button, isTouch)
		x = x - side
	end
	function love.textinput(text)
	end
	function toup(dt)
	end

	function love.draw()
		preeffects()
		do -- Scene
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(background, 0, 0, 0, size / background:getHeight())
			love.graphics.draw(terra, 0, 500 * em)
			love.graphics.setColor(255 / 2, 255 / 2, 255 / 2, 255 / 3 * 2)
			love.graphics.draw(kate.img, 300 * em, 375 * em, 0, (60 * em) / kate.w, (60 * em) / kate.w, ((60 * em) / kate.w) / 2, ((60 * em) / kate.w) / 2)
		end
		aftereffects()
		love.graphics.setColor(255, 255, 255, 255 / 3)
		love.graphics.draw(loadmess, 300 * em, 200 * em, 0, 1, 1, loadmess:getWidth() / 2, loadmess:getHeight() / 2)
	end
end
