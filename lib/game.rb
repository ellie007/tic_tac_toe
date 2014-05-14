class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "

  CURRENT_PLAYER_TURN = "'s Turn: "

  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to "
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."

  CURRENT_PLAYER_WON = " Won!"
  TIE = "It is a tie game."

  attr_accessor :board, :winner, :sum, :size, :play_again, :current_player

  def initialize(board, ai, io, menu, player_1, player_2, game_rules)
    @board = board
    @ai = ai
    @player_1 = player_1
    @player_2 = player_2
    @io = io
    @menu = menu
    @size = board.size
    @play_again = true
    @current_player = @player_1
    @game_rules = game_rules
  end

  def run
    set_players
    @io.clear_screen
    @io.display_board
    game_loop
    winner_display
    play_again?
  end

  def play_again?
    @play_again_input = nil
    get_play_again_response
    set_play_again_response
    @play_again
  end

  def set_current_player
    @current_player = @player_2 if @menu.turn_response == 2
  end

  def set_players
    case @menu.game_type_response
    when 1
      @player_1.type = "human"
      @player_2.type = "human"
    when 2
      @player_1.type = "human"
      @player_2.type = "ai"
    when 3
      @player_1.type = "ai"
      @player_2.type = "ai"
    end
    token_and_name
    set_current_player
  end

  def token_and_name
    @player_1.name = @menu.player_one_name
    @player_1.token = @menu.player_one_token
    @player_2.name = @menu.player_two_name
    @player_2.token = @menu.player_two_token
  end

  def make_move
    if @current_player.type == "ai"
      ai_turn
    elsif @current_player.type == "human"
      human_turn
    end
  end

  def game_loop
    until game_over do
      make_move
      @io.clear_screen
      set_winner && break if winner? || is_tie?
      @io.display_board
      toggle_current_player
    end
  end

  def toggle_current_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def human_turn
    move = (@io.player_input @current_player.name + CURRENT_PLAYER_TURN).to_i
    if !valid_input?(move)
      invalid_input_response
      human_turn
    elsif !valid_cell?(move)
      invalid_cell_response
      human_turn
    else
      @board.fill_cell(move, @current_player.token)
      @io.display_board
    end
  end

  def ai_turn
    move = @ai.find_move
    @io.output_message @current_player.name + CURRENT_PLAYER_TURN + "#{move}"
    @board.fill_cell(move, @current_player.token)
    @io.display_board
  end

  def set_winner
    @winner = @current_player.token if winner? == true
    @winner
  end

  def winner?
    @game_rules.row_winner? ||
      @game_rules.column_winner? ||
      @game_rules.principal_diagonal_winner? ||
      @game_rules.counter_diagonal_winner?
  end

  def winner_display
    @io.display_board
    @io.output_message @current_player.name + CURRENT_PLAYER_WON unless is_tie?
    @io.output_message TIE if is_tie?
  end

  def is_tie?
    @winner == nil && @board.cells.select { |cell| cell == nil }.empty?
  end

  def game_over
    @winner != nil || is_tie?
  end

  def get_play_again_response
    until @play_again_input == "y" || @play_again_input == "n" do
      @play_again_input = (@io.player_input PLAY_AGAIN).downcase
    end
  end

  def set_play_again_response
    if @play_again_input == "y"
      @play_again = true
      @io.clear_screen
    elsif @play_again_input == "n"
      @play_again = false
    end
  end

  def valid_input?(move)
    (1..size**2).include?(move) && move != " "
  end

  def valid_cell?(move)
    @board.cells[move - 1] == nil
  end

  def invalid_input_response
    @io.output_message INVALID_INPUT + "#{size**2}"
    @io.display_board
  end

  def invalid_cell_response
    @io.output_message INVALID_CELL
    @io.display_board
  end

end
