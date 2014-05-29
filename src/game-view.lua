GameView = class('GameView', View)

function GameView:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   -- player hand total value
   self.playerTotalLabel = Label:new({x = 410, y = 300, align = 'right', text = ''})
   self:addChild(self.playerTotalLabel)


   -- player hand total value
   self.dealerTotalLabel = Label:new({x = 410, y = 140, align = 'right', text = ''})
   self:addChild(self.dealerTotalLabel)

   -- bet button
   self.betButton = Button:new({ text = 'Bet 10', x = 220, y = 415 })
   self.betButton:setClickHandler(function()
      self:startRound(10)
   end)
   self:addChild(self.betButton)

   -- hit button
   self.hitButton = GameButton:new({ text = 'Hit', x = 215, y = 425, visible = false, width = 160})
   self.hitButton:setClickHandler(function()
      self:hit()
   end)
   self:addChild(self.hitButton)

   -- stand button
   self.standButton = GameButton:new({ text = 'Stand', x = 380, y = 425, visible = false, width = 140 })
   self.standButton:setClickHandler(function()
      self:stand()
   end)
   self:addChild(self.standButton)



   -- double button
   self.doubleButton = GameButton:new({ text = 'Double', x = 215, y = 370, visible = false, width = 160 })
   self.doubleButton:setClickHandler(function()
      self:double()
   end)
   self:addChild(self.doubleButton)

   -- split button
   self.splitButton = GameButton:new({ text = 'Split', x = 380, y = 370, visible = false, width = 140 })
   self.splitButton:setClickHandler(function()
      self:split()
   end)
   self:addChild(self.splitButton)


   -- surrender button
   self.surrenderButton = GameButton:new({ text = 'Surrender', x = 10, y = 425, visible = false, width = 200 })
   self.surrenderButton:setClickHandler(function()
      self:surrender()
   end)
   self:addChild(self.surrenderButton)

   -- insurance button
   self.insuranceButton = GameButton:new({ text = 'Insurance', x = 10, y = 370, visible = false, width = 200 })
   self.insuranceButton:setClickHandler(function()
      --
   end)
   self:addChild(self.insuranceButton)

   -- even money button
   self.evenMoneyButton = GameButton:new({ text = 'Even money', x = 155, y = 425, visible = false, width = 220 })
   self.evenMoneyButton:setClickHandler(function()
      --
   end)
   self:addChild(self.evenMoneyButton)

   -- dealer's cards on table
   self.dealerCards = CardGroup:new({x = 20, y = 70})
   self:addChild(self.dealerCards)

   -- player's cards on table
   self.playerCards = CardGroup:new({x = 20, y = 220})
   self:addChild(self.playerCards)

   -- menu button
   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 490, y = 6, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- game title
   local gameTitle = Title:new({x = 20, y = 1, text = 'Free play', width = 600})
   self:addChild(gameTitle)
end

function GameView:startRound(bet)
   self.currentRound = Round:new()

   self.playerCards:empty()
   self.dealerCards:empty()
   self.playerTotalLabel.text = ''
   self.dealerTotalLabel.text = ''

   self.betButton:hide()

   self.currentRound:start(10)
   self.playerCards:addCard(self.currentRound.playerCards[1], 0)
   self.playerCards:addCard(self.currentRound.playerCards[2], 0.2, function()
      self.playerTotalLabel.text = self:getPlayerTotalString()
   end)
   self.dealerCards:addCard(self.currentRound.dealerCards[1], 0.6, function()
      self.dealerTotalLabel.text = self:getDealerTotalString()
      if self.currentRound:playerHasBlackjack() then
         if self.currentRound:evenMoneyPossible() then
            self.evenMoneyButton:show()
            self.standButton:show()
         else
            self:dealerTurn(0.5)
         end
      else    
         self.hitButton:show()
         self.standButton:show()
         self.surrenderButton:show()
         if self.currentRound:playerCanDouble() then
            self.doubleButton:show()
         end
         if self.currentRound:playerCanSplit() then
            self.splitButton:show()
         end
         if self.currentRound:playerCanInsure() then
            self.insuranceButton:show()
         end
      end
   end)
end

function GameView:hit()
   self:hideGameButtons()

   self.playerCards:addCard(self.currentRound:hit(), 0, function()
      self.playerTotalLabel.text = self:getPlayerTotalString()
      if self.currentRound:playerIsBusted() or self.currentRound:playerShouldStand() then
         self:dealerTurn(0.5)
      else
         self.hitButton:show()
         self.standButton:show()
      end
   end)
end

function GameView:stand()
   self:dealerTurn()
end

function GameView:surrender()
   self:dealerTurn()
end

function GameView:double()
   self:hideGameButtons()

   self.playerCards:addCard(self.currentRound:hit(), 0, function()
      self.playerTotalLabel.text = self:getPlayerTotalString()
      self:dealerTurn(0.5)
   end)
end

function GameView:split()
   self.splitButton:hide()
end

function GameView:dealerTurn(delay)
   delay = delay or 0

   self:hideGameButtons()

   Utilities.delay(delay, function()
      self.currentRound:dealerTurn(0.6, function(card)
         self.dealerCards:addCard(card, 0, function()
            self.dealerTotalLabel.text = self:getDealerTotalString()
         end)
      end, function()
         self.betButton:show()
      end)
   end)
end

function GameView:show()
   Node.show(self)
   self:reset()
end

function GameView:reset()
   self.dealerCards:empty()
   self.playerCards:empty()

   self:hideGameButtons()
   self.betButton:show()

   self.playerTotalLabel.text = ''
   self.dealerTotalLabel.text = ''
end

function GameView:hideGameButtons()
   self.hitButton:hide()
   self.standButton:hide()
   self.doubleButton:hide()
   self.splitButton:hide()
   self.surrenderButton:hide()
   self.insuranceButton:hide()
   self.evenMoneyButton:hide()
end

-- TODO: DRY these methods
function GameView:getPlayerTotalString()
   -- drop out invalid values (>21)
   local totals = self.currentRound:getPlayerTotal()
   local minTotals = _.min(totals)
   if self.currentRound:playerHasBlackjack() then
      return 'Blackjack (21)'
   elseif minTotals <= 21 then
      return table.concat(_.select(totals, function(k, v)
         return v <= 21
      end), '/')
   else
      return 'Bust (' .. minTotals .. ')'
   end
end

function GameView:getDealerTotalString()
   -- drop out invalid values (>21)
   local totals = self.currentRound:getDealerTotal()
   local minTotals = _.min(totals)
   if self.currentRound:dealerHasBlackjack() then
      return 'Blackjack (21)'
   elseif minTotals <= 21 then
      return table.concat(_.select(totals, function(k, v)
         return v <= 21
      end), '/')
   else
      return 'Bust (' .. minTotals .. ')'
   end
end