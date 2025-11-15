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
end
