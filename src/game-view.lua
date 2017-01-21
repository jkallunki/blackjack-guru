GameView = class('GameView', View)

function GameView:initialize()
   self.defaults = {width = love.graphics.getWidth(), height = love.graphics.getHeight()}
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

   -- end tutorial button
   self.endTutorialButton = Button:new({ text = 'End tutorial', x = 220, y = 415, visible = false })
   self.endTutorialButton:setClickHandler(function()
      self:hide()
      tutorialMenu:show()
   end)
   self:addChild(self.endTutorialButton)

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
      self:insurance()
   end)
   self:addChild(self.insuranceButton)

   -- even money button
   self.evenMoneyButton = GameButton:new({ text = 'Even money', x = 135, y = 425, visible = false, width = 220 })
   self.evenMoneyButton:setClickHandler(function()
      self:evenMoney()
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

   -- reference to the card group that is currently being played (switch on split)
   self.currentPlayerCards = self.playerCards

   -- menu button
   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 502, y = 5, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- game title
   self.gameTitle = Title:new({x = 20, y = 0, text = 'Free play', width = 600})
   self:addChild(self.gameTitle)

   -- audio
   self.audio = {
      win = love.audio.newSource("media/audio/reward.mp3", "static"),
      lose = love.audio.newSource("media/audio/fail.mp3", "static")
   }

   -- hint-box
   self.hintBox = HintBox:new()
   self:addChild(self.hintBox)


   -- modal
   self.modalWindow = ModalWindow:new()
   self.modalWindow:hide()
   self:addChild(self.modalWindow)

end

function GameView:startRound(bet)

   if currentTutorial ~= nil and currentTutorial.onStartRound ~= nil then
      currentTutorial:onStartRound()
   end

   self.modalWindow:hide()

   self.currentRound = Round:new()

   self.playerCards:empty()
   self.playerCards2:empty()
   self.playerCards2.x = 20
   self.currentPlayerCards = self.playerCards

   self.dealerCards:empty()
   self.playerCards:setTotal('')
   self.dealerCards:setTotal('')

   self.playerCards2:setTotal('')
   self.playerCards2.nameLabel.text = ''

   self.roundResultLabel:hide()
   self.betButton:hide()

   self.currentRound:start(bet)
   self:removeCredits(bet)

   self.playerCards:addCard(self.currentRound.playerHand.cards[1], 0)
   self.playerCards:addCard(self.currentRound.playerHand.cards[2], 0.2, function()
      self.playerCards:setTotal(self:getPlayerTotalString())
   end)
   self.dealerCards:addCard(self.currentRound.dealerHand.cards[1], 0.6, function()
      self.dealerCards:setTotal(self:getDealerTotalString())

      if currentTutorial ~= nil and currentTutorial.onAfterStartRound ~= nil then
         currentTutorial:onAfterStartRound()
      end

      if self.currentRound:playerHasBlackjack() then
         if self.currentRound:evenMoneyPossible() then
            self.evenMoneyButton:show()
            self.standButton:show()
         else
            self:finishHand(0.5)
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

   if currentTutorial ~= nil and currentTutorial.onHit ~= nil then
      currentTutorial:onHit()
   end

   self:hideGameButtons()
   self.currentPlayerCards:addCard(self.currentRound:hit(), 0, function()

      if currentTutorial ~= nil and currentTutorial.onAfterHit ~= nil then
         currentTutorial:onAfterHit()
      end

      self.currentPlayerCards:setTotal(self:getPlayerTotalString())
      if self.currentRound:playerIsBusted() or self.currentRound:playerShouldStand() then
         if self.currentRound:playerIsBusted() then
            self.audio.lose:play()
         end
         self:finishHand(0.5)
      else
         self.hitButton:show()
         self.standButton:show()
         if self.currentRound:playerCanDouble() then
            self.doubleButton:show()
         end
      end
   end)
end

function GameView:stand()
   if currentTutorial ~= nil and currentTutorial.onStand ~= nil then
      currentTutorial:onStand()
   end

   self:hideGameButtons()
   self:finishHand()
end

function GameView:insurance()
   if currentTutorial ~= nil and currentTutorial.onInsurance ~= nil then
      currentTutorial:onInsurance()
   end

   self:removeCredits(5)
   self.insuranceButton:hide()
   self.currentRound:setInsurance()
end

function GameView:evenMoney()
   if currentTutorial ~= nil and currentTutorial.onEvenMoney ~= nil then
      currentTutorial:onEvenMoney()
   end

   self.evenMoneyButton:hide()
   self.currentRound:setEvenMoney()
   self:stand()
end

function GameView:surrender()
   if currentTutorial ~= nil and currentTutorial.onSurrender ~= nil then
      currentTutorial:onSurrender()
   end

   self.currentRound:surrender()
   self:finishHand()
end

function GameView:finishHand(dealerTurnDelay)
   if currentTutorial ~= nil and currentTutorial.onFinishHand ~= nil then
      currentTutorial:onFinishHand()
   end

   dealerTurnDelay = dealerTurnDelay or 0
   if self.currentRound:playerHasNextHand() then
      self.nextHandDelayRef = Utilities.delay(0.5, function()

         if currentTutorial ~= nil and currentTutorial.onNextHand ~= nil then
            currentTutorial:onNextHand()
         end

         self.currentPlayerCards = self.playerCards2
         self.playerCards:setDim(true)
         self.playerCards2:setDim(false)
         self.playerCards2.nameLabel.text = 'You'
         self.currentRound:playNextHand()
         local tempX = self.playerCards.cardAmount * 27 + 175
         self.finishTween = tween(0.4, self.playerCards2, {x = tempX}, 'outCirc', function()
            self:hit()
         end)
      end)
   else
      self.playerCards:setDim(false)
      self.playerCards2:setDim(false)
      self:dealerTurn(dealerTurnDelay)
   end
end

function GameView:double()
   if currentTutorial ~= nil and currentTutorial.onDouble ~= nil then
      currentTutorial:onDouble()
   end

   self:hideGameButtons()
   self:removeCredits(10)
   self.currentRound.playerHand.bet = self.currentRound.playerHand.bet + 10
   self.currentPlayerCards:addCard(self.currentRound:double(), 0, function()
      if self.currentRound:playerIsBusted() then
         self.audio.lose:play()
      end
      self.currentPlayerCards:setTotal(self:getPlayerTotalString())
      self:finishHand(0.5)
   end)
end

function GameView:split()
   if currentTutorial ~= nil and currentTutorial.onSplit ~= nil then
      currentTutorial:onSplit()
   end

   self:hideGameButtons()
   self.currentRound:split()
   self:removeCredits(10)
   local splitCard = self.playerCards:pop()
   splitCard.x = 0
   self.playerCards2:push(splitCard)
   self.playerCards2:setDim(true)
   self.playerCards:setTotal(self:getPlayerTotalString())
   --self.currentPlayerCards = self.playerCards2
   self.splitTween = tween(0.4, self.playerCards2, {x = 520}, 'outCirc', function()
      self:hit()
   end)
end

function GameView:dealerTurn(delay)
   if currentTutorial ~= nil and currentTutorial.onDealerTurn ~= nil then
      currentTutorial:onDealerTurn()
   end

   delay = delay or 0
   self:hideGameButtons()
   self.dealerTurnDelayRef = Utilities.delay(delay, function()
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

         if currentTutorial ~= nil and currentTutorial.onRoundResult ~= nil then
            currentTutorial:onRoundResult(winnings)
         end
      end)
   end)
end

function GameView:show()
   Node.show(self)
   if currentTutorial ~= nil and currentTutorial.intro ~= nil then
      self.modalWindow:show()
      self.modalWindow.text = currentTutorial.intro
   else
      self.modalWindow:hide()
   end
   if currentTutorial ~= nil and currentTutorial.isFreePlay then
      self.hintBox.height = 45
   else
      self.hintBox.height = 140
   end
   self:reset()
end

function GameView:hide()
   Node.hide(self)
   self:reset()
end


function GameView:reset()
   if self.currentRound ~= nil then
      self.currentRound:stop()
   end

   Utilities.cancelDelay(self.nextHandDelayRef)
   Utilities.cancelDelay(self.dealerTurnDelayRef)

   tween.stop(self.splitTween)
   tween.stop(self.finishTween)
   tween.reset(self.splitTween)
   tween.reset(self.finishTween)

   self.credits = 10000

   self.dealerCards:empty()
   self.playerCards:empty()
   self.playerCards2.x = 20
   self.playerCards2:empty()

   self:hideGameButtons()
   self.betButton:show()
   self.endTutorialButton:hide()

   self.playerCards:setTotal('')
   self.playerCards2:setTotal('')
   self.dealerCards:setTotal('')

   self.roundResultLabel.text = ''
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

function GameView:showHint(text)
   if text == '' then
      self.hintBox:hide()
   else
      self.hintBox.text = text
      self.hintBox:show()
   end
end