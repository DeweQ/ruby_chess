require_relative "piece"
require_relative "directional_piece"

module Chess
  # A bishop class.
  class Bishop < Piece
    include DirectionalPiece

    def initialize(color)
      super
      @symbol = "♝".colorize(color)
      @directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
    end
  end
end
