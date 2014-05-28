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

-- calculates possible hand values from an array of cards
-- returns a table containing all possible values e.g {'A','A','2'} => {4,14,24}
function calculateHandValue(cards)
   return _.reduce(cards, function(total, card)
      local value = _.detect({'J','Q','K'}, card.value) and 10 or card.value
      return _.sort(_.uniq(_.flatten(_.map(total, function(k,v)
         return value == 'A' and {v + 1, v + 11} or v + value
      end))))
   end, {0})
end

-- SINGLE ROUND

Round = class('Round')

function Round:initialize(params)
   self.dealerCards = {}
   self.playerCards = {}
   self.deck = _.shuffle(generateDeck(), love.timer.getTime())
end

-- user actions

function Round:start(bet)
   self.bet = bet
   _.push(self.playerCards, _.pop(self.deck), _.pop(self.deck))
   _.push(self.dealerCards, _.pop(self.deck))
end

function Round:hit()
   local drawnCard = _.pop(self.deck)
   _.push(self.playerCards, drawnCard)
   return drawnCard
end

function Round:stand()

end

function Round:double()

end

function Round:split()

end

function Round:surrender()

end

function Round:insurance()

end

function Round:evenMoney()

end

-- round helper methods

function Round:dealerTurn()
   local drawnCards = {}
   local drawnCard = nil
   while self:dealerShouldDraw() do
      drawnCard = _.pop(self.deck)
      print(drawnCard.value)
      _.push(drawnCards, drawnCard)
      _.push(self.dealerCards, drawnCard)
   end
   print('--')
   return drawnCards
end

function Round:getDealerTurnCards()
   return _.tail(self.dealerCards)
end

function Round:getPlayerTotal()
   return calculateHandValue(self.playerCards)
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
   return calculateHandValue(self.dealerCards)
end

function Round:isBlackjack(cards)
   return _.size(cards) == 2 and _.reduce(cards, function(state, card)
      return state + cardValue(card, true)
   end, 0) == 21
end

function Round:playerHasBlackjack()
   return self:isBlackjack(self.playerCards)
end

function Round:dealerHasBlackjack()
   return self:isBlackjack(self.dealerCards)
end

function Round:playerIsBusted()
   return _.min(calculateHandValue(self.playerCards)) > 21
end
