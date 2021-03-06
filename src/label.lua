Label = Node:subclass('Label')

function Label:initialize(params)

   -- Default options
   self.defaults = { color = {255,255,255,255},
                     text = 'Text',
                     height = 60,
                     width = 200,
                     x = 0,
                     y = 0,
                     align = 'center',
                     font = love.graphics.newFont("media/fonts/nunitolight.ttf", 28) }

   Node.initialize(self, params)
end

function Label:draw()
   Node.draw(self)
   if self:isVisible() then
      love.graphics.setColor(self.color)
      love.graphics.setFont(self.font)
      love.graphics.printf(self.text, self:getX(), self:getY(), self.width, self.align)
   end
end

function Label:setText(text)
   self.text = text
end