require_relative "piece"

module Chess
  # A pawn class.
  class Pawn < Piece
    def initialize(color)
      super
      @symbol = "♟".colorize(color) # color == :white ? "♙" : "♟"
      @direction = color == :white ? 1 : -1
    end

    def check_move(move, board)
      possible_moves(move[:departure], board).include?(move[:destination])
    end

    def possible_moves(position, board)
      result = advance_moves(position, board)
      result + attack_moves(position, board)
    end

    def attack_moves(position, board)
      result = []
      [-1, 1].each do |i|
        next unless board.in_bounds(newpos = [position[0] + direction, position[1] + i])

        result << newpos if board.at(newpos)&.color != color
      end
      result
    end

    def advance_moves(position, board)
      result = []
      (1..2).each do |i|
        next unless board.in_bounds(newpos = [position[0] + (i * @direction), position[1]])
        break unless board.at(newpos).nil?

        result << newpos
      end
      result
    end
  end
end
