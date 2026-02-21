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
    @commands = { "exit" => method(:terminate),
                  "clear" => method(:clear_screen) }
  end

  def toggle_current
    @current = @current == @whites ? @blacks : @whites
  end

  def evaluate(input)
    case input[:type]
    when "move"
      make_move(input[:value])
    when "command"
      execute_command(input[:value], input[:args])
    end
  end

  def make_move(move)
    if @board.valid_move?(move, @current)
      @board.move_piece(move)
      toggle_current
    else
      puts "Invalid move"
    end
  end

  def read
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

  def terminate(code = 0)
    exit(code.to_i)
  end

  def clear_screen
    system "clear"
  end

  def execute_command(command, args = nil)
    return @commands[command].call(args) unless args.nil?

    @commands[command].call
  end

  def play
    run_repl
  end

  def run_repl
    loop do
      display
      input = read
      evaluate(input)
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
