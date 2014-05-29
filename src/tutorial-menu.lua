TutorialMenu = class('TutorialMenu', View)

function TutorialMenu:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   View.initialize(self)

   local menuButton = MenuButton:new()
   self:addChild(menuButton)

   -- small logo
   local smallLogo = Node:new({x = 502, y = 5, width = 128, height = 64})
   smallLogo:setImage('media/images/logo.png')
   self:addChild(smallLogo)

   -- tutorials title
   local tutorialsTitle = Title:new({x = 20, y = 0, text = 'Tutorials', width = 600})
   self:addChild(tutorialsTitle)

   -- tutorial launch buttons
   local tutorialButton1 = TutorialButton:new('1. Basic rules', 90)
   self:addChild(tutorialButton1)

   local tutorialButton2 = TutorialButton:new('2. Double', 150)
   self:addChild(tutorialButton2)

   local tutorialButton3 = TutorialButton:new('3. Split', 210)
   self:addChild(tutorialButton3)

   local tutorialButton4 = TutorialButton:new('4. Surrender', 270)
   self:addChild(tutorialButton4)

   local tutorialButton5 = TutorialButton:new('5. Insurance', 330)
   self:addChild(tutorialButton5)

   local tutorialButton6 = TutorialButton:new('6. Even money', 390)
   self:addChild(tutorialButton6)

end