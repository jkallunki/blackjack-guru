Button = Node:subclass('Button')

function Button:initialize(params)

   Node.initialize(self)

   -- Defaults options
   local defaults = { backgroundColor = {0,0,0,255},
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
                  font = love.graphics.newFont("media/fonts/nunitolight.ttf", 28) }

   -- Replace default options with given parameters
   for k,v in pairs(defaults) do 
      self[k] = v
   end

   for k,v in pairs(params) do 
      self[k] = v
   end

   self.hover = false

   self.audio = love.audio.newSource("media/audio/click.mp3", "static")
end

function Button:update(dt)
   mx, my = love.mouse.getPosition()
   if mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height then
      self.hover = true
   else
      self.hover = false
   end

   if self.hover and mouseClicked then
      text = 'Button was clicked'
      self.audio:play()
      self.active = true
   else
      self.active = false
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
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
   if self.hover then
      love.graphics.setColor(self.hoverTextColor)
   else
      love.graphics.setColor(self.textColor)
   end
   love.graphics.printf(self.text, self.x, self.y + 10, self.width, 'center')
end