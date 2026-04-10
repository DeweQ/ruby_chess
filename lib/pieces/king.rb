require_relative "piece"
require_relative "delta_piece"

module Chess
  # A king class.
  class King < Piece
    include DeltaPiece

    def initialize(color)
      super
      @symbol = "♚".colorize(color)
      @deltas = [[-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0]].freeze
    end
  end
end
