TutorialSplit = class('TutorialSplit')

function TutorialSplit:initialize()
   self.intro = [[
      If the cards in your initial hand are of the same value, you can split the hand so that each of the cards are considered as separate hands that are played independently.

      When splitting, you must also double your bet. The bet is divided equally between the two hands.

      Splitting is usually more beneficial against weaker dealer hands. Generally, always split aces and never split 10s (including face cards), 5s or 4s.

      Bet 10 to try splitting!
   ]]

   self.deck = {
      {suit = 'clubs', value = 7}, 
      {suit = 'hearts', value = 7}, 
      {suit = 'diamonds', value = 'J'}, 
      {suit = 'clubs', value = 'Q'}, 
      {suit = 'diamonds', value = 3},
      {suit = 'clubs', value = 4},
      {suit = 'spades', value = 2},
      {suit = 'clubs', value = 'J'},
      {suit = 'hearts', value = 'K'},
      {suit = 'spades', value = 'Q'},
      {suit = 'spades', value = 10}
   }

   self.step = 0
   self.splitted = false
end

function TutorialSplit:onStartRound()
   gameView:showHint('You are allowed to split because your cards are of the same value. Try it now!')
end

function TutorialSplit:onSplit()
   gameView:showHint('Great! Now play the first hand as you would play any regular hand.')
   self.splitted = true
end

function TutorialSplit:onNextHand()
   gameView:showHint('Let\'s play the second hand now. It is also possible to double after split.')
end

function TutorialSplit:onRoundResult(winnings)
   if self.splitted then
      gameView:showHint('Nice! Winnings of the hands are counted separately. That was all about splitting.')
      gameView.endTutorialButton:show()
      gameView.betButton:hide()
   else
      gameView:showHint('You did not split your hand, please try again.')
   end
end