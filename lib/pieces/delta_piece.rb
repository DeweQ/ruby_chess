require_relative "piece"

# A delta is a piece that can move in a few spots relative to current position.
module DeltaPiece
  def possible_moves(position, board)
    reject_out_of_bounds(map_deltas(position)).reject { |e| board.at(e)&.color == color }
  end

  def map_deltas(position)
    @deltas.map { |coords| [coords, position].transpose.map(&:sum) }
  end

  def reject_out_of_bounds(moves)
    moves.select { |coords| coords[0].between?(0, 7) && coords[1].between?(0, 7) }
  end
end
