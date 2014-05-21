Game = {}
Game.__index = Game

function Game.create()
   local temp = {}
   setmetatable(temp, Game)
   return temp
end

function Game:update(dt)
   if love.keyboard.isDown("left") then
      pos["x"] = pos["x"] - 500 * dt -- this would increment num by 100 per second
   end

   if love.keyboard.isDown("right") then
      pos["x"] = pos["x"] + 500 * dt -- this would increment num by 100 per second
   end

   if love.keyboard.isDown("up") then
      pos["y"] = pos["y"] - 500 * dt -- this would increment num by 100 per second
   end

   if love.keyboard.isDown("down") then
      pos["y"] = pos["y"] + 500 * dt -- this would increment num by 100 per second
   end
end

function Game:draw()
   love.graphics.setColor({255,255,255,255})
   --love.graphics.draw(img["bg"], love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 1, 1, 512, 256)
   love.graphics.draw(img["icon"], pos["x"]*1.2, pos["y"]*1.2)
   love.graphics.setColor(colors.text)
   love.graphics.setFont(fonts.title)
   love.graphics.print(text, pos["x"]*0.8, pos["y"]*0.8)
end