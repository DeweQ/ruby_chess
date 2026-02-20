require_relative "piece"

# A bishop class.
class Bishop < Piece
  DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1]].freeze
  def initialize(color)
    super(color)
    @symbol = "♝".colorize(color)
  end

  def check_move(move, board)
    possible_moves(move[:departure], board).include?(move[:destination])
  end

  def possible_moves(position, board)
    moves = DIRECTIONS.map { |dir| traverse_direction(dir, position, board) }
    moves.flatten(1).reject(&:empty?)
  end

  def traverse_direction(direction, position, board)
    result = []
    new_position = [direction, position].transpose.map(&:sum)
    while in_bounds?(new_position) && (board.at(new_position).nil? || board.at(new_position).color != @color)
      result << new_position
      break unless board.at(new_position).nil?

      new_position = [direction, new_position].transpose.map(&:sum)
    end
    result
  end

  def in_bounds?(position)
    position.all? { |x| x.between?(0, 7) }
  end
end
