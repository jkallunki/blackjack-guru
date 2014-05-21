--external dependencies
tween = require "lib/tween"
class = require "lib/middleclass"
_     = require "lib/moses"

--internal modules
require "src/node"
require "src/stage"
require "src/view"
require "src/blackjack"
require "src/utilities"
require "src/button"
require "src/label"

function love.load()
   love.window.setMode(640, 480, {resizable=false, fsaa=16})

   fonts =  {  title = love.graphics.newFont("media/fonts/blanch.otf", 60) }

   -- Utilities.delay(0.5, function()
   --    loadTween = tween(1, pos, {x = 300, y = 300}, 'linear', function()
   --       Utilities.delay(0.2, function()
   --          loadTween2 = tween(1, pos, {x = 200, y = 300}, 'linear')
   --       end)
   --    end)
   -- end)

   mouseClicked = false

   -- this is the main stage - root of all views
   stage = View:new()

   -- main menu
   mainMenu = View:new()
   mainMenu:setImage("media/images/green.png")

   label = Label:new({y = 100})
   mainMenu:addChild(label)

   button = Button:new({  text = 'Test',
                          x = 10,
                          y = 10 })
   button:setClickHandler(function()
      label:setText('Button was clicked')
   end)
   mainMenu:addChild(button)


   stage:addChild(mainMenu)

end

function love.update(dt)
   tween.update(dt)
   Utilities.update(dt)
   stage:update()
end

function love.mousepressed(mx, my, button)
   if button == 'l' then
      mouseClicked = true
   end
end

function love.keypressed(key, unicode)
   if key == 'b' then
      label:setText("The B key was pressed.")
   elseif key == 'a' then
      label:setText("The A key was pressed.")
   end
end

function love.draw()
   stage:draw()
   mouseClicked = false
end