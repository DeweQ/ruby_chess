require_relative "piece"
require_relative "directional_piece"

# A quen class.
class Queen < Piece
  include DirectionalPiece
  def initialize(color)
    super(color)
    @symbol = "♛".colorize(color)
    @directions = [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  end
end
