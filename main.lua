--external dependencies
tween = require "lib/tween"
class = require "lib/middleclass"
_     = require "lib/moses"

--internal modules
require "src/node"
require "src/view"
require "src/blackjack"
require "src/hand"
require "src/utilities"
require "src/button"
require "src/menu-button"
require "src/tutorial-button"
require "src/game-button"
require "src/label"
require "src/title"
require "src/card"
require "src/card-group"
require "src/main-menu"
require "src/tutorial-menu"
require "src/tutorial-introduction"
require "src/tutorial-double"
require "src/tutorial-split"
require "src/tutorial-insurance"
require "src/tutorial-even-money"
require "src/game-view"
require "src/modal-window"
require "src/hint-box"
require "src/blackjack"


function love.load()
   love.window.setMode(640, 480, {resizable=false, fsaa=16})
   love.filesystem.setIdentity("blackjack_guru")

   -- global variable that shows if mouse has been clicked on current tick
   mouseClicked = false

   -- this is the main stage - root of all views
   stage = View:new()
   stage:setImage("media/images/green.png")

   -- main menu
   tutorialMenu = TutorialMenu:new()
   tutorialMenu:hide()
   stage:addChild(tutorialMenu)

   -- tutorial menu
   mainMenu = MainMenu:new()
   stage:addChild(mainMenu)

   -- game view
   gameView = GameView:new()
   gameView:hide()
   stage:addChild(gameView)

   currentTutorial = nil
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
   -- if key == 'a' then label:setText("The A key was pressed.") end
end

function love.draw()
   stage:draw()
   mouseClicked = false
end