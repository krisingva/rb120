# Get rid of `@value` from `Move` that points to `R/P/Sc/L/SP` objects, now when
# a `Move` object is initialized, it points directly to a `R/P/Sc/L/SP` object.

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
    puts ">> #{human.name} chose #{human.move.pick}."
    puts ">> #{computer.name} chose #{computer.name.move.pick}."
  end

  def determine_winner
    if human.move.beats(computer.name.move.pick)
      "human"
    elsif computer.name.move.beats(human.move.pick)
      "computer"
    end
  end

  def add_score
    if determine_winner == 'human'
      @@score_human += 1
    elsif determine_winner == 'computer'
      @@score_computer += 1
    end
  end

  def display_winner
    if determine_winner == 'human'
      puts ">> #{human.name} won this round!"
    elsif determine_winner == 'computer'
      puts ">> #{computer.name} won this round!"
    else
      puts ">> This round is a tie!"
    end
  end

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

  def play_round
    human.choose
    computer.name.choose
    display_moves
    add_score
    display_winner
    clear
  end

  def reset
    @@score_computer = 0
    @@score_human = 0
    system('clear') || system('cls')
  end

  def play
    display_welcome_message
    loop do
      while @@score_computer < SCORE_FOR_WIN && @@score_human < SCORE_FOR_WIN
        play_round
      end
      display_final_winner
      display_history
      play_again? ? reset : break
    end
    display_goodbye_message
  end
end

class Move
  attr_accessor :value, :pick, :human, :computer

end

class Rock < Move
  def initialize
    @pick = 'rock'
  end

  def beats(other_move)
    ['scissors', 'lizard'].include?(other_move)
  end
end

class Paper < Move
  def initialize
    @pick = 'paper'
  end

  def beats(other_move)
    ['rock', 'spock'].include?(other_move)
  end
end

class Scissors < Move
  def initialize
    @pick = 'scissors'
  end

  def beats(other_move)
    ['paper', 'lizard'].include?(other_move)
  end
end

class Lizard < Move
  def initialize
    @pick = 'lizard'
  end

  def beats(other_move)
    ['paper', 'spock'].include?(other_move)
  end
end

class Spock < Move
  def initialize
    @pick = 'spock'
  end

  def beats(other_move)
    ['scissors', 'rock'].include?(other_move)
  end
end

class Player

  XVALUES = { 'r' => Rock.new, 'p' => Paper.new,
    'sc' => Scissors.new, 'l' => Lizard.new,
    'sp' => Spock.new }

  attr_accessor :move, :name, :pick, :history

  def initialize
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
      puts ">> Please choose from:"
      puts ">> rock (r), paper (p), scissors (sc), lizard (l), or spock (sp)"
      choice = gets.chomp
      break if XVALUES.keys.include?(choice)
      puts ">> Sorry, invalid choice."
    end
    self.move = XVALUES[choice]
    @history << move.pick
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
    self.move = XVALUES['r']
    @history << move.pick
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
    self.move = XVALUES[['sp', 'sp', 'sp', 'sp', 'l'].sample]
    @history << move.pick
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
    self.move = XVALUES.values.sample
    @history << move.pick
  end

  def to_s
    @name
  end
end

RPSGame.new.play
