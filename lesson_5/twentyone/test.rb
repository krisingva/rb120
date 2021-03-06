require 'pry'

class Participant
  WINNING_SCORE = 21
  DEALER_STAY = 17
  attr_reader :name
  attr_accessor :hand

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
    # binding.pry
    number_of_aces = 0
    @hand.each do |card|
      number_of_aces += 1 if card.value == [1, 11]
    end
    total = 0
    if number_of_aces == 0
      @hand.each do |card|
        total += card.value
      end
    elsif number_of_aces > 0
      total = total_with_aces(number_of_aces)
    end
    total
  end

  def total_with_aces(num_aces)
    conv_to_eleven = 0
    total = 0
    hand_total = 0
    @hand.each do |card|
      if card.value == [1, 11]
        hand_total += 12
      else
        hand_total += card.value
      end
    end
    iterations = 2 * num_aces
    iterations.times do
      total = hand_total - (1 * num_aces) - (11 * conv_to_eleven)
      num_aces -= 1
      conv_to_eleven += 1
      break if num_aces < 0 || total <= WINNING_SCORE
    end
    total
  end

  def display_cards
    values = @hand.map do |card|
      if card.value == [1, 11]
        "an Ace (value of 1 or 11)"
      elsif ["King", "Queen", "Jack"].include?(card.number)
        "#{card.number} (value of 10)"
      else
        card.value
      end
    end
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

  def reset
    @hand = []
  end
end

class Player < Participant
  def initialize(player_name="You")
    super
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
      elsif card.value == [1, 11]
        "an Ace"
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
  NUMBERS = ["2", "3", "4", "5", "6", "7", "8", "9", "Jack", "Queen", "King", "Ace"]

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

  def reset
    @deck = []
    make_deck
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
    "Ace" => [1, 11]
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
    welcome_message
    loop do
      deck.display_size
      deal_cards
      player_turn
      if dealer_winner?
        show_result
        if play_again? == false
          reset
          break
        end
      else
        dealer_turn
        show_result
        if play_again? == false
          reset
          break
        end
      end
    end
  end

  def welcome_message
    prompt("Welcome to Twentyone!")
    prompt("Here are the rules:")
    prompt("The winning score is #{Participant::WINNING_SCORE}.")
    prompt("Anything over #{Participant::WINNING_SCORE} is a bust.")
    prompt("The player with the highest score wins.")
    prompt("An Ace can have a value of 1 or 11.")
    prompt("A King, Queen and a Jack all have a value of 10.")
    prompt("The dealer will stop hitting at #{Participant::DEALER_STAY}.")
    prompt("Press enter when you are ready to play!")
    gets.chomp
  end

  def show_dealer_cards
    prompt("#{dealer.name} has:")
    dealer.display_cards
  end

  def show_player_cards
    prompt("You have:")
    player.display_cards
  end

  def display_player_total
    prompt("You have a total of: #{player.total}")
  end

  def deal_cards
    clear
    prompt("Let's deal the cards")
    2.times do
      player.hand << deck.deal
    end
    2.times do
      dealer.hand << deck.deal
    end
  end

  def player_turn
    loop do
      if player.busted?
        player_busted
        break
      end
      show_player_cards
      display_player_total
      show_dealer_cards
      prompt("Would you like to hit (h) or stay (s)?")
      answer = gets.chomp.downcase
      if answer[0] == 'h'
        clear
        player.hit(deck.deal)
      elsif answer[0] == 's'
        display_player_total
        prompt("Press enter when you are ready for dealer's turn.")
        gets.chomp
        break
      else
        prompt("Invalid choice, please use 'h' for hit or 's' for stay.")
      end
    end
  end

  def dealer_turn
    clear
    loop do
      prompt("#{dealer.name} has:")
      dealer.display_cards
      if dealer.busted?
        dealer_busted
        break
      end
      if dealer.under?(dealer.total)
        dealer.hit(deck.deal)
        puts ""
        prompt("#{dealer.name} decided to hit ...")
        puts ""
      elsif dealer.equal_or_over?(dealer.total)
        break
      end
    end
    prompt("#{dealer.name} has a total of: #{dealer.total}")
    prompt("#{dealer.name}'s secret card was: #{dealer.hand[0].value}")
  end

  def player_busted
    display_player_total
    prompt("You busted!")
    puts ""
  end

  def dealer_busted
    prompt("#{dealer.name} busted!")
    puts ""
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

  def play_again?
    loop do
      prompt("Would you like to play again (y/n)?")
      answer = gets.chomp.downcase[0]
      if answer == 'y'
        reset
        return true
        break
      elsif answer == 'n'
        prompt("Thanks for playing Twentyone. Goodbye!")
        return false
        break
      else
        prompt("Invalid choice")
      end
    end
  end

  def reset
    player.reset
    dealer.reset
    deck.reset
  end
end

Game.new.start

