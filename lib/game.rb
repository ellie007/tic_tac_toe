class Game

  WELCOME = "Welcome to the Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "

  attr_accessor :board

  def initialize(board, ai, player)
    @board = board
    @player = player
    @ai = ai
  end

  def run
    puts WELCOME
    @board.display_board
    human_move
  end

  def human_move
    puts USER_TURN
    move = @player.make_move
    @board.fill_cell(move, @player.player_sign)
    #win?
    @board.display_board
    ais_move
  end

  def ais_move
    puts AI_TURN
    rand_move = @ai.find_move
    @board.fill_cell(rand_move, @ai.ai_sign)
    #win?
    @board.display_board
    human_move
  end

  def winner
    win_possibilities = [[0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8],[2,4,6]]

    exit

    win_possibilities.each do |set|
      sum = 0
      set.each do |cell|
        sum += @board.cells[cell]
        if sum == 3 || sum == -3
          if sum == 3
            return @ai.ai_sign
          elsif sum == -3
            return @player.player_sign
          end
        end
      end
    end
  end

end
