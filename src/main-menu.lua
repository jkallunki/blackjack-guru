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
      gameView:show()
   end)
   self:addChild(freePlayButton)

   -- quit button
   local quitButton = Button:new({ text = 'Quit', x = 220, y = 340 })
   quitButton:setClickHandler(love.event.quit)
   self:addChild(quitButton)
end