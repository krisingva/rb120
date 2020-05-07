
class Deck
  SUITS = ["Heart", "Spade", "Club", "Diamond"]
  NUMBERS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "Jack", "Queen", "King", "Ace"]

  attr_reader :deck

  def initialize
    @deck = []
    make_deck
    p deck
  end

  def make_deck
    SUITS.each do |suit|
      NUMBERS.each do |num|
        deck << Card.new(num, suit)
      end
    end
  end

  def deal
    # does the dealer or the deck deal?
  end
end

class Card
  def initialize(number, suit)
    @number = number
    @suit = suit
  end
end

Deck.new