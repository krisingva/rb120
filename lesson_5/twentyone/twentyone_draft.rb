require 'pry'

class Player
  attr_reader :name, :hand

  def initialize
    puts "What is your name?"
    @name = gets.chomp.capitalize
    @hand = []
  end

  def display_cards
    values = @hand.map {|card| card.value}
    puts joinor(values, ", ", "and")
  end

  def joinor(arr, sep = ", ", word = "or")
    if arr.size == 2
      "#{arr[0]} #{word} #{arr[1]}"
    elsif arr.size > 2
      "#{arr[0..-2].join(sep) + sep + word} #{arr[-1]}"
    else
      arr.join
    end
  end

  def hit(card)
    @hand << card
  end

  def stay
  end

  def busted?
    total > 21
  end

  def total
    total = 0
    @hand.each do |card|
      total += card.value
    end
    total
  end
end

class Dealer
  attr_reader :hand, :name

  def initialize
    @name = "Card Master"
    @hand = []
  end

  def display_initial_cards
    @hand.each_with_index do |card, idx|
      if idx == 0
        puts "secret card"
      else
        puts card
      end
    end
  end

  def display_cards
    values = @hand.map {|card| card.value}
    puts joinor(values, ", ", "and")
  end

  def joinor(arr, sep = ", ", word = "or")
    if arr.size == 2
      "#{arr[0]} #{word} #{arr[1]}"
    elsif arr.size > 2
      "#{arr[0..-2].join(sep) + sep + word} #{arr[-1]}"
    else
      arr.join
    end
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit(card)
    @hand << card
  end

  def stay
  end

  def busted?
    total > 21
  end

  def total
    total = 0
    @hand.each do |card|
      total += card.value
    end
    total
  end
end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Deck
  SUITS = ["Hearts", "Spades", "Clubs", "Diamonds"]
  NUMBERS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "Jack", "Queen", "King", "Ace"]

  attr_accessor :deck

  def initialize
    @deck = []
    make_deck
    # display_deck
  end

  def make_deck
    SUITS.each do |suit|
      NUMBERS.each do |num|
        deck << Card.new(num, suit)
      end
    end
  end

  def display_size
    p deck.size
  end

  def display_deck
    deck.each do |card|
      puts card
    end
  end

  def deal
    current_card = deck.sample
    # p current_card
    remove_from_deck(current_card)
    current_card
  end

  def remove_from_deck(card)
    @deck = @deck - [card]
  end
end

class Card
  VALUES = {
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "Jack" => 10,
    "Queen" => 10,
    "King" => 10,
    "Ace" => 1
  }
  attr_reader :number, :suit, :value, :card

  def initialize(number, suit)
    @number = number
    @suit = suit
    @card = [number, suit]
    @value = VALUES[number]
  end

  def to_s
    "#{@number}"
  end
end

class Game
  attr_reader :dealer, :player, :deck

  def initialize
    @dealer = Dealer.new
    @player = Player.new
    @deck = Deck.new
  end

  def start
    #deck.display_size
    deal_cards
    #deck.display_size
    show_cards
    player_turn
    if dealer_winner?
      show_result
      #play_again?
    else
    #deck.display_size
      dealer_turn
      show_result
      #play_again?
    end
  end

  def show_cards
    puts "You have:"
    player.display_cards
    puts "#{dealer.name} has:"
    dealer.display_initial_cards
  end

  def deal_cards
    2.times do
      player.hand << deck.deal
    end
    2.times do
      dealer.hand << deck.deal
    end
  end

  def player_turn
    loop do
      puts "You have a total of: #{player.total}"
      if player.busted?
        puts "You busted!"
        break
      end
      puts "Would you like to hit (h) or stay (s)?"
      answer = gets.chomp.downcase
      if answer[0] == 'h'
        clear
        player.hit(deck.deal)
        show_cards

      elsif answer[0] == 's'
        puts "You have a total of: #{player.total}"
        break
      else
        puts "Invalid choice, please use 'h' for hit or 's' for stay."
      end
    end
    show_cards
  end

  def dealer_turn
    loop do
      puts "Dealer has:"
      dealer.display_initial_cards
      if dealer.busted?
        puts "Dealer busted!"
        break
      end
      if dealer.total < 17
        dealer.hit(deck.deal)
        puts "Dealer hit"
      elsif dealer.total >= 17
        break
      end
    end
    puts "Dealer's secret card was: #{dealer.hand[0].value}"
  end

  def clear
    system "clear"
  end

  def show_result
    if dealer.busted?
      puts "You won!"
    elsif player.busted?
      puts "Dealer won!"
    elsif player.total > dealer.total
      puts "You won!"
    elsif player.total < dealer.total
      puts "Dealer won!"
    else
      puts "It's a tie!"
    end
  end

  def dealer_winner?
    player.busted?
  end
end

Game.new.start

