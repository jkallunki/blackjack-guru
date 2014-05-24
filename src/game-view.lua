GameView = class('GameView', View)

function GameView:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local button2 = Button:new({ text = 'Back to menu',
                          x = 10,
                          y = 10 })
   button2:setClickHandler(function()
      mainMenu:show()
      self:hide()
   end)
   self:addChild(button2)

   -- sample label
   local label2 = Label:new({x = 210, y = 300, text = 'Playing...'})
   self:addChild(label2)

   local card = Card:new({x = 50, y = 100, suit = 'spades', value = 'Q'})
   self:addChild(card)

   card = Card:new({x = 195, y = 100, suit = 'hearts', value = '10'})
   self:addChild(card)

   card = Card:new({x = 345, y = 100, suit = 'clubs', value = 'J'})
   self:addChild(card)

   card = Card:new({x = 490, y = 100, suit = 'diamonds', value = 'A'})
   self:addChild(card)
end