#class Board
  !Builds board
  !places pieces to start
  !prints board
  #perform_moves! - perform moves 1 by 1, should not reset board if
   move is invalid
  #valid_move_seq? - returns t/f should call perform_moves on a duped board.
   should be in a begin/rescue/else
  #perform_moves - calls perform_moves! & valid_move_seq?, either makes the s
   move or raises an error.

#class Piece
  !creates an object of the piece
  !is_king?
  #changes king flag to true
  !valid_pos? - checks if a location is on board
  #generates possible moves for the piece
    !slide_moves
    #jump_moves
  #performs move
    #illegal move should raise InvalidMoveError
    #perform_slide - validate move
    #perform_jump - validate move
    #move_sequence

#class Player