--external dependencies
tween = require "lib/tween"
class = require "lib/middleclass"
_     = require "lib/moses"

--internal modules
require "src/node"
require "src/view"
require "src/blackjack"
require "src/utilities"
require "src/button"
require "src/label"
require "src/title"
require "src/card"

function love.load()
   love.window.setMode(640, 480, {resizable=false, fsaa=16})

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
   stage:setImage("media/images/green.png")

   -- main menu
   mainMenu = View:new()

   -- sample label
   mainTitle = Title:new({x = 20, y = 100, text = 'BlackJack Guru', width = 600})
   mainMenu:addChild(mainTitle)

   -- sample button
   tutorialsButton = Button:new({ text = 'Tutorials', x = 220, y = 200 })
   tutorialsButton:setClickHandler(function()
      mainMenu:hide()
      gameView:show()
   end)
   mainMenu:addChild(tutorialsButton)

   -- sample button
   freePlayButton = Button:new({ text = 'Free play', x = 220, y = 270 })
   freePlayButton:setClickHandler(function()
      mainMenu:hide()
      gameView:show()
   end)
   mainMenu:addChild(freePlayButton)


   quitButton = Button:new({ text = 'Quit', x = 220, y = 340 })
   quitButton:setClickHandler(love.event.quit)
   mainMenu:addChild(quitButton)

   stage:addChild(mainMenu)


   -- game view
   gameView = View:new()
   gameView:hide()
   button2 = Button:new({ text = 'Back to menu',
                          x = 10,
                          y = 10 })
   button2:setClickHandler(function()
      mainMenu:show()
      gameView:hide()
   end)
   gameView:addChild(button2)

   -- sample label
   label2 = Label:new({x = 210, y = 300, text = 'Playing...'})
   gameView:addChild(label2)

   card = Card:new({x = 50, y = 100, suit = 'spades', value = 'Q'})
   gameView:addChild(card)

   card = Card:new({x = 195, y = 100, suit = 'hearts', value = '10'})
   gameView:addChild(card)

   card = Card:new({x = 345, y = 100, suit = 'clubs', value = 'J'})
   gameView:addChild(card)

   card = Card:new({x = 490, y = 100, suit = 'diamonds', value = 'A'})
   gameView:addChild(card)

   stage:addChild(gameView)

end

function love.update(dt)
   stage:beforeUpdate()

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
   -- if key == 'b' then
   --    label:setText("The B key was pressed.")
   -- elseif key == 'a' then
   --    label:setText("The A key was pressed.")
   -- end
end

function love.draw()
   stage:draw()
   mouseClicked = false
end