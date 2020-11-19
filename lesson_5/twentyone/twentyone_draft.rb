require 'pry'

class Participant
  WINNING_SCORE = 21
  DEALER_STAY = 17
  attr_reader :name, :hand

  def initialize(player_name)
    @name = player_name
    @hand = []
  end

  def hit(card)
    @hand << card
  end

  def busted?
    total > WINNING_SCORE
  end

  def total
    total = 0
    @hand.each do |card|
      total += card.value
    end
    total
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
end

class Player < Participant
  def initialize
    puts "What is your name?"
    super(gets.chomp.capitalize)
  end
end

class Dealer < Participant
  attr_reader :hand, :name

  def initialize(player_name="Card Master")
    super
  end

  def display_cards
    values = @hand.map.with_index do |card, idx|
      if idx == 0
        "secret card"
      else
        card.value
      end
    end
    # binding.pry
    puts joinor(values, ", ", "and")
  end

  def under?(num)
    num < DEALER_STAY
  end

  def equal_or_over?(num)
    num >= DEALER_STAY
  end
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

  def prompt(message)
    puts ">> #{message}"
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
    prompt("You have:")
    player.display_cards
    prompt("#{dealer.name} has:")
    dealer.display_cards
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
      prompt("You have a total of: #{player.total}")
      if player.busted?
        prompt("You busted!")
        break
      end
      prompt("Would you like to hit (h) or stay (s)?")
      answer = gets.chomp.downcase
      if answer[0] == 'h'
        clear
        player.hit(deck.deal)
        player.display_cards
      elsif answer[0] == 's'
        prompt("You have a total of: #{player.total}")
        break
      else
        prompt("Invalid choice, please use 'h' for hit or 's' for stay.")
      end
    end
  end

  def dealer_turn
    loop do
      prompt("#{dealer.name} has:")
      dealer.display_cards
      if dealer.busted?
        prompt("#{dealer.name} busted!")
        break
      end
      if dealer.under?(dealer.total)
        dealer.hit(deck.deal)
        prompt("#{dealer.name} hit")
        dealer.display_cards
      elsif dealer.equal_or_over?(dealer.total)
        break
      end
    end
    prompt("#{dealer.name} has a total of: #{dealer.total}")
    prompt("#{dealer.name}'s secret card was: #{dealer.hand[0].value}")
  end

  def clear
    system "clear"
  end

  def show_result
    if dealer.busted?
      prompt("You won!")
    elsif player.busted?
      prompt("Dealer won!")
    elsif player.total > dealer.total
      prompt("You won!")
    elsif player.total < dealer.total
      prompt("Dealer won!")
    else
      prompt("It's a tie!")
    end
  end

  def dealer_winner?
    player.busted?
  end
end

Game.new.start

