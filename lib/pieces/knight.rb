require_relative "piece"

# A knight class.
class Knight < Piece
  DELTAS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]].freeze
  def initialize(color)
    super
    @symbol = "♞".colorize(color)
  end

  def check_move(move, board)
    possible_moves(move[:departure], board).include?(move[:destination])
  end

  private

  def possible_moves(position, board)
    reject_out_of_bounds(map_deltas(position)).reject { |e| board.at(e)&.color == color }
  end

  def map_deltas(position)
    DELTAS.map { |coords| [position[0] + coords[0], position[1] + coords[1]] }
  end

  def reject_out_of_bounds(moves)
    moves.select { |coords| coords[0].between?(0, 7) && coords[1].between?(0, 7) }
  end
end
