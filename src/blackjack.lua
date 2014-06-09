-- HELPER METHODS

-- generate array containing all 52 cards (not shuffled!)
function generateDeck()
   local suits = {'hearts', 'spades', 'diamonds', 'clubs' }
   local values = {2,3,4,5,6,7,8,9,10,'J','Q','K','A'}
   return _.flatten(_.map(suits, function(sk,sv)
      return _.map(values, function(vk, vv)
         return {suit = sv, value = vv}
      end)
   end), true)
end

-- get real numeric value of a card
-- ('A' == 11 if aceHigh == true, otherwise 'A' == 1)
function cardValue(cardOrValue, aceHigh)
   aceHigh = aceHigh or false
   value = (type(cardOrValue) == 'table') and cardOrValue.value or cardOrValue
   if value == 'A' then
      value = aceHigh and 11 or 1
   else
      value = _.detect({'J','Q','K'}, value) and 10 or value
   end
   return value
end

-- SINGLE ROUND

Round = class('Round')

function Round:initialize()
   self.dealerHand = Hand:new()
   self.playerHands = {Hand:new()} -- player's hands (player can have 2 hands after a split)
   self.playerHand = self.playerHands[1] -- reference to the hand that is currently being played
   self.playerHand.bet = 0
   self.deck = _.shuffle(generateDeck(), love.timer.getTime())
   --debug deck for testing split functionality:
   --self.deck = _.append({{suit = 'spades', value = '8'}, {suit = 'hearts', value = '8'}, {suit = 'clubs', value = '8'}, {suit = 'diamonds', value = '8'}}, generateDeck())
   --self.deck = _.append({{suit = 'spades', value = '5'}, {suit = 'hearts', value = '5'}, {suit = 'clubs', value = 'K'}, {suit = 'clubs', value = '5'}, {suit = 'diamonds', value = '5'}}, generateDeck())
   --self.deck = _.append({{suit = 'spades', value = 'A'}, {suit = 'hearts', value = 'K'}, {suit = 'clubs', value = 'A'}, {suit = 'clubs', value = 9}, {suit = 'diamonds', value = '5'}}, generateDeck())
   if currentTutorial ~= nil and currentTutorial.deck ~= nil then
      self.deck = _.clone(currentTutorial.deck)
   end
   self.insurance = 0
   self.surrendered = false
   self.evenMoney = false
end

-- user actions

function Round:start(bet)
   self.playerHand.bet = bet
   _.push(self.playerHand.cards, _.pop(self.deck), _.pop(self.deck))
   _.push(self.dealerHand.cards, _.pop(self.deck))
end

function Round:hit()
   local drawnCard = _.pop(self.deck)
   _.push(self.playerHand.cards, drawnCard)
   return drawnCard
end

function Round:stand()

end

function Round:double()
   self.doubled = true
   return self:hit()
end

function Round:split()
   local playerHand2 = Hand:new()
   playerHand2.bet = 10
   _.push(playerHand2.cards, _.pop(self.playerHand.cards))
   _.push(self.playerHands, playerHand2)
end

function Round:surrender()
   self.surrendered = true
end

function Round:setEvenMoney()
   self.evenMoney = true
end

-- round helper methods

function Round:dealerTurn(interval, afterCard, finally)
   local drawnCard = nil
   interval = interval or 0
   if self:dealerShouldDraw() then
      Utilities.delay(interval, function()
         drawnCard = _.pop(self.deck)
         _.push(self.dealerHand.cards, drawnCard)
         afterCard(drawnCard)
         self:dealerTurn(interval, afterCard, finally)
      end)
   elseif finally ~= nil then
      Utilities.delay(interval, finally)
   end
end

function Round:getDealerTurnCards()
   return _.tail(self.dealerHand.cards)
end

function Round:getPlayerTotal()
   return self.playerHand:getValue()
end

function Round:maxValidDealerTotal()
   return _.max(_.select(self:getDealerTotal(), function(k,v)
      return v <= 21
   end))
end

function Round:maxValidPlayerTotal()
   return _.max(_.select(self:getPlayerTotal(), function(k,v)
      return v <= 21
   end))
end

function Round:playerShouldStand()
   local maxValidTotal = self:maxValidPlayerTotal()
   return maxValidTotal ~= nil and maxValidTotal == 21
end

function Round:dealerShouldDraw()
   local maxValidTotal = self:maxValidDealerTotal()
   return maxValidTotal ~= nil and maxValidTotal < 17
end

function Round:getDealerTotal()
   return self.dealerHand:getValue()
end

function Round:isBlackjack(cards)
   return _.size(cards) == 2 and _.reduce(cards, function(state, card)
      return state + cardValue(card, true)
   end, 0) == 21
end

function Round:playerHasBlackjack()
   return self:isBlackjack(self.playerHand.cards)
end

function Round:dealerHasBlackjack()
   return self:isBlackjack(self.dealerHand.cards)
end

function Round:playerIsBusted()
   return _.min(self.playerHand:getValue()) > 21
end

function Round:dealerIsBusted()
   return _.min(self.dealerHand:getValue()) > 21
end

function Round:playerCanDouble()
   return _.size(self.playerHand.cards) == 2 and not _.isEmpty(_.select(self:getPlayerTotal(), function(k,v)
      return 9 <= v and v <= 11
   end))
end

function Round:playerCanSplit()
   local cards = self.playerHand.cards
   return _.size(cards) == 2 and cards[1].value == cards[2].value
end

function Round:playerCanInsure()
   return _.size(self.playerHand.cards) == 2 
      and _.size(self.dealerHand.cards) == 1 
      and self.dealerHand.cards[1].value == 'A'
end

function Round:evenMoneyPossible()
   return self:playerCanInsure() and self:playerHasBlackjack()
end

function Round:setInsurance()
   self.insurance = 5
end

function Round:playerHasInsurance()
   return self.insurance > 0
end

function Round:playerHasMultipleHands()
   return _.size(self.playerHands) > 1 
end

function Round:playerHasNextHand()
   return _.size(self.playerHands) > 1 and self.playerHand == self.playerHands[1]
end

function Round:playNextHand()
   self.playerHand = self.playerHands[2]
end

-- returns ratio of the bet that is payed to the player
function Round:getHandResult(hand)
   if hand:isBusted() then
      return 0
   else
      if hand:isBlackjack() then
         if self.evenMoney then
            return 2
         else
            if self.dealerHand:isBlackjack() then
               return 1
            else
               return 2.5
            end
         end
      else
         if self.dealerHand:isBlackjack() then
            return 0
         elseif self.dealerHand:isBusted() then
            return 2
         else
            if hand:maxNotBustedTotal() > self.dealerHand:maxNotBustedTotal() then
               return 2
            elseif hand:maxNotBustedTotal() < self.dealerHand:maxNotBustedTotal() then
               return 0
            else
               return 1
            end
         end
      end
   end
end

function Round:getWinnings()
   local insuranceWin = 0
   if self:playerHasInsurance() and self.dealerHand:isBlackjack() then
      insuranceWin = self.insurance * 3
   end
   
   if self.surrendered then
      return insuranceWin + self.playerHand.bet / 2
   else
      return insuranceWin + _.reduce(self.playerHands, function(state, hand) 
         return state + (hand.bet * self:getHandResult(hand))
      end, 0)
   end
end