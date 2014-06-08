ModalWindow = class('ModalWindow', View)

function ModalWindow:initialize()
   View.initialize(self)
   self.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 14)
   self.text = ''
   self.x = 0
   self.y = 70
   self.width = 640
   self.height = 295
end

function ModalWindow:draw()
   if self:isVisible() then

      love.graphics.setColor({255,255,255,255})
      love.graphics.rectangle("fill", self:getX(), self:getY(), self.width, self.height)

      love.graphics.setColor({0,0,0,255})
      love.graphics.setFont(self.font)
      love.graphics.printf(self.text, self:getX() + 20, self:getY() + 20, self.width - 40, 'left')

   end
   View.draw(self)
end
