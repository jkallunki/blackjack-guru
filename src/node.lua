-- UI Node class
-- To be extended with more specific sub-classes

Node = class('Node')

function Node:initialize()
   -- is the node rendered?
   self.visible = true

   -- position relative to the parent node
   self.position = { x = 0, y = 0 }

   -- nodes with higher z-index are rendered on top
   self.z = 0

   -- table of child nodes
   self.children = {}
end