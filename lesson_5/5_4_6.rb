# As we glance down the list of methods, it's surprising that we display the
# board in the TTTGame class. That seems like a responsibility of the Board
# class. We should be able to tell the board to "display yourself". Let's move
# the logic from display_board to Board#draw. We'll still keep the
# TTTGame#display_board method, though, because the TTTGame needs to tweak the
# output a little (eg, the marker prompt at the top, and the padding.)

# Move the display_board method body to Board#draw and inside there, call
# `#{self.get_square_at(key)}` to get the value for each square

# LS:
# class Board
#   # ... rest of class omitted for brevity

#   def draw
#     puts "     |     |"
#     puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
#     puts "     |     |"
#     puts "-----+-----+-----"
#     puts "     |     |"
#     puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
#     puts "     |     |"
#     puts "-----+-----+-----"
#     puts "     |     |"
#     puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
#     puts "     |     |"
#   end
# end

# Notice that the Board#draw method above won't contain any of the extra
# messages. Instead, we'll leave that in the original TTTGame#display_board
# method, which is below.

# class TTTGame
#   # ... rest of class omitted for brevity

#   def display_board
#     puts "You're a #{human.marker}. Computer is a #{computer.marker}."
#     puts ""
#     board.draw
#     puts ""
#   end
# end

# Now, the TTTGame#display_board just calls Board#draw. Why did we only move the
# board output to the Board#draw method, and not the extra information about the
# player and computer marker, and the extra puts "" before and after the display
# of the board? The answer has to do with organizing the code.

# Board#draw shouldn't know anything about player markers or extra padding. It
# should only be concerned with one thing: drawing the state of the board. You
# can almost think of this as the board's to_s method. It should be generic so
# that it can be used in a variety of yet unanticipated situations.

# TTTGame#display_board is where we're organizing all concerns related to
# presentation of the board in the Tic Tac Toe game flow. It's here that we know
# exactly what extra information we want in the context of a game.

require 'pry'

class Board
  attr_reader :squares
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
    !!winning_marker
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  # returns winning marker or nil
  def winning_marker
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

  def draw
    puts "     |     |"
    puts "  #{self.get_square_at(1)}  |  #{self.get_square_at(2)}  |  #{self.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{self.get_square_at(4)}  |  #{self.get_square_at(5)}  |  #{self.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{self.get_square_at(7)}  |  #{self.get_square_at(8)}  |  #{self.get_square_at(9)}"
    puts "     |     |"
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

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
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
    clear_screen_and_display_board

    case board.winning_marker
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

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def play
    clear
    display_welcome_message
    loop do
      display_board
      loop do
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play