--game where animals fall from top player clicks
--before hit the bottom
--game ends when animal hits bottom
freeze = false
appeared = false
timer = 2000
wait = 2000

function love.load()
  chickenFace = love.graphics.newImage("chicken.png")
  backgroundImage = love.graphics.newImage("bg.png")
  snowflake = love.graphics.newImage("Snowflake.png")

  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  startx = {math.random(0, love.graphics.getWidth() - chickenFace:getWidth()), 
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),  
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),  
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()), 
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth())}
  starty = {0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2)}
    snowx = {math.random(0, love.graphics.getWidth() - snowflake:getWidth())}
    snowy = {0 - math.random(snowflake:getHeight(), snowflake:getHeight() * 2)}
end

-------------------------------------------------
--MOUSE PRESS
--1 = left, 2 = right, 3 = middle wheel
-------------------------------------------------
function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    --print("left mouse clicked")
    for i, v in ipairs(startx) do
      --if the mouse x and y is within the boundary of a chicken picture
      if x >= startx[i] and x <= startx[i] + chickenFace:getWidth() and y >= starty[i] and y <= starty[i] + chickenFace:getHeight() then
        --print("in bounds")
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        --reset its y value (go back to the top)
        starty[i] = math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2) * -1
      end
    end
    for i, v in ipairs(snowx) do
        --if the mouse x and y is within the boundary of a snowFlake picture
      if x >= snowx[i] and x <= snowy[i] + snowflake:getWidth() and y >= snowx[i] and y <= snowy[i] + snowflake:getHeight() then
        freeze = true
        appeared = false
        wait = 2000
        --print("in bounds")
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        --reset its y value (go back to the top)
        snowy[i] = math.random(snowflake:getHeight(), snowflake:getHeight() * 2) * -1
      end
    end
  end
end

-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)
  for i, v in ipairs(starty) do
    --if chicken hits the bottom of the screen, lua quits (we lose)
    if starty[i] + chickenFace:getHeight() >= love.graphics.getHeight() then
      --print("over the edge")
      love.event.quit()
    end
    --chickens move down 
    if freeze == false then
        starty[i] = starty[i] + 80 * dt
    else
    -- if freeze is activated
        if timer >= 0 then
            timer = timer - 1
        else
            timer = 2000
            freeze = false
        end
    end
  end
  --Snowflake Spawn
  if appeared == false then
    if wait >= 0 then
      wait = wait - 1
    else
      snowx = {math.random(0, love.graphics.getWidth() - snowflake:getWidth())}
      snowy = {math.random(0, love.graphics.getHeight() - snowflake:getHeight())}
      appeared = true
    end
  end
end

-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
  
  love.graphics.draw(backgroundImage, 0, 0)
  --draw each chicken at their respective x and y
  for i, v in ipairs(startx) do
    love.graphics.draw(chickenFace, startx[i], starty[i])
  end
  for i, v in ipairs(snowx) do
    love.graphics.draw(snowflake, snowx[i], snowy[i])
  end
end