local json = require("json")

local path = {}
local scale = 30.0

local accelerationScaleFactor = 10

local triangle = {
    x = 0,
    y = 0,
    acceleration = 0,
    rotation = 0,
    color = {255, 0, 0} -- Red color
}

function love.load()
    local pathData = love.filesystem.read("path1.wpilib.json")
    print(pathData.."\n".."\n".."\n")
    path = json.decode(pathData)
end

local speedScaleFactor = 2 -- Adjust this value to scale up the speed

function love.update(dt)
    local currentTime = love.timer.getTime()

    -- Find the current segment of the path based on time
    local currentSegment = 1

    for i = 1, #path - 1 do
        if currentTime >= path[i].time and currentTime < path[i + 1].time then
            currentSegment = i
            break
        end
        print(currentSegment)
    end

    local currentPoint = path[currentSegment].pose.translation
    local nextPoint = path[currentSegment + 1].pose.translation

    -- Calculate the progress within the current segment based on time
    local segmentDuration = path[currentSegment + 1].time - path[currentSegment].time
    local segmentProgress = (currentTime - path[currentSegment].time) / segmentDuration

    -- Calculate the position of the triangle using linear interpolation
    triangle.x = currentPoint.x + (nextPoint.x - currentPoint.x) * segmentProgress
    triangle.y = currentPoint.y + (nextPoint.y - currentPoint.y) * segmentProgress

    -- Set the rotation of the triangle to match the current segment's rotation
    triangle.rotation = path[currentSegment].pose.rotation.radians + math.pi
end

function love.draw()
  -- Set up your drawing settings
  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(0.5)

  -- Adjust the coordinate system
  love.graphics.translate(0, -30 + (path[#path].pose.translation.y+path[1].pose.translation.y)*scale)
  love.graphics.scale(scale, -scale)

  -- Draw the path
  for i = 1, #path - 1 do
      local currentPoint = path[i].pose.translation
      local nextPoint = path[i + 1].pose.translation

      love.graphics.line(currentPoint.x, currentPoint.y, nextPoint.x, nextPoint.y)
  end

  -- Draw the colored triangle
  ---[[
  love.graphics.push()
  love.graphics.translate(triangle.x, triangle.y)
  love.graphics.rotate(triangle.rotation+math.pi/2)
  love.graphics.setColor(triangle.color)
  love.graphics.polygon("fill", -0.25,-0.2,0.25,-0.2,0,0.3)
  love.graphics.pop()
  ---]]
end
