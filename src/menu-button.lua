MenuButton = class('MenuButton', Button)

function MenuButton:initialize()
   Button.initialize(self)
   self.text = 'Menu'
   self.x = 10
   self.y = 10
   self.width = 110
   self:setClickHandler(function()
      mainMenu:show()
      self.parentNode:hide()
   end)
end