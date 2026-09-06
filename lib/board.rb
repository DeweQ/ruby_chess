require "colorize"
require "json"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/king"
require_relative "pieces/queen"

module Chess
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
      @check_status = { status: "none" }
    end

    def valid_move?(move, current)
      piece = at(move[:departure])
      piece.instance_of?(move[:piece]) &&
        piece.color == current.color &&
        at(move[:destination]).class != King &&
        piece.check_move(move, self)
    end

    def move_piece(move)
      departure = move[:departure]
      destination = move[:destination]
      stash = at(destination)
      piece = @grid[departure[0]][departure[1]]
      set(destination, piece)
      set(departure, nil)
      stash
    end

    def rollback_move(move, stash)
      departure = move[:departure]
      destination = move[:destination]
      piece = at(destination)
      set(destination, stash)
      set(departure, piece)
    end

    def at(coordinates)
      @grid[coordinates[0]][coordinates[1]]
    end

    def in_bounds?(coordinates)
      coordinates.all? { |x| x.between?(0, 7) }
    end

    def display
      @grid.reverse.each.with_index { |row, i| puts build_board_line_display(row, i) }
      puts "   A B C D E F G H"
    end

    def self.from_json(string)
      data = JSON.parse(string)
      new(data.map { |x| x.map { |y| Piece.from_json(y) } })
    end

    def to_json(*_args)
      JSON.dump(@grid.map { |x| x.map(&:to_json) })
    end

    def figures
      result = {}
      @grid.each.with_index do |line, x|
        line.each.with_index do |cell, y|
          next unless cell

          result[[x, y]] = cell
          yield cell, [x, y] if block_given?
        end
      end
    end

    def calculate_check_status
      figures do |cell, coords|
        if cell.possible_moves(coords, self).any? do |moves|
          at(moves).instance_of?(King) && cell.color != at(moves).color
        end
          return cell.color == :white ? :black : :white
        end
      end
      :none
    end

    private

    def set(coordinates, piece)
      @grid[coordinates[0]][coordinates[1]] = piece
    end

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
end
