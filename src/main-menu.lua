MainMenu = class('MainMenu', View)

function MainMenu:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   -- sample label
   --mainTitle = Title:new({x = 20, y = 100, text = 'BlackJack Guru', width = 600})
   --mainMenu:addChild(mainTitle)
   local mainMenuLogo = Node:new({x = 192, y = 40, width = 256, height = 128})
   mainMenuLogo:setImage('media/images/logo.png')
   self:addChild(mainMenuLogo)

   -- sample button
   local tutorialsButton = Button:new({ text = 'Tutorials', x = 220, y = 200 })
   tutorialsButton:setClickHandler(function()
      mainMenu:hide()
      gameView:show()
   end)
   self:addChild(tutorialsButton)

   -- sample button
   local freePlayButton = Button:new({ text = 'Free play', x = 220, y = 270 })
   freePlayButton:setClickHandler(function()
      mainMenu:hide()
      gameView:show()
   end)
   self:addChild(freePlayButton)


   local quitButton = Button:new({ text = 'Quit', x = 220, y = 340 })
   quitButton:setClickHandler(love.event.quit)
   self:addChild(quitButton)
end