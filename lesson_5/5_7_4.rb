# Computer AI: Offense

# The defensive minded AI is pretty cool, but it's still not performing as well
# as it could because if there are no impending threats, it will pick a square
# at random. We'd like to make a slight improvement on that. We're not going to
# add in any complicated algorithm (there's an extra bonus below on that), but
# all we want to do is piggy back on our find_at_risk_square from bonus #3 above
# and turn it into an attacking mechanism as well. The logic is simple: if the
# computer already has 2 in a row, then fill in the 3rd square, as opposed to
# moving at random.

# Answer: Change `computer_move` in `TTTGame class`. Create an
# `activate_attack?` method in `Board` class that will determine if there are
# two computer marks in a winning line (using a new `two_computer_markers?`
# private method). The `two_computer_markers? will only return true if in a
# winning line there are only two squares that are marked with computer mark and
# an empty square. If `activate_attack?` returns true, call `computer_attack`
# that will also call `two_computer_markers?` and find the square that is empty.

require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

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

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def activate_defense?
    bool = false
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      bool = true if two_human_markers?(squares)
    end
    bool
  end

  def activate_attack?
    bool = false
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      bool = true if two_computer_markers?(squares)
    end
    bool
  end

  def computer_attack
    pick = []
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_computer_markers?(squares)
        line.each do |num|
          pick << num if @squares[num].marker == Square::INITIAL_MARKER
        end
      end
    end
    pick[0]
  end

  def computer_defense
    pick = []
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_human_markers?(squares)
        line.each do |num|
          pick << num if @squares[num].marker == Square::INITIAL_MARKER
        end
      end
    end
    pick[0]
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_human_markers?(squares)
    # binding.pry
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.uniq == [TTTGame::HUMAN_MARKER]
  end

  def two_computer_markers?(squares)
    # binding.pry
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.uniq == [TTTGame::COMPUTER_MARKER]
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
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
  FIRST_TO_MOVE = HUMAN_MARKER
  POINTS_TO_WIN = 2

  @@human_total = 0
  @@computer_total = 0

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  # rubocop:disable Metrics/MethodLength
  def play
    clear
    display_welcome_message

    loop do
      loop do
        display_board

        loop do
          current_player_moves
          break if board.someone_won? || board.full?
          clear_screen_and_display_board
        end

        update_total
        display_result
        if total_winner?
          display_total_winner
          reset_totals
          break
        end
        round_end_display
      end

      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def joinor(arr, sep = ", ", word = "or")
    if arr.size == 2
      "#{arr[0]} #{word} #{arr[1]}"
    elsif arr.size > 2
      "#{arr[0..-2].join(sep) + sep + word} #{arr[-1]}"
    else
      arr.join
    end
  end

  def human_moves
    puts "Choose a square: " + joinor(board.unmarked_keys, ', ')
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.activate_defense?
      puts "activated defense!"
      puts "press enter"
      gets.chomp
      board[board.computer_defense] = computer.marker
    elsif board.activate_attack?
      puts "activated attack!"
      puts "press enter"
      gets.chomp
      board[board.computer_attack] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def update_total
    if board.winning_marker == human.marker
      @@human_total += 1
    elsif board.winning_marker == computer.marker
      @@computer_total += 1
    end
  end

  def reset_totals
    @@human_total = 0
    @@computer_total = 0
  end

  def total_winner?
    @@human_total == POINTS_TO_WIN || @@computer_total == POINTS_TO_WIN
  end

  def display_total_winner
    if @@human_total == POINTS_TO_WIN
      puts "You've won the game with #{POINTS_TO_WIN} points!"
    elsif @@computer_total == POINTS_TO_WIN
      puts "Computer won the game with #{POINTS_TO_WIN} points!"
    end
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
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def round_end_display
    puts "You have #{@@human_total} points."
    puts "Computer has #{@@computer_total} points."
    puts "Press enter when you ready for the next round"
    gets.chomp
    reset
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
