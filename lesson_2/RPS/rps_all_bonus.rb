# RPS Game using OOP design and implementing Bonus Features:
# 1. Keeping score
# I made class variables `@@score_human` and `@@score_computer` inside the
# `RPSGame` class and modified their values inside the `display_winner` method.
# I created a new `add_score` method where the values of the two class variables
# were reset as needed by comparing `human.move` to `computer.move` with `>` or
# `<`. I modified the loop inside the `play` method so that there is an outer
# loop that will display the final winner and ask if play again (if yes, reset
# class score variables to 0, if no, display goodbye message and break out of
# loop). There is an inner `while` loop that checks that the two class score
# variables have values less than the given final win value. I added a
# `display_final_winner` method that compares the values of the `@@score_human`
# and `@@score_computer` and displays the final winner.

# Comparing the two options (class variable for score vs. new class for score),
# it seems that the first option is simpler and thus better. The new class only
# creates additional code (an additional collaborator object with a single
# variable for points that can easily be managed as a class variable) and does
# not provide any benefits that I could see. I made a version of the class
# option (rps_bonus_1_optionb_revised.rb)

# 2. Add Lizard and Spock
# Add `lizard` and `spock` to `Move` class and add more conditions for
# determining the winner in `RPSGame` class.

# 3. Add a class for each move
# My implimentation of adding the 5 additional move classes did not improve the
# code. I created new Rock/Paper/Scissors/Lizard/Spock objects based on the
# choice made by player and saved that as the instance variable `@value` in the
# `Move` class. Each additional move class inherited from `Move` and was
# initialized with a `@pick` variable that points to the string object for the
# move picked. In essence this only extends the string object further away,
# instead of being able to access the string object as the `@value` variable in
# the `Move` class, we have assigned `@value` to a collaborator object of a
# different class and within that class we have another instance variable
# pointing to the string.

# 4. Keep track of a history of moves
# Keep track of moves in `Human` class for human and `Computer` class for
# computer. Add an instance variable `history` to the `initialize` method.
# `@history` points to an array that gets a new item each time the `choose`
# method is run. Output can be based on array index + 1 and array item:
# 1. rock
# 2. scissors
# and so on
# Display history after each game

# 5. Computer personalities
# This will be a good case for new subclasses, each computer will be a subclass
# of `Computer` class and the subclasses will each have their own `choose`
# method

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
    puts ">> Hi #{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts ">> We will play until one player reaches #{SCORE_FOR_WIN} points."
    puts ">> Today your are playing the computer #{computer.name}. Good luck!"
  end

  def display_goodbye_message
    puts ">> Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts ">> #{human.name} chose #{human.move.value.pick}."
    puts ">> #{computer.name} chose #{computer.name.move.value.pick}."
  end

  # rubocop:disable Metrics/AbcSize
  def add_score
    if human.move.value.beats(computer.name.move.value.pick)
      @@score_human += 1
    elsif human.move.value.gets_beaten(computer.name.move.value.pick)
      @@score_computer += 1
    end
  end

  def display_winner
    if human.move.value.beats(computer.name.move.value.pick)
      puts ">> #{human.name} won this round!"
    elsif human.move.value.gets_beaten(computer.name.move.value.pick)
      puts ">> #{computer.name} won this round!"
    else
      puts ">> This round is a tie!"
    end
  end
  # rubocop:enable Metrics/AbcSize

  def display_final_winner
    if @@score_human > @@score_computer
      puts ">> #{human.name} is the final winner"
    elsif @@score_human < @@score_computer
      puts ">> #{computer.name} is the final winner"
    end
  end

  def display_history
    puts ">> #{human.name} played the following moves:"
    human.history
    puts ">> #{computer.name} played the following moves:"
    computer.name.history
  end

  def play_again?
    answer = nil
    loop do
      puts ">> Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts ">> Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def clear
    puts "Please press enter when you are ready to continue."
    gets().chomp()
    system('clear') || system('cls')
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def play
    display_welcome_message

    loop do
      while @@score_computer < SCORE_FOR_WIN && @@score_human < SCORE_FOR_WIN
        human.choose
        computer.name.choose
        display_moves
        add_score
        display_winner
        clear
      end
      display_final_winner
      display_history
      if play_again?
        @@score_computer = 0
        @@score_human = 0
        system('clear') || system('cls')
      else
        display_goodbye_message
        break
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
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
end

class Rock < Move
  def initialize
    @pick = 'rock'
  end

  def beats(other_move)
    ['scissors', 'lizard'].include?(other_move)
  end

  def gets_beaten(other_move)
    ['paper', 'spock'].include?(other_move)
  end
end

class Paper < Move
  def initialize
    @pick = 'paper'
  end

  def beats(other_move)
    ['rock', 'spock'].include?(other_move)
  end

  def gets_beaten(other_move)
    ['scissors', 'lizard'].include?(other_move)
  end
end

class Scissors < Move
  def initialize
    @pick = 'scissors'
  end

  def beats(other_move)
    ['paper', 'lizard'].include?(other_move)
  end

  def gets_beaten(other_move)
    ['rock', 'spock'].include?(other_move)
  end
end

class Lizard < Move
  def initialize
    @pick = 'lizard'
  end

  def beats(other_move)
    ['paper', 'spock'].include?(other_move)
  end

  def gets_beaten(other_move)
    ['scissors', 'rock'].include?(other_move)
  end
end

class Spock < Move
  def initialize
    @pick = 'spock'
  end

  def beats(other_move)
    ['scissors', 'rock'].include?(other_move)
  end

  def gets_beaten(other_move)
    ['paper', 'lizard'].include?(other_move)
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
      puts "#{idx + 1}. #{item}"
    end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts ">> What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts ">> Must enter value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts ">> Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts ">> Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    @history << move.value.pick
  end
end

class Computer < Player
  def set_name
    self.name = [Computer1.new, Computer2.new, Computer3.new].sample
  end
end

class Computer1 < Computer
  def initialize
    @name = "Rocky"
    @history = []
  end

  def choose
    self.move = Move.new('rock')
    @history << move.value.pick
  end

  def to_s
    @name
  end
end

class Computer2 < Computer
  def initialize
    @name = "Star Trek Fanboy"
    @history = []
  end

  def choose
    self.move = Move.new(['spock', 'spock', 'spock', 'spock', 'lizard'].sample)
    @history << move.value.pick
  end

  def to_s
    @name
  end
end

class Computer3 < Computer
  def initialize
    @name = "Randy"
    @history = []
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    @history << move.value.pick
  end

  def to_s
    @name
  end
end

RPSGame.new.play
