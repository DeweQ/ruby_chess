require_relative "piece"

# A pawn class.
class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol =  "♟".colorize(color)  # color == :white ? "♙" : "♟" 
  end
end
