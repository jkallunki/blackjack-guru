GameView = class('GameView', View)

function GameView:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   self.credits = 10000

   self.creditsTitleLabel = Label:new({x = 500, y = 377, align = 'right', text = 'Credits:', width = 130, color = {239,225,153,255}})
   self:addChild(self.creditsTitleLabel)

   self.creditsLabel = Title:new({x = 503, y = 402, align = 'right', text = '', width = 130, color = {239,225,153,255}})
   self:addChild(self.creditsLabel)

   self.roundResultLabel = Label:new({x = 20, y = 377, width = 600, visible = false, align = 'center', text = ''})
   self:addChild(self.roundResultLabel)

   -- bet button
   self.betButton = Button:new({ text = 'Bet 10', x = 220, y = 415 })
   self.betButton:setClickHandler(function()
      self:startRound(10)
   end)
   self:addChild(self.betButton)

   -- hit button
   self.hitButton = GameButton:new({ text = 'Hit', x = 195, y = 425, visible = false, width = 160})
   self.hitButton:setClickHandler(function()
      self:hit()
   end)
   self:addChild(self.hitButton)

   -- stand button
   self.standButton = GameButton:new({ text = 'Stand', x = 360, y = 425, visible = false, width = 140 })
   self.standButton:setClickHandler(function()
      self:stand()
   end)
   self:addChild(self.standButton)

   -- double button
   self.doubleButton = GameButton:new({ text = 'Double', x = 195, y = 370, visible = false, width = 160 })
   self.doubleButton:setClickHandler(function()
      self:double()
   end)
   self:addChild(self.doubleButton)

   -- split button
   self.splitButton = GameButton:new({ text = 'Split', x = 360, y = 370, visible = false, width = 140 })
   self.splitButton:setClickHandler(function()
      self:split()
   end)
   self:addChild(self.splitButton)


   -- surrender button
   self.surrenderButton = GameButton:new({ text = 'Surrender', x = 10, y = 425, visible = false, width = 180 })
   self.surrenderButton:setClickHandler(function()
      self:surrender()
   end)
   self:addChild(self.surrenderButton)

   -- insurance button
   self.insuranceButton = GameButton:new({ text = 'Insurance', x = 10, y = 370, visible = false, width = 180 })
   self.insuranceButton:setClickHandler(function()
      self:removeCredits(5)
      self.insuranceButton:hide()
      self.currentRound:setInsurance()
   end)
   self:addChild(self.insuranceButton)

   -- even money button
   self.evenMoneyButton = GameButton:new({ text = 'Even money', x = 135, y = 425, visible = false, width = 220 })
   self.evenMoneyButton:setClickHandler(function()
      self:removeCredits(5)
      self.evenMoneyButton:hide()
      self.currentRound:setInsurance()
      self:stand()
   end)
   self:addChild(self.evenMoneyButton)

   -- dealer's cards on table
   self.dealerCards = CardGroup:new({x = 20, y = 75})
   self.dealerCards.nameLabel.text = 'Dealer'
   self:addChild(self.dealerCards)

   -- player's cards on table
   self.playerCards = CardGroup:new({x = 20, y = 220})
   self.playerCards.nameLabel.text = 'You'
   self:addChild(self.playerCards)

   -- second group for split hands
   self.playerCards2 = CardGroup:new({x = 20, y = 220})
   self.playerCards2.nameLabel.text = ''
   self:addChild(self.playerCards2)

   -- menu button
   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 502, y = 5, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- game title
   local gameTitle = Title:new({x = 20, y = 0, text = 'Free play', width = 600})
   self:addChild(gameTitle)

   -- audio
   self.audio = {
      win = love.audio.newSource("media/audio/reward.mp3", "static"),
      lose = love.audio.newSource("media/audio/fail.mp3", "static")
   }
end

function GameView:startRound(bet)
   self.currentRound = Round:new()

   self.playerCards:empty()
   self.playerCards2:empty()
   self.playerCards2.x = 20
   self.dealerCards:empty()
   self.playerCards:setTotal('')
   self.dealerCards:setTotal('')

   self.roundResultLabel:hide()
   self.betButton:hide()

   self.currentRound:start(bet)
   self:removeCredits(bet)

   self.playerCards:addCard(self.currentRound.playerCards[1], 0)
   self.playerCards:addCard(self.currentRound.playerCards[2], 0.2, function()
      self.playerCards:setTotal(self:getPlayerTotalString())
   end)
   self.dealerCards:addCard(self.currentRound.dealerCards[1], 0.6, function()
      self.dealerCards:setTotal(self:getDealerTotalString())
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
      self.playerCards:setTotal(self:getPlayerTotalString())
      if self.currentRound:playerIsBusted() or self.currentRound:playerShouldStand() then
         if self.currentRound:playerIsBusted() then
            self.audio.lose:play()
         end
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
   self:removeCredits(10)
   self.currentRound.bet = self.currentRound.bet + 10
   self.playerCards:addCard(self.currentRound:double(), 0, function()
      if self.currentRound:playerIsBusted() then
         self.audio.lose:play()
      end
      self.playerCards:setTotal(self:getPlayerTotalString())
      self:dealerTurn(0.5)
   end)
end

function GameView:split()
   self.splitButton:hide()
   self.currentRound:split()
   self.playerCards2:push(self.playerCards:pop())
   self.playerCards:setTotal(self:getPlayerTotalString())
   local splitTween = tween(0.4, self.playerCards2, {x = 490}, 'outCirc', function()
      self:hit()
   end)
end

function GameView:dealerTurn(delay)
   delay = delay or 0
   self:hideGameButtons()
   Utilities.delay(delay, function()
      self.currentRound:dealerTurn(0.6, function(card)
         self.dealerCards:addCard(card, 0, function()
            self.dealerCards:setTotal(self:getDealerTotalString())
         end)
      end, function()
         local winnings = self.currentRound:getWinnings()
         self:addCredits(winnings)
         if winnings > 0 then
            self.roundResultLabel.text = 'You won ' .. winnings .. ' credits!'
            self.audio.win:play()
         else
            self.roundResultLabel.text = 'You lost.'
            self.audio.lose:play()
         end
         self.roundResultLabel:show()
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
   self.playerCards2.x = 20
   self.playerCards2:empty()

   self:hideGameButtons()
   self.betButton:show()

   self.playerCards:setTotal('')
   self.dealerCards:setTotal('')
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
      return '21 - Blackjack'
   elseif minTotals <= 21 then
      return table.concat(_.select(totals, function(k, v)
         return v <= 21
      end), '/')
   else
      return minTotals .. ' - Bust'
   end
end

function GameView:getDealerTotalString()
   -- drop out invalid values (>21)
   local totals = self.currentRound:getDealerTotal()
   local minTotals = _.min(totals)
   if self.currentRound:dealerHasBlackjack() then
      return '21 - Blackjack'
   elseif minTotals <= 21 then
      return table.concat(_.select(totals, function(k, v)
         return v <= 21
      end), '/')
   else
      return minTotals .. ' - Bust'
   end
end

function GameView:draw()
   if self:isVisible() then
      love.graphics.setColor({255,255,255,16})
      love.graphics.rectangle("fill", 0, 0, 640, 70)
      love.graphics.rectangle("fill", 0, 365, 640, 115)
   end
   View.draw(self)
end

function GameView:update()
   View.update(self)
   self.creditsLabel.text = self.credits
end

function GameView:removeCredits(amount)
   self.credits = self.credits - amount
end

function GameView:addCredits(amount)
   self.credits = self.credits + amount
end