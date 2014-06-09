TutorialDouble = class('TutorialDouble')

function TutorialDouble:initialize()
   self.intro = [[
      It is possible to double your bet when your initial hand value is 9, 10 or 11. When doubling your bet, you also commit to draw one more card and stand there.

      Doubling all hands from 9 to 11 is often recommended since there is a high possibility of getting close to 21 with a single card and busting is not possible. However, against dealer 10 or 11 you should hit instead of doubling. A hand valued at 9 should only be doubled when dealer has a 6 or lower.
   
      Click "Bet 10" to try it out!
   ]]

   self.deck = {
      {suit = 'clubs', value = 5}, 
      {suit = 'hearts', value = 6}, 
      {suit = 'diamonds', value = 9}, 
      {suit = 'clubs', value = 'Q'}, 
      {suit = 'diamonds', value = 'K'},
      {suit = 'clubs', value = 'J'}
   }

   self.step = 0
end

function TutorialDouble:onStartRound()
   if self.step == 0 then
      gameView:showHint('There are pretty good odds for a 21 now, so let\'s double our bet.')
   elseif self.step == 1 then
      self.deck = {
         {suit = 'diamonds', value = 4}, 
         {suit = 'hearts', value = 5}, 
         {suit = 'clubs', value = 'Q'}, 
         {suit = 'clubs', value = 10}, 
         {suit = 'diamonds', value = 'K'},
         {suit = 'clubs', value = 'J'}
      }
      gameView:showHint('Now you can choose what to do. Remember what was said about the dealer\'s hand?')
   end
end

function TutorialDouble:onHit()
   if self.step == 0 then
      gameView:showHint('Not a bad move, but not the best one either. You should have doubled, please try again!')
   elseif self.step == 1 then
      if gameView.currentRound.playerHand:getValue()[1] == 9 then
         gameView:showHint('Good! Hitting was the optimal choice. You might want to stand here.')
      else
         gameView:showHint('That was not wise. Please try again!')
      end
   end
end

function TutorialDouble:onStand()
   if self.step == 0 then
      gameView:showHint('That was not wise. Please try again!')
   elseif self.step == 1 then
      if gameView.currentRound.playerHand:getValue()[1] == 9 then
         gameView:showHint('That was not wise. Please try again!')
      elseif gameView.currentRound.playerHand:getValue()[1] == 19 then
         gameView:showHint('Well played, let\'s see how it goes!')
      end
   end
end

function TutorialDouble:onRoundResult(winnings)
   if self.step == 0 then
      if winnings == 5 then
         gameView:showHint('Surrendering gives half of your bet back. You are not going to win much by doing so! Try again.')
      elseif winnings == 40 then
         gameView:showHint('Double bet, double winnings, it\'s as simple as that! Let\'s play another round!')
         self.step = 1
      end
   elseif self.step == 1 then
      if winnings == 5 then
         gameView:showHint('Surrendering gives half of your bet back. You are not going to win much by doing so! Try again.')
      else
         if gameView.currentRound.playerHand.bet == 20 then
            gameView:showHint('You should not have doubled against dealer 10. Please try again!')
         elseif gameView.currentRound.playerHand:getValue()[1] == 19 then
            gameView:showHint('Oh dear... However, you did well! Often it\'s not about winning more, but losing less.')
            gameView.endTutorialButton:show()
            gameView.betButton:hide()
         end
      end
   end
end