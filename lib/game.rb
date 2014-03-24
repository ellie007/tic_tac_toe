class Game

  WELCOME = "Welcome to the Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "

  def initialize(board, player, ai, player_sign, ai_sign)
    @board = board

    @player = player
    @ai = ai

    @turn = player_sign
    @ai_sign = ai_sign

    @turn = player_sign
  end

  def run
    puts WELCOME
    human_move
  end

  def human_move
    puts USER_TURN
    display_board
    user_value = gets.chomp
    player_make_move(user_value)
    ais_move
  end


  def ais_move
    puts AI_TURN


  end



end
