-- Original source:
-- https://github.com/KiselevNikolayGit/PMAL

function rgbhex(hex)
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function love.PMALphysic(pmal, world, x, y, BodyType)
  object = {}
  object.b = love.physics.newBody(world, x, y, BodyType)
  object.s = love.physics.newPolygonShape(pmal.p)
  object.f = love.physics.newFixture(object.b, object.s)
  object.pmal = pmal
  return object
end

function love.PMALdraw(object)
  if object.pmal.t == "simple" then
    love.graphics.setColor(rgbhex(object.pmal.c))
    love.graphics.polygon(object.pmal.s, object.b:getWorldPoints(object.s:getPoints()))
  elseif object.pmal.t == "image" then
    scalewi = object.pmal.w / object.pmal.i:getWidth()
    scalehe = object.pmal.h / object.pmal.i:getHeight()
    love.graphics.draw(object.pmal.i, object.b:getX(), object.b:getY(), object.b:getAngle(), scalewi, scalehe, object.pmal.ox, object.pmal.oy)
  end
end

function love.PMALopen(filename)
  container = love.filesystem.load(filename)
  pmal = {container()}
  type = "unknown"
  sizew = nil
  sizeh = nil
  offsetx = nil
  offsety = nil
  image = nil
  color = nil
  points = pmal[1]
  style = pmal[2]
  if style == "fill" or style == "line" then
    color = pmal[3]
    type = "simple"
  else
    image = love.graphics.newImage(style)
    style = nil
    type = "image"
    if #pmal >= 4 then
        sizew = pmal[3]
        sizeh = pmal[4]
        if #pmal == 6 then
        offsetx = pmal[5]
        offsety = pmal[6]
        else
        offsetx = sizew / 2
        offsety = sizeh / 2
        end
    else
        sizew = image:getWidth()
        sizeh = image:getHeight()
        offsetx = sizew / 2
        offsety = sizeh / 2
    end
  end
  pmal = {}
  pmal.t = type
  print("type:    ", type)
  pmal.p = points
  print("points:  ", points)
  pmal.s = style
  print("style:   ", style)
  pmal.c = color
  print("color:   ", color)
  pmal.i = image
  print("image:   ", image)
  pmal.w = sizew
  print("sizew:   ", sizew)
  pmal.h = sizeh
  print("sizeh:   ", sizeh)
  pmal.ox = offsetx
  print("offsetx: ", offsetx)
  pmal.oy = offsety
  print("offsety: ", offsety)
  return pmal
end

return rgbhex, love.PMALdraw, love.PMALphysic, love.PMALopen