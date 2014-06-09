TutorialInsurance = class('TutorialInsurance')

function TutorialInsurance:initialize()
   self.intro = [[
      If the dealer is showing an ace as the first card, players can insure their hands against dealer blackjack. Insurance can be taken only in the beginning of the round, and after taking an insurance the hand is played normally. Insurance costs half of the initial bet and pays 2 to 1. If the dealer gets blackjack, both the insurance cost and initial bet are returned to the player. In other words, insurance can be considered as a side bet.

      Taking insurance increases the house edge massively, so it is never recommended in strategy guides.

      Now you can try insurance yourself by betting 10 credits.
   ]]

   self.deck = {
      {suit = 'clubs', value = 7}, 
      {suit = 'hearts', value = 8}, 
      {suit = 'spades', value = 'A'}, 
      {suit = 'clubs', value = 'Q'}, 
      {suit = 'diamonds', value = 'J'},
      {suit = 'clubs', value = 4},
      {suit = 'spades', value = 2},
      {suit = 'clubs', value = 'J'},
      {suit = 'hearts', value = 'K'},
      {suit = 'spades', value = 'Q'},
      {suit = 'spades', value = 10}
   }

   self.step = 0
   self.insured = false
end

function TutorialInsurance:onStartRound()
   gameView:showHint('Insurance is offered when dealer is showing an ace. Try taking it now!')
end

function TutorialInsurance:onInsurance()
   gameView:showHint('Your hand is fully protected against dealer blackjack. Now, play the hand normally.')
   self.insured = true
end

function TutorialInsurance:onRoundResult(winnings)
   if self.insured then
      gameView:showHint('Nice! You just won your bets back by taking insurance.')
      gameView.endTutorialButton:show()
      gameView.betButton:hide()
   else
      gameView:showHint('You did not insure your hand, please try again.')
   end
end