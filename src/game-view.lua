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

   -- player hand total value
   self.playerTotalLabel = Label:new({x = 410, y = 300, align = 'right', text = ''})
   self:addChild(self.playerTotalLabel)


   -- player hand total value
   self.dealerTotalLabel = Label:new({x = 410, y = 140, align = 'right', text = ''})
   self:addChild(self.dealerTotalLabel)

   -- bet button
   self.betButton = Button:new({ text = 'Bet 10', x = 220, y = 400 })
   self.betButton:setClickHandler(function()
      self:startRound(10)
   end)
   self:addChild(self.betButton)

   -- hit button
   self.hitButton = Button:new({ text = 'Hit', x = 220, y = 400, visible = false })
   self.hitButton:setClickHandler(function()
      self:hit()
   end)
   self:addChild(self.hitButton)

   -- stand button
   self.standButton = Button:new({ text = 'Stand', x = 430, y = 400, visible = false })
   self.standButton:setClickHandler(function()
      self:stand()
   end)
   self:addChild(self.standButton)

   -- dealer's cards on table
   self.dealerCards = CardGroup:new({x = 20, y = 70})
   self:addChild(self.dealerCards)

   -- player's cards on table
   self.playerCards = CardGroup:new({x = 20, y = 230})
   self:addChild(self.playerCards)
end

function GameView:startRound(bet)
   self.currentRound = Round:new()

   self.playerCards:empty()
   self.dealerCards:empty()

   self.currentRound:start(10)
   for k,card in pairs(self.currentRound.playerCards) do
      self.playerCards:addCard(card)
   end
   self.dealerCards:addCard(self.currentRound.dealerCards[1])
   self.betButton:hide()
   self.hitButton:show()
   self.standButton:show()
   self.playerTotalLabel.text = self:getPlayerTotalString()
   self.dealerTotalLabel.text = self:getDealerTotalString()

   if self.currentRound:playerHasBlackjack() then
      self:dealerTurn()
   end
end

function GameView:hit()
   self.playerCards:addCard(self.currentRound:hit())
   self.playerTotalLabel.text = self:getPlayerTotalString()
   local dealerCards = nil
   -- TODO: handle this in logic component
   if self.currentRound:playerIsBusted() or self.currentRound:playerShouldStand() then
      self:dealerTurn()
   end
end

function GameView:stand()
   self:dealerTurn()
end

function GameView:dealerTurn()
   -- TODO: handle this in logic component
   dealerCards = self.currentRound:dealerTurn()
   _.each(dealerCards, function(k, card)
      self.dealerCards:addCard(card)
   end)
   self.dealerTotalLabel.text = self:getDealerTotalString()

   self.hitButton:hide()
   self.standButton:hide()
   self.betButton:show()
end

function GameView:show()
   Node.show(self)
   self:reset()
end

function GameView:reset()
   self.dealerCards:empty()
   self.playerCards:empty()
   self.betButton:show()
   self.hitButton:hide()
   self.standButton:hide()
   self.playerTotalLabel.text = ''
   self.dealerTotalLabel.text = ''
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