CardGroup = class('CardGroup', Node)

function CardGroup:initialize(params)
   Node.initialize(self, params)
   self.cardAmount = 0
end

function CardGroup:addCard(card, delay, callback)
   delay = delay or 0
   local newCard = Card:new({x = self.cardAmount * 27, y = -800, angle = -1, suit = card.suit, value = card.value})
   Node.addChild(self, newCard)
   self.cardAmount = self.cardAmount + 1

   Utilities.delay(delay, function()
      loadTween = tween(0.4, newCard, {y = 0, angle = 0}, 'outCirc', callback)
   end)
end

function CardGroup:empty()
   Node.removeAllChildren(self)
   self.cardAmount = 0
end