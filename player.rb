class Player
  POSITIONS = Hash[('a'..'h').to_a.zip((0..7).to_a)]

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def input_move
    print "#{@color.capitalize}'s move (e.g. e6 f4): "
    input = gets.chomp.downcase.split(" ")
    move = process_move(input)
  end


  private

  def process_move(input)
    return input.first if input.include?("undo")
    moves = []

    input.each {|e| moves << e.split('')}
      moves.map {|y,x| [(x.to_i - POSITIONS.length).abs, POSITIONS[y]]}
  end

end