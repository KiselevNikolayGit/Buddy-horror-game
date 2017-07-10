-- rgbhex(hex)
-- love.PMALphysic(pmal, world, x, y, BodyType)
-- love.PMALdraw(object)
-- love.PMALopen(filename)

-- МЕНЮ --
function love.load()
	love.window.setFullscreen(true)
	w, h = love.window.getMode()
	pw = w / 100
	ph = h / 100
	-- PMAL развертывание --
	rgbhex, love.PMALdraw, love.PMALphysic, love.PMALopen = love.filesystem.load("pmal.lua")()
	leaveS = love.PMALopen("leaves/leaveS.pmal")
	-- Физика --
	world = love.physics.newWorld(0, 4, true)
	leave = {}
	leave[1] = love.PMALphysic(leaveS, world, 0, 0, "dynamic")
	-- Графика --
	fontl = love.graphics.newFont("Kurale/Kurale-Regular.ttf", math.floor(w / 9))
	fonts = love.graphics.newFont("Kurale/Kurale-Regular.ttf", math.floor(w / 18))
	love.graphics.setBackgroundColor(rgbhex("#D7D6DC"))
		-- Текст меню --
		menu = {}
		menu.logo = love.graphics.newText(fontl, "Логотип")
		menu.start = love.graphics.newText(fonts, "Начало")
		menu.options = love.graphics.newText(fonts, "Опции")
		menu.exit = love.graphics.newText(fonts, "Выход")
end
function love.update(dt)
	world:update(dt)
	-- Проверка гибкости интерфейса --
	if love.keyboard.isDown("g") then
		w, h = love.window.getMode()
		love.window.setMode(w, h, {resizable=true, vsync=true, minwidth=90, minheight=180})
		pw = w / 100
		ph = h / 100
		fontl = love.graphics.newFont("Kurale/Kurale-Regular.ttf", math.floor(w / 9))
		fonts = love.graphics.newFont("Kurale/Kurale-Regular.ttf", math.floor(w / 18))
	end
	-- Экстренное завершение работы --
	if love.keyboard.isDown("p") then
		os.exit()
	end
end
function love.draw()
	-- Листья --
	love.PMALdraw(leave[1])
	-- Логотип --
	love.graphics.setColor(rgbhex("#A54438"))
	love.graphics.draw(menu.logo, pw * 5, ph * 5)
	-- Клавиши --
	love.graphics.setColor(rgbhex("#BC6D43"))
	love.graphics.draw(menu.start, pw * 10, ph * 35)
	love.graphics.draw(menu.options, pw * 10, ph * 50)
	love.graphics.draw(menu.exit, pw * 10, ph * 65)
end