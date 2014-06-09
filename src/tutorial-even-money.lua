TutorialEvenMoney = class('TutorialEvenMoney')

function TutorialEvenMoney:initialize()
   self.intro = [[
      Even money can be considered as a special case of insurance, since it can be taken only when the dealer is showing an ace and the player has a blackjack.

      When player takes even money, he receives winnings equal to a point victory (1:1). If even money is not taken, player receives normal winnings according to the round result.

      Just like insurance, even money is not recommended by strategy guides. Nevertheless, let's try it now!
   ]]

   self.deck = {
      {suit = 'hearts', value = 'A'}, 
      {suit = 'spades', value = 10}, 
      {suit = 'diamonds', value = 'A'}, 
      {suit = 'clubs', value = 'Q'}, 
      {suit = 'diamonds', value = 'J'}
   }

   self.step = 0
   self.evenMoneyTaken = false
end

function TutorialEvenMoney:onStartRound()
   gameView:showHint('Even money is offered when the dealer is showing an ace and the player has a blackjack. Try taking it now!')
end

function TutorialEvenMoney:onEvenMoney()
   self.evenMoneyTaken = true
end

function TutorialEvenMoney:onRoundResult(winnings)
   if self.evenMoneyTaken then
      gameView:showHint('Great! Without even money it would have been a draw.')
      gameView.endTutorialButton:show()
      gameView.betButton:hide()
   else
      gameView:showHint('You did not take even money and the game is a draw, please try again.')
   end
end