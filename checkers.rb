require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'piece.rb'

class Checkers

  def initialize(player1, player2)
    @player1 = Player.new(player1, :red) #REV: storing your players in a hash 
                                        # with their colors as keys 
                                        # makes it much easier to switch 
                                        # between them
    @player2 = Player.new(player2, :white)
    @turn = :red
    @board = Board.new
    play_game
  end

  def play_game
    #ask for input
    #make move
    #repeat until win
    win = false  # win is easy to implement. just see if board has an empty
                 # array of a single color
    until win
      @board.display_board
      if @turn == :red
        move = @player1.input_move
        @turn = :white
      else
        move = @player2.input_move
        @turn = :red
      end

      @board.perform_move(move)
      @board.display_board
    end
  end
  #REV: nice short play_game method, and excellent short checkers class!

end

game = Checkers.new('player1', 'player2')
