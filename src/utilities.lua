Utilities = {}

Utilities.delayQueue = {}

function Utilities.delay(delay, f)

   local item = {}

   item.initTime = love.timer.getTime()
   item.f = f
   item.delay = delay

   table.insert(Utilities.delayQueue, item)
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
