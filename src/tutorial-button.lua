TutorialButton = class('TutorialButton', Button)

function TutorialButton:initialize(text, y)
   Button.initialize(self)
   self.x = 170
   self.y = y
   self.width = 300
   self.text = text
   self.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 24)
   self.textAlign = 'left'
   self.height = 55
   self:setClickHandler(function()
      gameView:show()
      self.parentNode:hide()
   end)
end