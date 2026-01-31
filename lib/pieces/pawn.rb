require_relative "piece"

# A pawn class.
class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol = "♟".colorize(color) # color == :white ? "♙" : "♟"
  end

  def check_move(move, board)
    possible_moves(move[:departure], board).include?(move[:destination])
  end

  def possible_moves(position, board)
    result = []
    direction = color == :white ? 1 : -1
    (1..2).each do |i|
      newpos = [position[0] + i * direction, position[1]]
      break unless board.at(newpos).nil?

      result << newpos
    end
    [-1, 1].each do |i|
      newpos = [position[0] + direction, position[1] + i]
      result << newpos if board.at(newpos)&.color != color
    end
    result
  end
end
