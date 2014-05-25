GameView = class('GameView', View)

function GameView:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 490, y = 6, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- game title
   local gameTitle = Title:new({x = 20, y = 1, text = 'Free play', width = 600})
   self:addChild(gameTitle)

   -- sample label
   -- local label2 = Label:new({x = 210, y = 300, text = 'Playing...'})
   -- self:addChild(label2)

   self.currentRound = Round:new()

   -- bet button
   self.betButton = Button:new({ text = 'Bet 10', x = 220, y = 400 })
   self.betButton:setClickHandler(function()
      self:startRound(10)
   end)
   self:addChild(self.betButton)

   -- bet button
   self.hitButton = Button:new({ text = 'Hit', x = 220, y = 400, visible = false })
   self.hitButton:setClickHandler(function()
      self:hit()
   end)
   self:addChild(self.hitButton)


   -- dealer's cards on table
   self.dealerCards = CardGroup:new({x = 20, y = 70})
   self:addChild(self.dealerCards)

   -- player's cards on table
   self.playerCards = CardGroup:new({x = 20, y = 230})
   self:addChild(self.playerCards)
end

function GameView:startRound(bet)
   self.currentRound:start(10)
   for k,card in pairs(self.currentRound.playerCards) do
      self.playerCards:addCard(card)
   end
   self.dealerCards:addCard(self.currentRound.dealerCards[1])
   self.betButton:hide()
   self.hitButton:show()
end

function GameView:hit()
   self.playerCards:addCard(self.currentRound:hit())
end

function GameView:show()
   Node.show(self)
   self.currentRound = Round:new()
   self.dealerCards:empty()
   self.playerCards:empty()
   self.betButton:show()
   self.hitButton:hide()
end
