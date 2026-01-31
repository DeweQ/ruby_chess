require_relative "piece"

# A pawn class.
class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol =  "♟".colorize(color)  # color == :white ? "♙" : "♟" 
  end
  
  def check_move(move, board)
    #direction = @color == :white ? 1 : -1
    #departure = move[:departure]
    #destination = move[:destination]
    #((destination[0] - departure[0]).abs in (1..2)) && 
    #((destination[1] - departure[1]).abs < 2)
    possible_moves(move[:departure], board).include?(move[:destination])
  end
  
  def possible_moves(position, board)
    result = []
    direction = color == :white ? 1 : -1
    (1..2).each do | i |
      newpos = [position[0] + i * direction,position[1]]
      break unless board.at(newpos).nil?
      result << newpos
    end
    [-1,1].each do | i |
      newpos = [position[0] + direction, position[1] + i]
      result << newpos if board.at(newpos)&.color != color
    end
    result
  end
end
