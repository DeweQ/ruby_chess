require_relative "board"
require_relative "player"
require_relative "chess_notation_parser"
# Class controlling gameflow and manages users input
class Game
  def initialize(board = Board.new, white = Player.new("Whites", :white),
                 black = Player.new("Blacks", :black), current = nil)
    @board = board
    raise ArgumentError "White player must be of white color" unless  white.color == :white
    raise ArgumentError "Black player must be of black color" unless  black.color == :black

    @whites = white
    @blacks = black
    @current = current.nil? ? @whites : @blacks
  end

  def toggle_current
    @current = @current == @whites ? @blacks : @whites
  end

  def make_move
    message = ""
    loop do
      message = @current.input
      break if ChessParser.check?(message)

      puts "Wrong input"
    end

    move = ChessParser.parse(message)
    if @board.valid_move?(move, @current)
      @board.move_piece(move)
      toggle_current
    else
      puts "Invalid move"
    end
  end

  def play
    loop do
      display
      make_move
    end
  end

  def display
    puts <<-HEREDOC
        Ruby chess
      #{'  '}
      Current player: #{@current.name}
    HEREDOC
    @board.display
    puts
  end
end
