Hand = class('Hand')

function Hand:initialize()
   self.cards = {}
   self.bet = 0
   self.doubled = false
end

-- calculates possible hand values
-- returns an array containing all possible values e.g {'A','A','2'} => {4,14,24}
function Hand:getValue()
   return _.reduce(self.cards, function(total, card)
      local value = _.detect({'J','Q','K'}, card.value) and 10 or card.value
      return _.sort(_.uniq(_.flatten(_.map(total, function(k,v)
         return value == 'A' and {v + 1, v + 11} or v + value
      end))))
   end, {0})
end

function Round:isBlackjack()
   return _.size(self.cards) == 2 and _.reduce(self.cards, function(state, card)
      return state + cardValue(card, true)
   end, 0) == 21
end

function Hand:isBusted()
   return _.min(calculateHandValue(self.cards)) > 21
end

function Round:maxNotBustedTotal()
   return _.max(_.select(self:getValue(), function(k,v)
      return v <= 21
   end))
end
