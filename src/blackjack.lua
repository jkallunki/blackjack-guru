

function generateDeck()
   local suits = {'hearts', 'spades', 'diamonds', 'clubs' }
   local values = {2,3,4,5,6,7,8,9,10,'J','Q','K','A'}
   return _.flatten(_.map(suits, function(sk,sv)
      return _.map(values, function(vk, vv)
         return {suit = sv, value = vv}
      end)
   end), true)
end

function calculateHandValue(cards)
   return _.reduce(cards, function(total, card)
      local value = card.value
      if _.detect({'J','Q','K'}, value) then
         value = 10
      elseif value == 'A' then
         value = 1
      end
      total = _.map(total, function(k,v) 
         return v + value
      end)
      if card.value == 'A' then
         total = _.uniq(_.flatten(_.map(total, function(k,v)
            return {v, v+10}
         end)))
      end
      return total
   end, {0})
end

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


   local values = calculateHandValue(self.playerCards)
   _.each(values, function(k,v)
      print(v)
   end)
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

-- 

function Round:getPlayerTotal()

end