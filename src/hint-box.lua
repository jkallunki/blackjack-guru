HintBox = class('HintBox', Node)

function HintBox:initialize()
   View.initialize(self)
   self.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 16)
   self.text = 'Lorem ipsum dolor sit amet foo bar baz'
   self.x = 450
   self.y = 75
   self.width = 180
   self.height = 140
end

function HintBox:draw()
   if self:isVisible() then
      love.graphics.setColor({0,0,0,64})
      love.graphics.rectangle("fill", self:getX(), self:getY(), self.width, self.height)

      love.graphics.setColor({255,255,255,255})
      love.graphics.setFont(self.font)
      love.graphics.printf(self.text, self:getX() + 10, self:getY() + 10, self.width - 20, 'left')
   end
   View.draw(self)
end
