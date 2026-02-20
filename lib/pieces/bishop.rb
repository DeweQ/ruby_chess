require_relative "piece"
require_relative "directional_piece"

# A bishop class.
class Bishop < Piece
  include DirectionalPiece
  def initialize(color)
    super(color)
    @symbol = "♝".colorize(color)
    @directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  end
end
