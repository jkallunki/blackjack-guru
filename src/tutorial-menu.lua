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
      gameView:show()
      gameView.gameTitle.text = '1. Introduction'
      self:hide()
      modalWindow:show()
      modalWindow.text = [[
         Blackjack is a card game where players compete against the dealer. Player's aim is to achieve a hand value that is closer to 21 than the dealer's without going over. Going over 21 is called "busting" and getting 21 with the first two cards is called "blackjack". The player also wins if the dealer busts and the player does not, or if the player gets blackjack and the dealer does not. If the player and the dealer have hands with same values, the game is a tie (also called "push") and the player gets his initial bet back.

         Face cards (K, Q and J) are counted as ten points. An ace can be counted as 1 point or 11 points. Other cards are counted as their numeric values.
      
         After the initial bet is set, the players are dealt two cards and the dealer gets one. For simplicity, we use 10 credits as an initial bet for each round in this tutorial.

         You can now start by betting 10 credits.
      ]]
   end)
   self:addChild(self.tutorialButton1)

   self.tutorialButton2 = TutorialButton:new('2. Double', 150)
   self.tutorialButton2:setClickHandler(function()
      gameView:show()
      gameView.gameTitle.text = '2. Double'
      self:hide()
   end)
   self:addChild(self.tutorialButton2)

   self.tutorialButton3 = TutorialButton:new('3. Split', 210)
   self.tutorialButton3:setClickHandler(function()
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