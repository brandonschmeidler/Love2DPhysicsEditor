local function bool_to_axis(bool)
    if (bool) then return 1 end
    return -1
end

function love.load()

    scrolling = false
    scrollX = 0
    scrollY = 0
    
    scale = 1
    scaleSpeed = 0.125

    mouseGrabX = 0
    mouseGrabY = 0

end

function love.update(dt)

    if (scrolling) then
        local mx,my = love.mouse.getPosition()
        local ww,wh = love.graphics.getDimensions()

        if (mx < 0 or mx > ww) then
            local axis = bool_to_axis(mx < 0)
            local offset = axis * ww
            mouseGrabX = mouseGrabX + offset
            love.mouse.setPosition(mx,my)
        end
        if (my < 0 or my > wh) then
            local axis = bool_to_axis(my < 0)
            local offset = axis * wh
            mouseGrabY = mouseGrabY + offset
            love.mouse.setPosition(mx,my)
        end

        scrollX = mouseGrabX - mx
        scrollY = mouseGrabY - my
    end

end

function love.draw()
    love.graphics.push()
    love.graphics.translate(-scrollX,-scrollY)
    love.graphics.scale(scale,scale)

    love.graphics.circle('fill',32,32,16)

    love.graphics.pop()



    local mx,my = love.mouse.getPosition()

    local tmx = math.floor((mx + scrollX) / scale)
    local tmy = math.floor((my + scrollY) / scale)
    local str = "RAW MOUSE: " .. tostring(mx)..","..tostring(my)
    str = str .. "\nTRANSFORMED MOUSE: " .. tostring(tmx)..","..tostring(tmy)
    love.graphics.print(str,1,1)
end

function love.mousepressed(x,y,button)
    if (button == 3) then
        print(x,y)
        scrolling = true
        mouseGrabX = x + scrollX
        mouseGrabY = y + scrollY
    end
end

function love.mousereleased(x,y,button)
    if (button == 3) then 
        scrolling = false
    end
end

function love.wheelmoved(x,y)
    print("MOUSE WHEEL: " .. tostring(y))
    scale = scale + y * scaleSpeed
end

-- function love.load()
--     loveframes = require("lib.loveframes")
-- end

-- function love.update(dt)
--     loveframes.update(dt)
-- end

-- function love.draw()
--     loveframes.draw()
-- end

-- function love.mousepressed(x,y,button)
--     loveframes.mousepressed(x,y,button)
-- end

-- function love.mousereleased(x,y,button)
--     loveframes.mousereleased(x,y,button)
-- end

-- function love.keypressed(key,unicode)
--     loveframes.keypressed(key,unicode)
-- end

-- function love.keyreleased(key)
--     loveframes.keyreleased(key)
-- end