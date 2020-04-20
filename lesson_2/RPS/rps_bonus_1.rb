# 1. Keeping score: Play up to 10 points. Is score a new class or a state of an
#    existing class?
# Notes: Could add score as a class variable for RPSGame

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
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
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
      if play_again?
        @@score_computer = 0
        @@score_human = 0
      else
        display_goodbye_message
        break
      end
    end
  end

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
  attr_accessor :move, :name

  def initialize
    # @move = nil, will be initialized to `nil` automatically
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

# I made class variables `@@score_human` and `@@score_computer` inside the
# `RPSGame` class and modified their values inside the `display_winner` method.
# I created a new `add_score` method where the values of the two class variables
# were reset as needed by comparing `human.move` to `computer.move` with `>` or
# `<`. I modified the loop inside the `play` method so that there is an outer
# loop that will display the final winner and ask if play again (if yes, reset
# class score variables to 0, if no, display goodbye message and break out of
# loop). There is an inner `while` loop that checks that the two class score
# variables have values less than the given final win value. I added a `display_final_winner` method that compares the values of the `@@score_human` and `@@score_computer` and displays the final winner.