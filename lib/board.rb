require "colorize"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/king"
require_relative "pieces/queen"

# Class containing game board and all pieces on it
class Board
  INITIAL_GRID = [[Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
                  [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn],
                  [nil, nil, nil, nil, nil, nil, nil, nil],
                  [nil, nil, nil, nil, nil, nil, nil, nil],
                  [nil, nil, nil, nil, nil, nil, nil, nil],
                  [nil, nil, nil, nil, nil, nil, nil, nil],
                  [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn],
                  [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]].freeze
  def self.generate_grid
    INITIAL_GRID.map.with_index do |row, index|
      row.map do |file|
        file&.new(index < 2 ? :white : :black)
      end
    end
  end

  def initialize(grid = Board.generate_grid)
    @grid = grid
  end

  def display
    @grid.reverse.each.with_index { |row, i| puts build_board_line_display(row, i) }
    puts "   A B C D E F G H"
    nil
  end

  private

  def build_board_line_display(row, row_index)
    result = "  #{8 - row_index}"
    row.each.with_index do |field, j|
      cell = field.nil? ? "  " : "#{field} "
      back = (row_index + j).odd? ? :magenta : :light_black
      result << cell.colorize(background: back)
    end
    result
  end
end
