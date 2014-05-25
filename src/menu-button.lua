MenuButton = class('MenuButton', Button)

function MenuButton:initialize()
   Button.initialize(self)
   self.text = 'Menu'
   self.x = 10
   self.y = 10
   self.width = 120
   self.height = 50
   self.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 24)
   self:setClickHandler(function()
      mainMenu:show()
      self.parentNode:hide()
   end)
end