require "json"
require "colorize"

module Chess
  # Common ancestor class for all chess pieces. Has a color, a representing symbol and a method to check move.
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

    def to_json(*_args)
      JSON.dump({ class: self.class.name, color: @color })
    end

    def self.from_json(string)
      data = JSON.parse(string)
      Object.const_get(data["class"]).new(data["color"].to_sym) unless data.nil?
    end

    private

    attr_writer :symbol
  end
end
