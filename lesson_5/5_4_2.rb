# The first time we display a board, we want to suppress the clearing of the
# screen. This is so we can see the welcome message, or the play again message.
# However, the method invocation, display_board(false) is incredibly vague. Six
# months from now, no one will remember what that false stands for without
# looking at the method implementation. Let's change the method so that we can
# invoke it like this: display_board(clear_screen: false).

# The method call should take a hash with a single key value pair (symbol as key
# and boolean as value) as an argument, so in the method definition for
# display_board, I will rename the parameter from `to_clear = true` to `hash`
# and on the first line of the method defintion change the if statement to `if
# hash.values == [false]`

# This solution gives an error message when display_board is called with no
# argument.

# LS solution:
# Define the display_board method to take a default value of true for the
# keyword argument clear_screen:

# def display_board(clear_screen: true)
#   clear if clear_screen

#   # ... rest of method omitted for brevity
# end
# Note that when we invoke the method, we can do any of the following:

# method invocation:
# display_board
# effect:
# clear_screen will be set to the default value true
# method invocation:
# display_board(clear_screen: false)
# effect:
# clear_screen value will be set to false
# method invocation:
# display_board clear_screen: false
# effect:
# same effect as above, despite the missing ()

# Now that we can call display_board(clear_screen: false), we stand a much
# better chance at remembering what this method does in the future. The code is
# almost self documenting.

# This solution actually uses a keyword in the method definition:
# if you do want to call a method with keyword arguments, then you have to use a
# particular syntax. You can't just call, display(true), you have to pass in a
# hash (either explicit or implicit). The values in that hash are automatically
# assigned to the parameters in your method signature that match your hash keys


require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end
  # returns winning marker or nil
  def detect_winner
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end
end

class Square
  INIITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INIITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INIITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_board(clear_screen: true)
    clear if clear_screen
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_result
    display_board

    case board.detect_winner
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board(clear_screen: false)
      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        display_board
      end
      display_result
      break unless play_again?
      board.reset
      clear
      puts "Let's play again!"
      puts ""
    end
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play