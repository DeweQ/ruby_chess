require_relative "pieces/piece"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/king"
require_relative "pieces/queen"
# Parsing long algebraic notation message to a hash containing a moving piece type, departure and
# destination as matrix indexes.
class ChessParser
  PIECE_ABBREVIATIONS = { "K" => King,
                          "Q" => Queen,
                          "N" => Knight,
                          "R" => Rook,
                          "B" => Bishop }.freeze

  def self.parse(message)
    move = {}
    message = message.upcase
    parse_piece(move, message)
    parse_departure(move, message)
    parse_destination(move, message)
    move
  end

  def self.parse_location(location)
    coords = location.chars
    coords[0] = ("A".."H").to_a.index(coords[0])
    coords[1] = coords[1].to_i - 1
    coords.reverse
  end

  def self.parse_destination(move, message)
    end_index = 2
    if message.include?("X")
      end_index = message.index("X") + 1
    else
      end_index += 1 unless move[:piece] == Pawn
    end
    location = message.slice(end_index, 2)
    move[:destination] = parse_location(location)
  end

  def self.parse_departure(move, message)
    start_index = move[:piece] == Pawn ? 0 : 1
    location = message.slice(start_index, 2)
    move[:departure] = parse_location(location)
  end

  def self.parse_piece(move, message)
    move[:piece] = PIECE_ABBREVIATIONS.fetch(message[0], Pawn)
    move[:piece] = Pawn if location?(message)
  end

  def self.location?(location)
    coords = location.chars
    ("A".."H").include?(coords[0]) && (1..8).include?(coords[1].to_i)
  end
end
