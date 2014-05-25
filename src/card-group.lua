CardGroup = class('CardGroup', Node)

function CardGroup:initialize(params)
   Node.initialize(self, params)
   self.cardAmount = 0
end

function CardGroup:addCard(card)
   local newCard = Card:new({x = self.cardAmount * 27, y = 0, suit = card.suit, value = card.value})
   Node.addChild(self, newCard)
   self.cardAmount = self.cardAmount + 1
end

function CardGroup:empty()
   Node.removeAllChildren(self)
   self.cardAmount = 0
end