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

function Hand:isBlackjack()
   return _.size(self.cards) == 2 and _.reduce(self.cards, function(state, card)
      return state + cardValue(card, true)
   end, 0) == 21
end

function Hand:isSoft()
   local validValues = _.select(self:getValue(), function(k,v)
      return v <= 21
   end)
   return validValues ~= nil and _.size(validValues) ~= nil and _.size(validValues) > 1
end

function Hand:isPair()
   local value1 = _.detect({'J','Q','K'}, self.cards[1].value) and 10 or self.cards[1].value
   local value2 = _.detect({'J','Q','K'}, self.cards[2].value) and 10 or self.cards[2].value
   return _.size(self.cards) == 2 and value1 == value2
end

function Hand:isBusted()
   return _.min(self:getValue()) > 21
end

function Hand:maxNotBustedTotal()
   return _.max(_.select(self:getValue(), function(k,v)
      return v <= 21
   end))
end
