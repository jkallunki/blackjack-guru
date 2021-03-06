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
   self:addChild(newCard)
   self.cardAmount = self.cardAmount + 1

   self.addCardDelayRef = Utilities.delay(delay, function()
      self.nameLabelTween = tween(0.4, self.nameLabel, {x = 88 + self.cardAmount * 27}, 'outCirc')
      self.totalLabelTween = tween(0.4, self.totalLabel, {x = 88 + self.cardAmount * 27}, 'outCirc')
      self.cardTween = tween(0.4, newCard, {y = 0, angle = 0}, 'outCirc', callback)
   end)
end

function CardGroup:empty()
   Utilities.cancelDelay(self.addCardDelayRef)
   
   tween.stop(self.nameLabelTween)
   tween.stop(self.totalLabelTween)
   tween.stop(self.cardTween)

   tween.reset(self.nameLabelTween)
   tween.reset(self.totalLabelTween)
   tween.reset(self.cardTween)

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

function CardGroup:push(card)
   _.push(self.cards, card)
   self:addChild(card)
   self.cardAmount = self.cardAmount + 1
end

function CardGroup:pop()
   self.cardAmount = self.cardAmount - 1
   local card = _.unshift(self.cards)
   self.children = _.reject(self.children, function(k,v)
      return v == card
   end)
   return card
end

function CardGroup:setDim(dim)
   _.each(self.cards, function(k, card)
      card.dim = dim
   end)
end