-- UI View class
-- To be used as a top level container for other UI nodes

View = class('View', Node)

function View:initialize()
   self.defaults = {width = love.window.getWidth(), height = love.window.getHeight()}
   Node.initialize(self)
end