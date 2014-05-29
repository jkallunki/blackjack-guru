GameButton = class('GameButton', Button)

function GameButton:initialize(params)

   Button.initialize(self, params)
   self.height = 50
   self.font = love.graphics.newFont("media/fonts/nunitolight.ttf", 24)
end