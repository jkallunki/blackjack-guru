Label = Node:subclass('Label')

function Label:initialize(params)

   -- Default options
   self.defaults = { color = {255,255,255,255},
                     text = 'Label',
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
   love.graphics.setColor(self.color)
   love.graphics.setFont(self.font)
   love.graphics.printf(self.text, self.x, self.y, self.width, self.align)
end

function Label:setText(text)
   self.text = text
end