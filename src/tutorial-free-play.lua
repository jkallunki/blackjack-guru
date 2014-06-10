TutorialFreePlay = class('TutorialFreePlay')

function TutorialFreePlay:initialize()
   self.intro = nil
   self.isFreePlay = true
   gameView:showHint('')
end

function TutorialFreePlay:onStartRound()
   gameView:showHint('')
end

function TutorialFreePlay:onFinishHand()
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
      local dealerHand = currentRound.dealerHand
      local dealerCard = dealerHand.cards[1]
      local dealerCardValue = _.detect({'J','Q','K'}, dealerCard.value) and 10 or dealerCard.value
      if dealerCardValue == 'A' then dealerCardValue = 11 end
      local cards = playerHand.cards
      local value = playerHand:getValue()
      local maxNotBustedTotal = playerHand:maxNotBustedTotal()

      local hint = ''

      if playerHand:isBlackjack() or maxNotBustedTotal == nil then
         local hint = ''

      -- PAIR HANDS
      elseif playerHand:isPair() then
         if cards[1].value == 'A' then
            hint = 'split'
         elseif _.detect({10,'J','Q','K'}, cards[1].value) then
            hint = 'stand'
         elseif cards[1].value == 9 then
            if dealerCardValue > 9 then
               hint = 'stand'
            elseif dealerCardValue == 7 then
               hint = 'stand'
            else
               hint = 'split'
            end
         elseif cards[1].value == 8 then
            if dealerCardValue > 9 then
               hint = 'hit'
            else
               hint = 'split'
            end
         elseif cards[1].value == 7 then
            if dealerCardValue > 7 then
               hint = 'hit'
            else
               hint = 'split'
            end
         elseif cards[1].value == 6 then
            if dealerCardValue > 6 then
               hint = 'hit'
            else
               hint = 'split'
            end
         elseif cards[1].value == 5 then
            if dealerCardValue > 9 then
               hint = 'hit'
            else
               hint = 'double'
            end
         elseif cards[1].value == 4 then
            hint = 'hit'
         else
            if dealerCardValue > 3 and dealerCardValue < 8 then
               hint = 'split'
            else
               hint = 'hit'
            end
         end

      -- SOFT HANDS
      elseif playerHand:isSoft() then
         if maxNotBustedTotal == 20 then
            hint = 'stand'
         elseif maxNotBustedTotal == 19 then
            if dealerCardValue == 6 then
               hint = 'double'
            else
               hint = 'stand'
            end
         elseif maxNotBustedTotal == 18 and dealerCardValue < 9 then
            hint = 'stand'
         else
            hint = 'hit'
         end

      -- OTHER HANDS
      else
         if maxNotBustedTotal > 16 then
            hint = 'stand'
         elseif maxNotBustedTotal > 12 then
            if dealerCardValue > 6 then
               hint = 'hit'
            else
               hint = 'stand'
            end
         elseif maxNotBustedTotal == 12 then
            if dealerCardValue > 3 and dealerCardValue < 7 then
               hint = 'stand'
            else
               hint = 'hit'
            end
         elseif maxNotBustedTotal > 9 then
            if dealerCardValue > 9 then
               hint = 'hit'
            else
               hint = 'double'
            end
         elseif maxNotBustedTotal == 9 then
            if dealerCardValue > 6 then
               hint = 'hit'
            else
               hint = 'double'
            end
         else
            hint = 'hit'
         end
      end

      if hint == 'double' and not currentRound:playerCanDouble() then
         hint = 'hit'
      end

      if hint == '' then
         gameView:showHint('')
      else
         gameView:showHint('You should ' .. hint)
      end
   end
end