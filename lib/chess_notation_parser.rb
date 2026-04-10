require_relative "pieces/piece"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/king"
require_relative "pieces/queen"

module Chess
  # Parsing long algebraic notation message to a hash containing a moving piece type, departure and
  # destination as matrix indexes.
  class ChessParser
    PIECE_ABBREVIATIONS = { "K" => King,
                            "Q" => Queen,
                            "N" => Knight,
                            "R" => Rook,
                            "B" => Bishop }.freeze
    NOTATION = /\A([BKNQR]?)([A-H][1-8])x?([A-H][1-8])([+#]?)\z/i.freeze

    def self.parse(message)
      message = message.upcase
      m = NOTATION.match(message)
      { piece: parse_piece(m[1]),
        departure: parse_location(m[2]),
        destination: parse_location(m[3]) }
    end

    def self.check?(message)
      NOTATION.match?(message)
    end

    def self.parse_piece(char)
      return Pawn if char == ""

      PIECE_ABBREVIATIONS[char]
    end

    def self.parse_location(location)
      coords = location.chars
      coords[0] = ("A".."H").to_a.index(coords[0])
      coords[1] = coords[1].to_i - 1
      coords.reverse
    end
  end
end
