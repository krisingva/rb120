# 5. Computer personalities

# We have a list of robot names for our Computer class, but other than the name,
# there's really nothing different about each of them. It'd be interesting to
# explore how to build different personalities for each robot. For example, R2D2
# can always choose "rock". Or, "Hal" can have a very high tendency to choose
# "scissors", and rarely "rock", but never "paper". You can come up with the
# rules or personalities for each robot. How would you approach a feature like
# this?

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

  def add_score
    if human.move > computer.name.move
      @@score_human += 1
    elsif human.move < computer.name.move
      @@score_computer += 1
    end
  end

  # rubocop:disable Metrics/AbcSize
  def display_winner
    if human.move > computer.name.move
      puts ">> #{human.name} won this round!"
    elsif human.move < computer.name.move
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

  # rubocop:disable Metrics/MethodLength
  def play
    display_welcome_message

    loop do
      while @@score_computer < SCORE_FOR_WIN && @@score_human < SCORE_FOR_WIN
        human.choose
        computer.name.choose
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
  # rubocop:enable Metrics/MethodLength
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

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
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
