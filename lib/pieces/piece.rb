# Common ancestor class for all chess pieces. Has a color, a representing symbol and a method to check move.

require "colorize"
class Piece
  attr_reader :color, :symbol

  def initialize(color)
    @color = color
  end

  def check_move(_move)
    raise "Unable to move abstract piece"
  end

  def to_s
    symbol
  end

  private

  attr_writer :symbol
end
