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
    @current = current.nil? ? @whites : current
    @exit = false
    @commands = { "exit" => method(:enable_exit_flag),
                  "clear" => method(:clear_screen) }
  end

  def toggle_current
    @current = @current == @whites ? @blacks : @whites
  end

  def make_move
    input = verified_input
    case input[:type]
    when "move"
      @board.move_piece(input[:value])
      toggle_current
    when "command"
      execute_command(input[:value], input[:args])
    end
  end

  def verified_input
    loop do
      message = @current.input.downcase
      return { type: "move", value: ChessParser.parse(message) } if ChessParser.check?(message)

      return { type: "command", value: message } if command?(message)

      puts "Wrong input"
    end
  end

  def command?(message)
    @commands.include?(message)
  end

  def enable_exit_flag
    @exit = true
  end

  def clear_screen
    system "clear"
    # display
  end

  def execute_command(command, args = nil)
    return @commands[command].call(args) unless args.nil?

    @commands[command].call
  end

  def play
    loop do
      display
      make_move
      break if @exit
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
