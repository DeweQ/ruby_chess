require_relative "piece"

# A rook class.
class Rook < Piece
  def initialize(color)
    super(color)
    @symbol = "♜".colorize(color)
  end
end
