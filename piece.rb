# encoding: utf-8

class Piece
  attr_reader :color
  attr_accessor :king, :location

  def initialize(color,location, king= false)
    @color = color
    @location = location
    @king = king
  end

  def slide_moves(board, flag= false)
    moves = []
    if flag
      forward_dir = (color == :white) ? -1 : 1
      back_dir = (color == :white) ? 1 : -1
    else
      forward_dir = (color == :white) ? 1 : -1
      back_dir = (color == :white) ? -1 : 1
    end

    i,j = @location
    slides = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]
    if king == true
      slides << [i + back_dir, j - 1]
      slides << [i + back_dir, j + 1]
    end
    p slides
    slides.each do |new_location|
      next unless valid_pos?(new_location)

      if board[new_location[0]][new_location[1]].nil?
        moves << new_location
      end
    end
    moves
  end #slide_moves

  #returns an array of possible jump locations. note: need to restrict to 1
  #jump square
  def jump_moves(board)
    moves = jumper_helper(board) #array of squares that can be jumped
    jumps = []
    moves.each do |move|
      jump_piece = board[move[0]][move[1]]
      jumps = jump_piece.slide_moves(board, true)
    end
    jumps
  end #jump_moves

  #returns an array containing adjacent squares that can be jumped
  def jumper_helper(board)
    moves = []
    forward_dir = (color == :white) ? 1 : -1
    back_dir = (color == :white) ? -1 : 1
    i,j = @location
    slides = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]
    if king == true
      slides << [i + back_dir, j - 1]
      slides << [i + back_dir, j + 1]
    end
    slides.each do |new_location|
      next unless valid_pos?(new_location)
      moves << new_location unless board[new_location[0]][new_location[1]].nil?
    end
    moves
  end

  def make_king
    if color == :red
      @king = true if location[0] == 0
    else
      @king = true if location[0] == 7
    end
  end

  private

  #checks if a location is on the board
  def valid_pos?(location)
    location.all? {|p| p >= 0 && p <= 7}
  end

end #Piece