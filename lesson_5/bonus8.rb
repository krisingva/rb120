# Allow the player to pick any marker.

# Create `Human` and `Computer` classes under `Player`. Instead of having
# `HUMAN_MARKER` and `COMPUTER_MARKER` constants, initialize `TTTGame` object
# with `@human_marker` and `@computer_marker` that point to `human_marker` and
# `computer_marker` respectively. When a player is initialized, ask human to
# pick marker from the two options and when a computer is initialized, assign
# the other marker.

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

  def empty_square_5?
    @squares[5].marker == Square::INITIAL_MARKER
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

  def computer_attack(player)
    pick = []
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_markers_in_line?(squares) == player
        line.each do |num|
          pick << num if @squares[num].marker == Square::INITIAL_MARKER
        end
      end
    end
    pick[0]
  end

  def computer_defense(opposite_player)
    pick = []
    WINNING_LINES.each do |line|
      #binding.pry
      squares = @squares.values_at(*line)
      if two_markers_in_line?(squares) == opposite_player
        line.each do |num|
          pick << num if @squares[num].marker == Square::INITIAL_MARKER
        end
      end
    end
    pick[0]
  end

  def determine_approach
    approach = []
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      approach << two_markers_in_line?(squares)
    end
    approach
  end

  def two_markers_in_line?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    return false if markers.uniq.size != 1
    markers.uniq[0]
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
  MARKERS = ["X", "O"]

  attr_reader :marker

end

class Human < Player
  def set_marker
    loop do
      puts "Which marker would you like to pick?"
      puts "Please choose between the letters 'X' and 'O'."
      answer = gets.chomp.upcase
      if MARKERS.include? answer
        @marker = answer
        puts "You are #{@marker}."
        break
      else
        puts "Invalid choice."
      end
    end
  end

  def set_name(name)
    puts "Please enter your name:"
    @name = gets.chomp.capitalize
  end

end

class Computer < Player

end

class TTTGame
  FIRST_TO_MOVE = "choose"
  # valid options for FIRST_TO_MOVE are: "choose", "human", "computer"
  POINTS_TO_WIN = 2

  @@human_total = 0
  @@computer_total = 0

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
  end

  # rubocop:disable Metrics/MethodLength
  def play
    clear
    display_welcome_message
    get_players
    loop do
      loop do
        who_goes_first?
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

  def get_players
    @human = Human.new
    @human_marker = human.set_marker
    @computer = Computer.new
    @computer_marker = (Player::MARKERS - [@human_marker])[0]
    @current_marker = nil
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "We will play rounds until a player has #{POINTS_TO_WIN} points."
  end

  def who_goes_first?
    if FIRST_TO_MOVE == "choose"
      loop do
        puts "Please choose who goes first: 'h' for human or 'c' for computer."
        answer = gets.chomp
        if answer == 'h'
          @current_marker = @human_marker
          break
        elsif answer == 'c'
          @current_marker = @computer_marker
          break
        else
          puts "Invalid choice."
        end
      end
    elsif FIRST_TO_MOVE == "human"
      @current_marker = @human_marker
    elsif FIRST_TO_MOVE == "computer"
      @current_marker = @computer_marker
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == @human_marker
  end

  def display_board
    puts "You're a #{@human_marker}. Computer is a #{@computer_marker}."
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

    board[square] = @human_marker
  end

  def computer_moves
    if board.determine_approach.include?(@computer_marker)
      board[board.computer_attack(@computer_marker)] = @computer_marker
    elsif board.determine_approach.include?(@human_marker)
      board[board.computer_defense(@human_marker)] = @computer_marker
    elsif board.empty_square_5?
      board[5] = @computer_marker
    else
      board[board.unmarked_keys.sample] = @computer_marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = @computer_marker
    else
      computer_moves
      @current_marker = @human_marker
    end
  end

  def update_total
    if board.winning_marker == @human_marker
      @@human_total += 1
    elsif board.winning_marker == @computer_marker
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
    when @human_marker
      puts "You won!"
    when @computer_marker
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
