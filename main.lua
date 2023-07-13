local dragging = false -- Variable to track dragging state
local dragStartX, dragStartY -- Variables to store initial mouse position on drag start
local offsetX, offsetY = 0, 0 -- Variables to store accumulated offset during dragging

function love.mousepressed(x, y, button)
  if button == 1 then -- Left mouse button
    dragging = true
    dragStartX, dragStartY = x, y
  end
end

function love.mousereleased(x, y, button)
  if button == 1 then -- Left mouse button
    dragging = false
    offsetX, offsetY = offsetX + (x - dragStartX), offsetY + (y - dragStartY)
  end
end

function love.mousemoved(x, y, dx, dy)
  if dragging then
    offsetX, offsetY = offsetX + dx, offsetY + dy
  end
end

function love.draw()
  width, height = love.graphics.getDimensions()
  love.graphics.translate(offsetX, offsetY)

  for y = -50, 50, 1 do
    for x = -50, 50, 1 do
      graphicsX = x
      graphicsY = y

      love.graphics.setColor(1,1,1)
      
      love.graphics.print("("..graphicsX..", "..graphicsY..")", x*100, y*100)


      if y == x^2 then
        love.graphics.points(x, y)
      end
    end
  end

end