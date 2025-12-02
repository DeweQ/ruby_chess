require_relative "piece"

# A knight class.
class Knight < Piece
  def initialize(color)
    super(color)
    @symbol = "♞".colorize(color)
  end
end
