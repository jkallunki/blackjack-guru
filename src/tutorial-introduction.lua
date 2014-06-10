TutorialIntroduction = class('TutorialIntroduction')

function TutorialIntroduction:initialize()
   self.intro = [[
      Blackjack is a card game where players compete against the dealer. Player's aim is to achieve a hand value that is closer to 21 than the dealer's without going over. Going over 21 is called "busting" and getting 21 with the first two cards is called "blackjack". The player also wins if the dealer busts and the player does not, or if the player gets blackjack and the dealer does not. If the player and the dealer have hands with same values, the game is a tie (also called "push") and the player gets his initial bet back. The dealer must draw to 16 and stand on all 17.

      Face cards (K, Q and J) are counted as ten points. An ace (A) can be counted as 1 point or 11 points. Other cards are counted as their numeric values.
   
      After the initial bet is set, the players are dealt two cards and the dealer gets one. For simplicity, we use 10 credits as an initial bet for each round in this tutorial.

      You can now start by betting 10 credits.
   ]]

   self.deck = {
      {suit = 'spades', value = 7}, 
      {suit = 'hearts', value = 5}, 
      {suit = 'clubs', value = 9}, 
      {suit = 'clubs', value = 8}, 
      {suit = 'diamonds', value = 'K'},
      {suit = 'clubs', value = 'J'}
   }

   self.round = 0
   self.step = 0
end

function TutorialIntroduction:onStartRound()
   if self.step == 0 then
      gameView:showHint('Good! Now try drawing one more card by pressing "Hit".')
   elseif self.step == 1 then
      self.deck = {
         {suit = 'diamonds', value = 'A'}, 
         {suit = 'hearts', value = 5}, 
         {suit = 'clubs', value = 9}, 
         {suit = 'clubs', value = 8}, 
         {suit = 'diamonds', value = 'K'},
         {suit = 'clubs', value = 'J'}
      }
      gameView:showHint('An ace (A) can be count as 1 or 11. A hand with 2 possible values is called "soft". Try hitting now!')
   elseif self.step == 2 then
      self.deck = {
         {suit = 'spades', value = 'A'}, 
         {suit = 'hearts', value = 'K'}, 
         {suit = 'spades', value = 3}, 
         {suit = 'clubs', value = 8}, 
         {suit = 'diamonds', value = 'K'},
         {suit = 'clubs', value = 'J'}
      }
      gameView:showHint('Superb. You got a blackjack!')
   end
end

function TutorialIntroduction:onHit()
   if self.step == 0 then
      if gameView.currentRound.playerHand:getValue()[1] == 12 then
         gameView:showHint('Great! Seems like we are pretty close to 21. Let\'s stay here, so press "Stand".')
      else
         gameView:showHint('That was not wise. You just went over 21 and lost your bet. Please try again!')
      end
   elseif self.step == 1 then
      gameView:showHint('Now the ace is count as 1, since with 11 the hand would bust. You can choose whether to hit or not!')
   end
end

function TutorialIntroduction:onStand()
   if self.step == 0 then
      if gameView.currentRound.playerHand:getValue()[1] == 12 then
         gameView:showHint('That was not wise. Please try again!')
      else
         gameView:showHint('Awesome!')
      end
   end
end

function TutorialIntroduction:onRoundResult(winnings)
   if self.step == 0 then
      if winnings == 5 then
         gameView:showHint('Surrendering gives half of your bet back. You are not going to win much by doing so! Try again.')
      elseif winnings > 5 then
         gameView:showHint('Awesome! As you can see now, a non-blackjack win pays 1:1. Let\'s play another round!')
         self.step = 1
      end
   elseif self.step == 1 then
      if winnings == 5 then
         gameView:showHint('Surrendering gives half of your bet back. You are not going to win much by doing so! Try again.')
      else
         if gameView.currentRound.playerHand:getValue()[1] == 6 then
            gameView:showHint('You should always hit on soft 16. Please try again!')
         else
            gameView:showHint('Oh, the dealer won this round, but no problem, let\'s move on!')
            self.step = 2
         end
      end
   elseif self.step == 2 then
         gameView:showHint('Awesome! Blackjack is better than 21 with more cards and it pays 3:2. Looks like you are getting a hunch of this!')
         gameView.endTutorialButton:show()
         gameView.betButton:hide()
   end
end