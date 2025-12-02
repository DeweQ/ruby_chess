require_relative "piece"

# A quen class.
class Queen < Piece
  def initialize(color)
    super(color)
    @symbol = "♛".colorize(color)
  end
end
