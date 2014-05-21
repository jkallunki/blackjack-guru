-- UI View class
-- To be used as a top level container for other UI nodes

View = class('View', Node)

function View:initialize()
   Node.initialize(self)
end