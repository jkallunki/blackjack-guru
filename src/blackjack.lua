Round = class('Round')

function Round:initialize(params)
	dealerCards = {}
	playerCards = {}
end


-- user actions
function Round:hit()
	return {suit = 'spades', value = 'K'}
end

function Round:stand()

end

function Round:double()

end

function Round:split()

end

function Round:surrender()

end

function Round:insurance()

end

function Round:evenMoney()

end