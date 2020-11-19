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
    number_of_aces = 0
    @hand.each { |card| number_of_aces += 1 if card.value == [1, 11] }
    total = 0
    if number_of_aces == 0
      @hand.each { |card| total += card.value }
    elsif number_of_aces > 0
      total = total_with_aces(number_of_aces)
    end
    total
  end

  # rubocop:disable Metrics/MethodLength
  def total_with_aces(num_aces)
    conv_to_eleven = 0
    total = 0
    hand_total = 0
    @hand.each do |card|
      hand_total += if card.value == [1, 11]
                      12
                    else
                      card.value
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
  # rubocop:enable Metrics/MethodLength

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
  NUMBERS = ["2", "3", "4", "5", "6", "7", "8", "9", "10"] +
            ["Jack", "Queen", "King", "Ace"]

  attr_accessor :deck

  def initialize
    @deck = []
    make_deck
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
    remove_from_deck(current_card)
    current_card
  end

  def remove_from_deck(card)
    @deck -= [card]
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
    "10" => 10,
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
      deal_cards
      player_turn
      dealer_turn if !(player.busted?)
      show_result
      break if !(play_again?)
      reset
    end
  end

  def welcome_message
    clear
    prompt("Welcome to Twentyone! Here are the rules")
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
    puts ""
    prompt("#{dealer.name} has:")
    dealer.display_cards
    puts ""
  end

  def show_player_cards
    puts ""
    prompt("You have:")
    player.display_cards
    puts ""
  end

  def display_player_total
    prompt("You have a total of: #{player.total}")
  end

  def display_dealer_total
    prompt("#{dealer.name} has a total of: #{dealer.total}")
  end

  def deal_cards
    clear
    prompt("Let's deal the cards:")
    puts ""
    2.times do
      player.hand << deck.deal
    end
    2.times do
      dealer.hand << deck.deal
    end
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
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
        # prompt("Press enter when you are ready for dealer's turn.")
        # gets.chomp
        break
      else
        prompt("Invalid choice, please use 'h' for hit or 's' for stay.")
      end
    end
  end

  def dealer_turn
    clear
    prompt("Dealers turn!")
    puts ""
    loop do
      prompt("#{dealer.name} has:")
      dealer.display_cards
      if dealer.busted?
        dealer_busted
        break
      end
      if dealer.under?(dealer.total)
        dealer_hits
      elsif dealer.equal_or_over?(dealer.total)
        dealer_stays
        break
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def dealer_hits
    dealer.hit(deck.deal)
    puts ""
    prompt("#{dealer.name} decided to hit ...")
    puts ""
  end

  def dealer_stays
    puts ""
    prompt("#{dealer.name} has a total of: #{dealer.total}")
    prompt("#{dealer.name}'s secret card was: #{dealer.hand[0].number}")
    puts ""
  end

  def player_busted
    puts ""
    display_player_total
    prompt("You busted!")
    puts ""
  end

  def dealer_busted
    puts ""
    display_dealer_total
    prompt("#{dealer.name} busted!")
    puts ""
  end

  def clear
    system "clear"
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def show_result
    if dealer.busted?
      prompt("#{player.name} won!")
    elsif player.busted?
      prompt("#{dealer.name} won!")
    elsif player.total > dealer.total
      prompt("#{player.name} won!")
    elsif player.total < dealer.total
      prompt("#{dealer.name} won!")
    else
      prompt("It's a tie!")
    end
  end
  # rubocop:enable Metrics/AbcSize

  def play_again?
    bool = nil
    loop do
      prompt("Would you like to play again (y/n)?")
      answer = gets.chomp.downcase[0]
      if answer == 'y'
        bool = true
        break
      elsif answer == 'n'
        prompt("Thanks for playing Twentyone. Goodbye!")
        bool = false
        break
      else
        prompt("Invalid choice")
      end
    end
    bool
  end
  # rubocop:enable Metrics/MethodLength

  def reset
    player.reset
    dealer.reset
    deck.reset
  end
end

Game.new.start
