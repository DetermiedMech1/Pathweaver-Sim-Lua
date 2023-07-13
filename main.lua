function love.load()
end

function click()
  mouseTable = {
    primary = false,
    secondary = false,
    middle = false,
  }

  for i = 1, 3 do
    mouseClick = love.mouse.isDown(i)
    mouseTable[i] = mouseClick
  end

  return mouseTable
end

function love.mousemoved( x, y, dx, dy, istouch )
	mouse = {
  x = x,
  y = y,
  dx = dx, 
  dy = dy,
}
end

function love.update(dt)
  
end

function love.draw()
  width, height = love.graphics.getDimensions()
  if click()[1] then
    love.graphics.push()
    love.graphics.translate(love.mouse.getX(), love.mouse.getY())
  end

  for y = -100, 100, 1 do
    for x = -100, 100, 1 do
      graphicsX = x * 100
      graphicsY = y * 100

      love.graphics.setColor(1,1,1)

      love.graphics.print("("..graphicsX..", "..graphicsY..")", x * 100, y * 100)


      if x == y then
        love.graphics.circle("fill", x, y, 10)
      end
    end
  end

  if click()[1] then
    love.graphics.pop()
  end
end