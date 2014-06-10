InfoView = class('InfoView', View)

function InfoView:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 502, y = 5, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- about title
   local tutorialsTitle = Title:new({x = 20, y = 0, text = 'Info', width = 600})
   self:addChild(tutorialsTitle)

   local creditsText = [[
      Special thanks to:
      - Awesome LÖVE community for the engine
      - Roland Yonaba for Moses.lua
      - Enrique Garcia for Middleclass and Tween.lua
      - IcoMoon for the card icons
      - Flashkit for audio FX
      - Blackjackrules.org for the rules and charts
   ]]
   local credits = Label:new({x = 20, y = 100, text = creditsText, width = 600, align = 'left'})
   self:addChild(credits)

end