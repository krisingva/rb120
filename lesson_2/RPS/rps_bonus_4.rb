# 4. Keep track of a history of moves

# As long as the user doesn't quit, keep track of a history of moves by both the
# human and computer. What data structure will you reach for? Will you use a new
# class, or an existing class? What will the display output look like?

# Notes: Keep track of moves in `Human` class for human and `Computer` class for
# computer. Add an instance variable `history` to the `initialize` method.
# `@history` points to an array that gets a new item each time the `choose`
# method is run. Output can be based on array index + 1 and array item:
# 1. rock
# 2. scissors
# and so on
# Display history after each game

class RPSGame
  SCORE_FOR_WIN = 2

  attr_accessor :human, :computer
  @@score_human = 0
  @@score_computer = 0

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move.value.pick}."
    puts "#{computer.name} chose #{computer.move.value.pick}."
  end

  def add_score
    if human.move > computer.move
      @@score_human += 1
    elsif human.move < computer.move
      @@score_computer += 1
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
    elsif human.move < computer.move
      puts "#{computer.name} won this round!"
    else
      puts "This round is a tie!"
    end
  end

  def display_final_winner
    if @@score_human > @@score_computer
      puts "#{human.name} is the final winner"
    elsif @@score_human < @@score_computer
      puts "#{computer.name} is the final winner"
    end
  end

  def display_history
    puts "#{human.name} played the following moves:"
    human.history
    puts "#{computer.name} played the following moves:"
    computer.history
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end


  def play
    display_welcome_message

    loop do
      while @@score_computer < SCORE_FOR_WIN && @@score_human < SCORE_FOR_WIN do
        human.choose
        computer.choose
        display_moves
        add_score
        display_winner
      end
      display_final_winner
      display_history
      if play_again?
        @@score_computer = 0
        @@score_human = 0
      else
        display_history
        display_goodbye_message
        break
      end
    end
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  attr_accessor :value, :pick

  def initialize(value)
    case value
    when 'rock'     then @value = Rock.new
    when 'paper'    then @value = Paper.new
    when 'scissors' then @value = Scissors.new
    when 'lizard'   then @value = Lizard.new
    when 'spock'    then @value = Spock.new
    end
  end

  def rock?
    @value.class == Rock
  end

  def scissors?
    @value.class == Scissors
  end

  def paper?
    @value.class == Paper
  end

  def lizard?
    @value.class == Lizard
  end

  def spock?
    @value.class == Spock
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
    (rock? && other_move.lizard?) ||
    (paper? && other_move.rock?) ||
    (paper? && other_move.spock?) ||
    (scissors? && other_move.paper?) ||
    (scissors? && other_move.lizard?) ||
    (lizard? && other_move.spock?) ||
    (lizard? && other_move.paper?) ||
    (spock? && other_move.rock?) ||
    (spock? && other_move.scissors?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
    (rock? && other_move.spock?) ||
    (paper? && other_move.scissors?) ||
    (paper? && other_move.lizard?) ||
    (scissors? && other_move.rock?) ||
    (scissors? && other_move.spock?) ||
    (lizard? && other_move.rock?) ||
    (lizard? && other_move.scissors?) ||
    (spock? && other_move.lizard?) ||
    (spock? && other_move.paper?)
  end

  # def to_s
  #   @value
  # end
end

class Rock < Move
  def initialize
    @pick = 'rock'
  end
end

class Paper < Move
  def initialize
    @pick = 'paper'
  end
end

class Scissors < Move
  def initialize
    @pick = 'scissors'
  end
end

class Lizard < Move
  def initialize
    @pick = 'lizard'
  end
end

class Spock < Move
  def initialize
    @pick = 'spock'
  end
end

class Player
  attr_accessor :move, :name, :pick, :history

  def initialize
    # @move = nil, will be initialized to `nil` automatically
    set_name
    @history = []
  end

  def history
    @history.each_with_index do |item, idx|
      puts "#{idx+1}. #{item}"
    end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Must enter value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    @history << self.move.value.pick
  end
end

class Computer < Player
  def set_name
    self.name = ['computer_1', 'computer_2', 'computer_3'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    @history << self.move.value.pick
  end
end

RPSGame.new.play
