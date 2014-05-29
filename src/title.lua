Title = Label:subclass('Title')

function Title:initialize(params)
   Label.initialize(self, params)
   self.font = love.graphics.newFont("media/fonts/blanch.otf", 66)
end