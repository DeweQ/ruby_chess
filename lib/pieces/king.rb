require_relative "piece"

# A king class.
class King < Piece
  def initialize(color)
    super(color)
    @symbol = "♚".colorize(color)
  end
end
