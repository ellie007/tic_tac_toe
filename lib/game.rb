class Game

  WELCOME = "Welcome to the Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "

  def initialize(board, player, ai)
    @board = board
    @player = player
    @ai = ai
  end

  def run
    puts WELCOME
    human_move
  end

  def human_move
    puts USER_TURN
    user_value = gets.chomp
    player_make_move(user_value)
    ais_move
  end

  def ais_move
    puts AI_TURN
    rand_move = ai_find_move
    @board.fill_cell(rand_move, ai_sign)
    human_move
  end

end
