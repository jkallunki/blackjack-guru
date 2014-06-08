Card = Node:subclass('Card')

function Card:initialize(params)

   -- Default options
   self.defaults = { suit = 'spades', value = 'Q', angle = 0 }
   Node.initialize(self, params)

   self.suitImage = love.graphics.newImage("media/images/" .. self.suit .. ".png")
   self.canvas = love.graphics.newCanvas(100, 140)
   love.graphics.setCanvas(self.canvas)
   self.canvas:clear()
   love.graphics.setBlendMode('alpha')
   love.graphics.setColor({255,255,255,255})
   love.graphics.rectangle("fill", 0, 0, 100, 140)
   love.graphics.setLineWidth(1)
   love.graphics.setColor({0,0,0,255})
   love.graphics.rectangle("line", 0, 0, 100, 140)
   love.graphics.setFont(love.graphics.newFont("media/fonts/blanch.otf", 40))

   if self.suit == 'spades' or self.suit == 'clubs' then
      love.graphics.setColor({0,0,0,255})
   else
      love.graphics.setColor({189,36,36,255})
   end
   love.graphics.printf(self.value, 0, 5, 30, 'center')
   love.graphics.setColor({255,255,255,255})
   love.graphics.draw(self.suitImage, 26, 64, 0, 0.5, 0.5, 0, 0)

   love.graphics.draw(self.suitImage, 5, 45, 0, 0.16, 0.16, 0, 0)
   love.graphics.setCanvas()

   self.dim = false
end

function Card:draw()
   love.graphics.setBlendMode('premultiplied')
   if self.dim then
      love.graphics.setColor({96,96,96,255})
   else
      love.graphics.setColor({255,255,255,255})
   end
   love.graphics.draw(self.canvas, self:getX() + 50, self:getY() + 75, self.angle, 1, 1, 50, 75)
   love.graphics.setBlendMode('alpha')
end