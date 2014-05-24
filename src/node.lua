-- UI Node class
-- To be extended with more specific sub-classes

Node = class('Node')

function Node:initialize(params)

   self.x = 0
   self.y = 0
   self.visible = true

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

   -- table of child nodes
   self.children = {}
end

function Node:addChild(newChild)
   newChild.parentNode = self
   table.insert(self.children, newChild)
end

function Node:removeChild(index)
   self.children[index].parentNode = nil
   table.remove(self.children, index)
end

function Node:beforeUpdate()
   _.each(self.children, function(key, val)
      val:beforeUpdate()
   end)
end

function Node:update()
   if(self.visible) then
      _.each(self.children, function(key, val)
         val:update()
      end)
   end
end

function Node:draw()
   if(self.visible) then
      if(self.image ~= nil) then
         love.graphics.setColor({255,255,255,255})
         local scaleX = self.width / self.imageWidth
         local scaleY = self.height / self.imageHeight
         local offsetX = self.imageWidth / 2
         local offsetY = self.imageHeight / 2
         local x = self:getX() + offsetX * scaleX
         local y = self:getY() + offsetY * scaleY
         love.graphics.draw(self.image, x, y, 0, scaleX, scaleY, offsetX, offsetY)
      end

      _.each(self.children, function(key, val)
         val:draw()
      end)
   end
end

function Node:setImage(path)
   self.image = love.graphics.newImage(path)
   self.imageWidth, self.imageHeight = self.image:getDimensions()
end

function Node:show()
   self.visible = true
end

function Node:hide()
   self.visible = false
end

function Node:getX()
   x = self.x
   p = self.parentNode
   while(p ~= nil) do
      x = x + p.x
      p = p.parentNode
   end
   return x
end

function Node:getY()
   y = self.y
   p = self.parentNode
   while(p ~= nil) do
      y = y + p.y
      p = p.parentNode
   end
   return y
end

function Node:isVisible()
   p = self.parentNode
   while(p ~= nil) do
      if not p.visible then
         return false
      end
      p = p.parentNode
   end
   return true
end