Button = Node:subclass('Button')

function Button:initialize(params)
   -- Defaults options
   self.defaults = { backgroundColor = {0,0,0,255},
                     hoverBackgroundColor = {63,63,63,255},
                     activeBackgroundColor = {127,127,127,255},
                     textColor = {255,255,255,255},
                     hoverTextColor = {255,255,255,255},
                     activeTextColor = {255,255,255,255},
                     text = 'Button',
                     height = 60,
                     width = 200,
                     x = 0,
                     y = 0,
                     font = love.graphics.newFont("media/fonts/nunitolight.ttf", 28),
                     audio = love.audio.newSource("media/audio/click.mp3", "static") }

   Node.initialize(self, params)

   self.hover = false
   self.clickable = false
end

function Button:beforeUpdate()
   self.clickable = self:isVisible()
   Node.beforeUpdate(self)
end

function Button:update(dt)
   if(self.clickable) then
      mx, my = love.mouse.getPosition()
      if mx >= self:getX() and mx <= self:getX() + self.width and my >= self:getY() and my <= self:getY() + self.height then
         self.hover = true
      else
         self.hover = false
      end

      if self.hover and mouseClicked then
         if(self.clickHandler ~= nil) then
            self.clickHandler()
         end
         if(self.audio ~= nil) then self.audio:play() end
         self.active = true
      else
         self.active = false
      end
   end
end

function Button:draw()
   love.graphics.setFont(self.font)
   if self.active then
      love.graphics.setColor(self.activeBackgroundColor)
   elseif self.hover then
      love.graphics.setColor(self.hoverBackgroundColor)
   else
      love.graphics.setColor(self.backgroundColor)
   end
   love.graphics.rectangle("fill", self:getX(), self:getY(), self.width, self.height)
   if self.hover then
      love.graphics.setColor(self.hoverTextColor)
   else
      love.graphics.setColor(self.textColor)
   end
   love.graphics.printf(self.text, self:getX(), self:getY() + 10, self.width, 'center')
end

function Button:setClickHandler(handler)
   self.clickHandler = handler
end