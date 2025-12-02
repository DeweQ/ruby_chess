require_relative "piece"

# A bishop class.
class Bishop < Piece
  def initialize(color)
    super(color)
    @symbol = "♝".colorize(color)
  end
end
