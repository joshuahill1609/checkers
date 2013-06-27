# encoding: utf-8
require 'colorize'
require './piece'

class Board
  BOARD_LENGTH = 8
  attr_accessor :rows, :pieces

  def initialize(fill_board = true)
    @pieces = []
    starting_board(fill_board)
  end

  #prints the board
  def display_board
    `clear`
    print "   "
    ('a'..'h').each {|c| print " #{c}  "} # print column headers
    print "\n"
    @rows.each_with_index do |row, row_ind|
      print "#{(row_ind - BOARD_LENGTH).abs}  " # print row numbers
      row.each_with_index do |elem, col_ind|
        if elem.nil?  # print empty squares
           print "    ".colorize(:background => ((col_ind+row_ind).odd? ? :black : :red))
        else # print pieces
          print "  ● ".colorize(:color => elem.color, :background => ((col_ind+row_ind).odd? ? :black : :red))
        end
      end
      puts ""
    end
    puts ""
  end

  #Takes a move in form ([1,0],[2,1]). Moves piece and deletes
  #jumped pieces.
  def perform_move(move)
    start_location = move[0]
    destination = move[1]
    i,j = start_location
    a,b = destination
    jumped = false
    #unless on_board?(destination)
    #raise error

    piece = @rows[i][j]
    all_possible_moves = piece.slide_moves(@rows) + piece.jump_moves(@rows)

    unless !all_possible_moves.include?(destination)#change to throw error

      jump = piece.jump_moves(@rows)
      if jump.include?(destination)
        jumped = true
        #removes jumped piece from board
        add = (piece.color == :white ?  -1 : 1)
        if destination[1] > start_location[1]
          middle_b = destination[1] - 1
          middle_a = destination[0] + add
          delete_piece = @rows[middle_a][middle_b]
          delete_piece.location = nil
          @rows[middle_a][middle_b] = nil
        else
          middle_b = destination[1] + 1
          middle_a = destination[0] + add
          delete_piece = @rows[middle_a][middle_b]
          delete_piece.location = nil
          @rows[middle_a][middle_b] = nil
        end
      end

      @rows[i][j] = nil
      piece.location = [a,b]
      @rows[a][b] = piece
    end
    #checks if moved piece should be kinged, if so sets king to true
    piece.make_king
    if jumped
      #go_again unless (@rows[a][b]).jump_moves(@rows).nil?
    end
  end #perform_move


  private

  #Initializes the board
  def starting_board(fill_board)
    @rows = Array.new(8) {Array.new(8)}

    if fill_board
      [:white, :red].each do |color|
        starting_pieces(color)
      end
    end
    set_pieces
  end #starting_board


  #Initializes 16 new Piece objects(8 white, 8 red) and
  #assigns a starting location. Called from starting_board.
  def starting_pieces(color)
    #8 pieces total
    i = (color == :white) ? [0,1] : [6,7]

    8.times do |j| #build back row pieces
      if (j+i[0]).odd?
        c = Piece.new(color, [i[0],j])
        @pieces << c
      end
    end

    8.times do |j| #build front row pieces
      if (j+i[0]).even?
        c = Piece.new(color, [i[1],j])
        @pieces << c
      end
    end
  end #starting_pieces

  #Assigns a piece to it's location on the board.
  #Called from starting_board.
  def set_pieces
    @pieces.each do |piece|
      y , x = piece.location
      @rows[y][x] = piece
    end
  end

  #checks if a location is on the board
  def on_board?(location)
    location.all? {|p| p >= 0 && p <= 7}
  end

end #class