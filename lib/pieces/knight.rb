require_relative "piece"
require_relative "delta_piece"

# A knight class.
class Knight < Piece
  include DeltaPiece
  def initialize(color)
    super
    @symbol = "♞".colorize(color)
    @deltas = [[1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]].freeze
  end
end
