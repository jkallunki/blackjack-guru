-- UI View class
-- To be used as a top level container for other UI nodes

View = class('View', Node)

function View:initialize()
   self.defaults = {width = windowWidth, height = windowHeight}
   Node.initialize(self)
end