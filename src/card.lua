Card = Node:subclass('Card')

function Card:initialize(params)

   -- Default options
   self.defaults = { suit = 'spades', value = 'Q', angle = 0 }
   Node.initialize(self, params)

   self.suitImage = love.graphics.newImage("media/images/" .. self.suit .. ".png")
   self.font = love.graphics.newFont("media/fonts/blanch.otf", 40)
   self.dim = false
end

function Card:draw()
   love.graphics.setBlendMode('alpha')
   love.graphics.push()
   love.graphics.translate(self:getX() + 50, self:getY() + 70)
   love.graphics.rotate(self.angle)
   if self.dim then
      love.graphics.setColor({192,192,192,255})
   else
      love.graphics.setColor({255,255,255,255})
   end
   love.graphics.rectangle("fill", -50, -70, 100, 140)
   love.graphics.setLineWidth(1)
   love.graphics.setColor({0,0,0,255})
   love.graphics.rectangle("line", -50, -70, 100, 140)
   love.graphics.setFont(self.font)
   if self.suit == 'spades' or self.suit == 'clubs' then
      love.graphics.setColor({0,0,0,255})
   else
      love.graphics.setColor({189,36,36,255})
   end
   love.graphics.printf(self.value, -50, -65, 30, 'center')
   love.graphics.setColor({255,255,255,255})
   love.graphics.draw(self.suitImage, -24, -6, 0, 0.5, 0.5, 0, 0)
   love.graphics.draw(self.suitImage, -45, -25, 0, 0.16, 0.16, 0, 0)
   love.graphics.setBlendMode('alpha')
   love.graphics.pop()
end
