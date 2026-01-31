require_relative "piece"

# A knight class.
class Knight < Piece
  MAP = [[1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]].freeze
  def initialize(color)
    super(color)
    @symbol = "♞".colorize(color)
  end
  
  def check_move(move, board)
    possible_moves(move[:departure], board).include?(move[:destination])
  end
  
  def possible_moves(position, board)
    all_moves = MAP.map { |coords| [position[0] + coords[0], position[1] + coords[1]] }
    in_bounds = all_moves.select { |e| e[0].between?(0, 7) && e[1].between?(0, 7) }
    in_bounds.reject { |e| board.at(e)&.color == color }
  end
  
end
