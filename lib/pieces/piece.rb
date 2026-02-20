# Common ancestor class for all chess pieces. Has a color, a representing symbol and a method to check move.

require "colorize"
class Piece
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
  end

  def check_move(move, board)
    possible_moves(move[:departure], board).include?(move[:destination])
  end

  def to_s
    symbol
  end

  private

  attr_writer :symbol
end
