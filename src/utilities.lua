Utilities = {}

Utilities.delayQueue = {}

function Utilities.delay(delay, f)
   local item = {}
   item.initTime = love.timer.getTime()
   item.f = f
   item.delay = delay
   table.insert(Utilities.delayQueue, item)
   return item
end

function Utilities.cancelDelay(item)
   if item ~= nil then
      for i,v in ipairs(Utilities.delayQueue) do
         if v == item then
            table.remove(Utilities.delayQueue, i)
         end
      end
   end
end

function Utilities.update(dt)
   local currentMicroTime = love.timer.getTime()
   for i,v in ipairs(Utilities.delayQueue) do
      if currentMicroTime > v.initTime + v.delay then
         v.f()
         table.remove(Utilities.delayQueue, i)
      end
   end
end
