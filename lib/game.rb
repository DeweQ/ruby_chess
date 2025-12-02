require_relative "board"
require_relative "player"
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
    @current.input
  end

  def display
    puts <<-HEREDOC
        Ruby chess
        
    HEREDOC
    @board.display
    puts
  end
end
