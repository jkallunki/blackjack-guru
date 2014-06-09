MainMenu = class('MainMenu', View)

function MainMenu:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   -- main logo
   local mainMenuLogo = Node:new({x = 192, y = 40, width = 256, height = 128})
   mainMenuLogo:setImage('media/images/logo.png')
   self:addChild(mainMenuLogo)

   -- tutorials button
   local tutorialsButton = Button:new({ text = 'Tutorials', x = 220, y = 200 })
   tutorialsButton:setClickHandler(function()
      self:hide()
      tutorialMenu:show()
   end)
   self:addChild(tutorialsButton)

   -- free play button
   local freePlayButton = Button:new({ text = 'Free play', x = 220, y = 270 })
   freePlayButton:setClickHandler(function()
      self:hide()
      currentTutorial = nil
      gameView.gameTitle.text = 'Free play'
      gameView:show()
   end)
   self:addChild(freePlayButton)

   -- quit button
   local quitButton = Button:new({ text = 'Quit', x = 220, y = 340 })
   quitButton:setClickHandler(love.event.quit)
   self:addChild(quitButton)

   -- credits
   local creditLabel = Label:new({width = 600, x = 20, y = 440, text = 'BlackJack Guru v1.0.0 by Janne Kallunki'})
   creditLabel.color = {75,118,102,255}
   creditLabel.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 16)
   self:addChild(creditLabel)

   -- cards
   local card1 = Card:new({x = -110, y = 60, suit = 'spades', value = 'J'})
   self:addChild(card1)
   Utilities.delay(0.3, function()
      loadTween = tween(0.6, card1, {x = 10, angle = 0.4}, 'outCirc', function()
         --
      end)
   end)

   local card2 = Card:new({x = -110, y = 100, suit = 'hearts', value = 'A'})
   self:addChild(card2)
   Utilities.delay(0.6, function()
      loadTween = tween(0.6, card2, {x = 30, angle = 0.8}, 'outCirc', function()
         --
      end)
   end)

   local card3 = Card:new({x = 650, y = 100, suit = 'diamonds', value = 'A'})
   self:addChild(card3)
   Utilities.delay(0.9, function()
      loadTween = tween(0.6, card3, {x = 510, angle = -0.8}, 'outCirc', function()
         --
      end)
   end)

   local card4 = Card:new({x = 650, y = 60, suit = 'clubs', value = 'J'})
   self:addChild(card4)
   Utilities.delay(1.2, function()
      loadTween = tween(0.6, card4, {x = 530, angle = -0.4}, 'outCirc', function()
         --
      end)
   end)


end