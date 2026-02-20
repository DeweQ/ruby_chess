require_relative "piece"
require_relative "delta_piece"

# A king class.
class King < Piece
  include DeltaPiece
  def initialize(color)
    super(color)
    @symbol = "♚".colorize(color)
    @deltas = [[-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0]].freeze
  end
end
