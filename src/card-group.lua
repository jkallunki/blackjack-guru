CardGroup = class('CardGroup', Node)

function CardGroup:initialize(params)
   Node.initialize(self, params)
   self.cardAmount = 0
   self.cards = {}
   
   self.nameLabel = Label:new({x = 0, y = 35, align = 'left', text = ''})
   self:addChild(self.nameLabel)
   self.totalLabel = Label:new({x = 0, y = 65, align = 'left', text = ''})
   self:addChild(self.totalLabel)
end

function CardGroup:addCard(card, delay, callback)
   delay = delay or 0
   local newCard = Card:new({x = self.cardAmount * 27, y = -800, angle = -1, suit = card.suit, value = card.value})
   table.insert(self.cards, newCard)
   Node.addChild(self, newCard)
   self.cardAmount = self.cardAmount + 1

   Utilities.delay(delay, function()
      local nameLabelTween = tween(0.4, self.nameLabel, {x = 88 + self.cardAmount * 27}, 'outCirc')
      local totalLabelTween = tween(0.4, self.totalLabel, {x = 88 + self.cardAmount * 27}, 'outCirc')
      local cardTween = tween(0.4, newCard, {y = 0, angle = 0}, 'outCirc', callback)
   end)
end

function CardGroup:empty()
   Node.removeAllChildren(self)
   self.cardAmount = 0
   self.nameLabel.x = 0
   self.totalLabel.x = 0
   self.totalLabel.text = ''
   self:addChild(self.totalLabel)
   self:addChild(self.nameLabel)
end

function CardGroup:setTotal(total)
   self.totalLabel.text = total
end