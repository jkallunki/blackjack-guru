InfoButton = class('InfoButton', Button)

function InfoButton:initialize()
   Button.initialize(self)
   self.text = 'Info'
   self.x = 550
   self.y = 430
   self.width = 80
   self.height = 40
   self.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 20)
   self:setClickHandler(function()
      infoView:show()
      self.parentNode:hide()
   end)
end