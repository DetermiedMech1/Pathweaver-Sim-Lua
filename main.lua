
  local dragging = false -- Variable to track dragging state
  local text = false
  local dragStartX, dragStartY -- Variables to store initial mouse position on drag start
  local offsetX, offsetY = 0, 0 -- Variables to store accumulated offset during dragging

function love.load()
  Scale = 100
end

function love.mousepressed(x, y, button)
  if button == 1 then -- Left mouse button
    dragging = true  
  elseif button == 3 then
    Scale = 100
  end
end

function love.mousereleased(x, y, button)
  if button == 1 then -- Left mouse button
    dragging = false
  elseif button == 2 then
    text = not text
  end
end

function love.mousemoved(x, y, dx, dy)
  if dragging then
    offsetX, offsetY = offsetX + dx, offsetY + dy
  end
end

function love.wheelmoved(x, y)
  if y > 0 and Scale < 100 then
    Scale = (Scale + 10)
  elseif y < 0 and Scale > 10 then
    Scale = (Scale - 10)
  end
end

function love.draw()
  coords = {}
  width, height = love.graphics.getDimensions()
  love.graphics.translate(offsetX, offsetY)
  love.graphics.scale(Scale, -Scale)
  love.graphics.print("Scale = "..Scale, 1, 1, 0, 1*(Scale^-1), -1*(Scale^-1))

  for y = -50, 50, 1 do
    for x = -50, 50, 1 do

      love.graphics.setColor(1,1,1)
      if text then
        love.graphics.print("("..x..", "..y..")", x, y, 0, 1*(Scale^-1), -1*(Scale^-1))
      end
      
      for i = 0, 10, 0.1 do
          if y+i == (x+i)^2 then
            love.graphics.circle("fill", x+i, y+i, 10*(Scale^-1))
          end
      end

    end
  end
end