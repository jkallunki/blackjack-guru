TutorialFreePlay = class('TutorialFreePlay')

function TutorialFreePlay:initialize()
   self.intro = nil
   gameView:showHint('')
end

function TutorialFreePlay:onAfterStartRound()
   self:updateHint()
end

function TutorialFreePlay:onAfterHit()
   self:updateHint()
end

function TutorialFreePlay:updateHint()
   if gameView.currentRound ~= nil then
      local currentRound = gameView.currentRound
      local playerHand = currentRound.playerHand
      local value = playerHand:getValue()
      gameView:showHint(value[1])
   end
end