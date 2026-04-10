require "json"

module Chess
  # Player class. Player has own color, name, and input method
  class Player
    attr_reader :name, :color

    def initialize(name, color)
      @name = name
      @color = color
    end

    def input
      puts "Enter a move"
      gets.chomp
    end

    def to_json(*_args)
      JSON.dump({ name: @name, color: @color })
    end

    def self.from_json(string)
      data = JSON.parse(string)
      new(data["name"], data["color"].to_sym)
    end
  end
end
