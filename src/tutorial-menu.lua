TutorialMenu = class('TutorialMenu', View)

function TutorialMenu:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 502, y = 5, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- tutorials title
   local tutorialsTitle = Title:new({x = 20, y = 0, text = 'Tutorials', width = 600})
   self:addChild(tutorialsTitle)

   -- tutorial launch buttons
   self.tutorialButton1 = TutorialButton:new('1. Introduction', 90)
   self.tutorialButton1:setClickHandler(function()
      currentTutorial = TutorialIntroduction:new()
      gameView:show()
      gameView.gameTitle.text = '1. Introduction'
      self:hide()
   end)
   self:addChild(self.tutorialButton1)

   self.tutorialButton2 = TutorialButton:new('2. Double', 150)
   self.tutorialButton2:setClickHandler(function()
      currentTutorial = TutorialDouble:new()
      gameView:show()
      gameView.gameTitle.text = '2. Double'
      self:hide()
   end)
   self:addChild(self.tutorialButton2)

   self.tutorialButton3 = TutorialButton:new('3. Split', 210)
   self.tutorialButton3:setClickHandler(function()
      currentTutorial = TutorialSplit:new()
      gameView:show()
      gameView.gameTitle.text = '3. Split'
      self:hide()
   end)
   self:addChild(self.tutorialButton3)

   self.tutorialButton4 = TutorialButton:new('4. Surrender', 270)
   self.tutorialButton4:setClickHandler(function()
      gameView:show()
      gameView.gameTitle.text = '4. Surrender'
      self:hide()
   end)
   self:addChild(self.tutorialButton4)

   self.tutorialButton5 = TutorialButton:new('5. Insurance', 330)
   self.tutorialButton5:setClickHandler(function()
      gameView:show()
      gameView.gameTitle.text = '5. Insurance'
      self:hide()
   end)
   self:addChild(self.tutorialButton5)

   self.tutorialButton6 = TutorialButton:new('6. Even money', 390)
   self.tutorialButton6:setClickHandler(function()
      gameView:show()
      gameView.gameTitle.text = '6. Even money'
      self:hide()
   end)
   self:addChild(self.tutorialButton6)

end