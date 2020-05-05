# Our code is looking good, but there's a little bit of redundant code in the
# main game loop. The code below has a pattern that seems ripe for extraction,
# can you see it?

# loop do
#   human_moves
#   break if board.someone_won? || board.full?

#   computer_moves
#   break if board.someone_won? || board.full?

#   clear_screen_and_display_board
# end

# It'd be nice to be able to introduce some notion of a "current player", and we
# could then remove the redundancy, like this:

# loop do
#   current_player_moves
#   break if board.someone_won? || board.full?
#   clear_screen_and_display_board if human_turn?
# end

# The trick is to alternate the "current player" after each turn. How can we do
# this?

# My answer: Initialize a class variable `@@turn` in TTTGame class and set it to
# 0. In `current_player_moves`, add 1 to `@@turn` and choose to return
# `human_moves` if `@@turn` is odd, else return `computer_moves`. Have
# `human_turn?` method that returns true if `@@turn` is even, else return false.

# LS:

# The first change we'll make is to introduce a new "state" in the game to keep
# track of who the current player is.

# class TTTGame
#   # ... rest of class omitted for brevity

#   def initialize
#     @board = Board.new
#     @human = Player.new(HUMAN_MARKER)
#     @computer = Player.new(COMPUTER_MARKER)
#     @current_marker = HUMAN_MARKER
#   end
# end

# Notice that we're calling the new state @current_marker. Since we already have
# two constants HUMAN_MARKER and COMPUTER_MARKER that differentiates between the
# two players, we can piggyback on that to determine who the current player is.
# If we keep track of the current marker, we should be able to decide who should
# take the next move.

# Next, let's implement the current_player_moves method. This method will just
# inspect the @current_marker instance variable and call either human_moves or
# computer_moves.

# def current_player_moves
#   if @current_marker == HUMAN_MARKER
#     human_moves
#   else
#     computer_moves
#   end
# end

# That looks reasonable enough. If it's currently the human's turn, call
# human_moves, otherwise call computer_moves. Next is the tricky part: don't
# forget to alternate the player!

# We can actually do this right in the same method, like this:

# def current_player_moves
#   if @current_marker == HUMAN_MARKER
#     human_moves
#     @current_marker = COMPUTER_MARKER
#   else
#     computer_moves
#     @current_marker = HUMAN_MARKER
#   end
# end

# This will ensure that after the move has been executed, the @current_marker
# state is set to the other player.

# Next, let's implement the human_turn? method. We only want to print the board
# and clear the screen when it's the player's turn. Otherwise we'll get extra
# unneeded output.

# def human_turn?
#   @current_marker == HUMAN_MARKER
# end

# Now that we have this method, we can also utilize it in our
# current_player_moves method as well.

# def current_player_moves
#   if human_turn?
#     human_moves
#     @current_marker = COMPUTER_MARKER
#   else
#     computer_moves
#     @current_marker = HUMAN_MARKER
#   end
# end

# The last thing we need to do is make sure to reset the @current_marker to
# whoever the first player is after the game is over. Otherwise, the current
# player may not be consistent if we play again.

# def reset
#   board.reset
#   @current_marker = HUMAN_MARKER
#   clear
# end

# Now this introduces a minor potential problem. Suppose we wanted to allow the
# computer to move first. If you didn't know the code well (or let's say you
# come back to it six months later), you might think that changing the
# @current_marker in the TTTGame#initialize method was enough. But it's very
# likely that you'd forget about the need to also make the same update in the
# TTTGame#reset method.

# Let's fix this by creating a new constant called FIRST_TO_MOVE and set that to
# HUMAN_MARKER. Then, in the initialize and reset methods, we'll set
# @current_marker to FIRST_TO_MOVE.

# class TTTGame
#   # ... rest of class omitted for brevity

#   FIRST_TO_MOVE = HUMAN_MARKER

#   def initialize
#     # ...
#     @current_marker = FIRST_TO_MOVE
#   end

#   def reset
#     # ...
#     @current_marker = FIRST_TO_MOVE
#   end
# end

# Now, if you want the computer to move first, just change FIRST_TO_MOVE!

require 'pry'

class Board
  attr_reader :squares
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
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

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
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

  def marked?
    marker != INIITIAL_MARKER
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
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
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
    @@turn = 0
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  @@turn = 0

  def human_turn?
    if @@turn.even?
      return true
    else
      return false
    end
  end

  def current_player_moves
    @@turn += 1
    @@turn.odd? ? human_moves : computer_moves
  end

  def play
    clear
    display_welcome_message
    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
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