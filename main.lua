--external dependencies
tween = require "lib/tween"
require "lib/middleclass"

--internal modules
require "src/node"
require "src/view"
require "src/states"
require "src/blackjack"
require "src/utilities"
require "src/button"

function love.load()
   --image = love.graphics.newImage("cake.jpg")
   pos =    {   x = 200,
                y = 200 }

   text = "Hello World!"
   --love.graphics.setBackgroundColor(255,255,255)

   fonts =  {  title = love.graphics.newFont("media/fonts/blanch.otf", 60),
               button = love.graphics.newFont("media/fonts/nunitolight.ttf", 28) }

   img =    {  bg = love.graphics.newImage("media/images/green.png"),
               icon = love.graphics.newImage("media/images/icon.png") }

   colors = {  text = {255,255,255,255} }

   love.graphics.setFont(fonts["title"])
   love.graphics.setColor(colors["text"])

   game = Game.create()

   Utilities.delay(0.5, function()
      loadTween = tween(1, pos, {x = 300, y = 300}, 'linear', function()
         Utilities.delay(0.2, function()
            loadTween2 = tween(1, pos, {x = 200, y = 300}, 'linear')
         end)
      end)
   end)

   mouseClicked = false

   button = Button.create({   text = 'Test',
                              x = 10,
                              y = 10 })

end

function love.update(dt)
   tween.update(dt)
   Game:update(dt)
   Utilities.update(dt)
   button:update()
end

function love.mousepressed(mx, my, button)
   -- if button == 'l' then
   --    tween.stop(xTween)
   --    tween.stop(yTween)
   --    xTween = tween(1, pos, {x = mx}, 'outElastic')
   --    yTween = tween(1, pos, {y = my}, 'outElastic')
   -- end
end

function love.mousereleased(mx, my, button)
   if button == 'l' then
      mouseClicked = true
   end
end

function love.keypressed(key, unicode)
   if key == 'b' then
      text = "The B key was pressed."
   elseif key == 'a' then
      text = "The A key was pressed."
   end
end

function love.focus(f)
  if not f then
    text = "Lost focus"
  else
    text = "Gained focus"
  end
end

function love.draw()
   game.draw()
   button:draw()
   mouseClicked = false
end