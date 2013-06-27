require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'piece.rb'

class Checkers

  def initialize(player1, player2)
    @player1 = Player.new(player1, :red)
    @player2 = Player.new(player2, :white)
    @turn = :red
    @board = Board.new
    play_game
  end

  def play_game
    #ask for input
    #make move
    #repeat until win
    win = false
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




end