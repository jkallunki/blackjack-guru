GameView = class('GameView', View)

function GameView:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 490, y = 6, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- game title
   local gameTitle = Title:new({x = 20, y = 1, text = 'Free play', width = 600})
   self:addChild(gameTitle)

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