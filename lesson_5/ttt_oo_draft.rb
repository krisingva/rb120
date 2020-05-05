class Player
  attr_accessor :board
end

class Human < Player
  def choose(board)
    loop do
      puts "Please pick from the available board positions:"
      p board.available_positions
      pick = gets.chomp.to_i
      if board.validate_choice(pick)
        board.change_values(pick, 'X')
        break
      else
        puts "That choice is not valid"
      end
    end

  end
end

class Computer < Player
  def choose(board)
    answer = board.available_positions.sample
    board.change_values(answer, 'O')
  end
end

class Board
  attr_accessor :board
  WIN_POSITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @board = {
      1 => " ",
      2 => " ",
      3 => " ",
      4 => " ",
      5 => " ",
      6 => " ",
      7 => " ",
      8 => " ",
      9 => " "
      }
  end

  def change_values(key, new_value)
    self.board[key] = new_value
  end

  def display_board
    puts "+ - - - - - +"
    puts "| #{board[1]} | #{board[2]} | #{board[3]} |"
    puts "| - | - | - |"
    puts "| #{board[4]} | #{board[5]} | #{board[6]} |"
    puts "| - | - | - |"
    puts "| #{board[7]} | #{board[8]} | #{board[9]} |"
    puts "+ - - - - - +"
  end

  def display_board_positions
    puts "+ - - - - - +"
    puts "| 1 | 2 | 3 |"
    puts "| - | - | - |"
    puts "| 4 | 5 | 6 |"
    puts "| - | - | - |"
    puts "| 7 | 8 | 9 |"
    puts "+ - - - - - +"
  end

  def available_positions
    board.select { |_, val| val == " " }.keys
  end

  def validate_choice(position)
    board[position] == " "
  end

  def winner?
    human_winner || computer_winner
  end

  def human_winner
    win = WIN_POSITIONS.select do |subarr|
      subarr.all? {|item| board[item] == 'X'}
    end
    win == [] ? false : true
  end

  def computer_winner
    win = WIN_POSITIONS.select do |subarr|
      subarr.all? {|item| board[item] == 'O'}
    end
    win == [] ? false : true
  end

  def declare_winner
    if human_winner
      puts "You won!"
    elsif computer_winner
      puts "Computer won!"
    end
  end
end

class GamePlay
  attr_accessor :game, :human, :computer


  def initialize
    @game = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome
    puts "Welcome to Tic Tac Toe"
    puts "You are 'X' and the computer is 'O'"
    puts "Here is the game board and the play positions:"
    game.display_board_positions
  end

  def play
    display_welcome
    until game.available_positions.empty? || game.winner? == true
      human.choose(game)
      computer.choose(game)
      game.display_board
    end
    game.declare_winner
  end
end

GamePlay.new.play


