TutorialMenu = class('TutorialMenu', View)

function TutorialMenu:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- tutorials title
   local tutorialsTitle = Title:new({x = 20, y = 10, text = 'Tutorials', width = 600})
   self:addChild(tutorialsTitle)

end