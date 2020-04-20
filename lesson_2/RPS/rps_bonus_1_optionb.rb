# 1. Keeping score: option B, score is a new class
#    Notes: class `Score` should collaborate with class `Human` and `Computer`
#    the way class `Move` does

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won this round!"
      computer.score += 1
    else
      puts "This round is a tie!"
    end
  end

  def display_final_winner
    if human.score > computer.score
      puts "#{human.name} is the final winner"
    elsif human.score < computer.score
      puts "#{computer.name} is the final winner"
    end
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
      while human.score < Score::SCORE_FOR_WIN &&
        computer.score < Score::SCORE_FOR_WIN do
        human.choose
        computer.choose
        display_moves
        display_winner
      end
      display_final_winner
      if play_again?
        human.score = 0
        computer.score = 0
      else
        display_goodbye_message
        break
      end
    end
  end
end

class Score
  SCORE_FOR_WIN = 2
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    # @move = nil, will be initialized to `nil` automatically
    @score = 0
    set_name
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
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['computer_1', 'computer_2', 'computer_3'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

RPSGame.new.play

# Create `Score` class, add constant `SCORE_FOR_WIN`, set to some integer. Add
# @score (set to 0) to initialize method in `Player` class and `attr_accessor`
# for `:score`. In `display_winner` method in `RPSGame` class, add 1 to
# `human.score` or `computer.score` depending on which won. In `play` method
# loop, create an inner while loop that continues while `human.score` and
# `computer.score` are less than `SCORE_FOR_WIN`. When conditions are met for
# while loop, call `display_final_winner` and `play_again?`. New method
# `display_final_winner` created where `human.score` is compared to
# `computer.score`. If `play_again?` returns true, reassign `human.score` and
# `computer.score` to 0, else display goodbye message and break out of outer
# loop.

# Main difference between having a class variable and a new class is that for
# the latter, you have to initialize an instance variable in a class that
# creates an object that can then call the getter or setter method for the
# instance variable. For the former, you can directly use the class variable for
# reassignment or comparison.

# For this assignment, I think a class variable is a more straightforward
# choice, because the program doesn't really do anything with the `Score` class,
# we are not creating any `Score` objects.