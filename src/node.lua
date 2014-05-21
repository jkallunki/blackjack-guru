-- UI Node class
-- To be extended with more specific sub-classes

Node = class('Node')

function Node:initialize(params)

   if(self.defaults ~= nil) then
      for k,v in pairs(self.defaults) do 
         self[k] = v
      end
   end

   if(params ~= nil) then
      for k,v in pairs(params) do 
         self[k] = v
      end
   end

   -- is the node rendered?
   self.visible = true

   -- position relative to the parent node
   self.position = { x = 0, y = 0 }

   -- nodes with higher z-index are rendered on top
   self.z = 0

   -- table of child nodes
   self.children = {}
end

function Node:addChild(newChild)
   table.insert(self.children, newChild)
end

function Node:removeChild(index)
   table.remove(self.children, index)
end

function Node:update()
   _.each(self.children, function(key, val)
      val:update()
   end)
end

function Node:draw()
   if(self.image ~= nil) then
      love.graphics.draw(self.image, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 1, 1, 512, 256)
   end

   _.each(self.children, function(key, val)
      val:draw()
   end)
end

function Node:setImage(path)
   self.image = love.graphics.newImage(path)
end