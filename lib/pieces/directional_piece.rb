require_relative "piece"

module Chess
  # A directional piece is a piece that moves in a few directions until ot reaches board end or another piece.
  module DirectionalPiece
    def possible_moves(position, board)
      moves = @directions.map { |dir| traverse_direction(dir, position, board) }
      moves.flatten(1).reject(&:empty?)
    end

    def traverse_direction(direction, position, board)
      result = []
      new_position = [direction, position].transpose.map(&:sum)
      while board.in_bounds?(new_position) && (board.at(new_position).nil? || board.at(new_position).color != @color)
        result << new_position
        break unless board.at(new_position).nil?

        new_position = [direction, new_position].transpose.map(&:sum)
      end
      result
    end
  end
end
