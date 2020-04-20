# 1. Keeping score: option B, score is a new class
#    Notes: class `Score` should collaborate with class `Human` and `Computer`
#    the way class `Move` does. In `Score` class have a constant that represents the points needed for a final win. Add attr_accessor method for `:score` in `Player` class and a `reset_score` method that will reset score to 0 when playing again (as determined in RPSGame `play` method). In `initialize` method of `Player` class, make @score be set to 0. Create new method `add_score` to RPSGame class and add 1 to `human.score` or `computer.score` as determined by comparing `human.move` to `computer.move`. Add a `display_final_winner`

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

  def add_score
    if human.move > computer.move
      human.score.points += 1
    elsif human.move < computer.move
      computer.score.points += 1
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
    elsif human.move < computer.move
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
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

  def display_final_winner
    if human.score.points > computer.score.points
      puts "#{human.name} is the final winner"
    elsif human.score.points < computer.score.points
      puts "#{computer.name} is the final winner"
    end
  end

  def play
    display_welcome_message
    loop do
      while human.score.points < Score::SCORE_FOR_WIN &&
        computer.score.points < Score::SCORE_FOR_WIN do
        human.choose
        computer.choose
        display_moves
        add_score
        display_winner
      end
      display_final_winner
      if play_again?
        human.reset_score
        computer.reset_score
      else
        display_goodbye_message
        break
      end
    end
  end
end

class Score
  attr_accessor :points

  SCORE_FOR_WIN = 1

  def initialize(points)
    @points = points
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
  attr_accessor :move, :name, :score

  def initialize
    # @move = nil, will be initialized to `nil` automatically
    @score = Score.new(0)
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

  def reset_score
    self.score.points = 0
  end
end

class Computer < Player
  def set_name
    self.name = ['computer_1', 'computer_2', 'computer_3'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end

  def reset_score
    self.score.points = 0
  end
end

RPSGame.new.play
