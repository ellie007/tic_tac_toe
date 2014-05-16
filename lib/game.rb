class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "

  CURRENT_PLAYER_TURN = "'s Turn: "

  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to "
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."

  CURRENT_PLAYER_WON = " Won!"
  TIE = "It is a tie game."

  attr_accessor :board, :winner, :sum, :size, :play_again, :current_player


  def initialize(board, ai, io, menu, players, game_rules)
    @board = board
    @ai = ai
    @io = io
    @menu = menu
    @players = players
    @game_rules = game_rules

    @size = board.size
    @current_player = @players[0]
    @play_again = true

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

  def get_play_again_response
    play_again_input = @io.play_again_output PLAY_AGAIN

    until play_again_input == "y" || play_again_input == "n" do
      play_again_input = @io.play_again_output PLAY_AGAIN
    end
  end

  def set_play_again_response
    if play_again_input == "y"
      @play_again = true
      @io.clear_screen
    elsif play_again_input == "n"
      @play_again = false
    end
  end

  def make_move
    if @current_player.type == "ai"
      ai_turn
    elsif @current_player.type == "human"
      human_turn
    end
  end

  def game_loop
    until @game_rules.game_over do
      make_move
      @io.clear_screen
      break if @game_rules.winner? || @game_rules.is_tie?
      @io.display_board
      toggle_current_player
    end
  end

  def toggle_current_player
    current_player_index = @players.index(@current_player)
    next_player_index = (current_player_index + 1) % @players.size
    @current_player = @players[next_player_index]
  end

  def human_turn
    move = @io.player_input @current_player.name + CURRENT_PLAYER_TURN
    run if human_alternative_options(move)
    move = move.to_i
    if !valid_input?(move)
      invalid_input_response
      human_turn
    elsif !valid_cell?(move)
      invalid_cell_response
      human_turn
    else
      @board.fill_cell(move, @current_player.token)
    end
  end

  def human_alternative_options(move)
    if move.is_a?(String)
      if move.downcase == 'restart'
        clear_board
        return true
      elsif move.downcase == 'menu'
        @io.clear_screen
        menu_reset
        return true
      end
    end
  end

  def menu_reset
    @menu.get_options
    @board = Board.new(@menu.size)
    @ai = Ai.new(@board.cells)
    @io = CommandLine.new(@board)
    @size = @menu.size
  end

  def ai_turn
    move = @ai.find_move
    @io.output_message @current_player.name + CURRENT_PLAYER_TURN + "#{move}"
    @board.fill_cell(move, @current_player.token)
  end

  def set_winner
    @winner = @current_player.token if @game_rules.winner? == true
    @winner
  end

  def winner_display
    @io.display_board
    set_winner
    if @game_rules.winner?
      @io.output_message @current_player.name + CURRENT_PLAYER_WON
    elsif @game_rules.is_tie?
      @io.output_message TIE
    end
  end

  def invalid_input_response
    @io.output_message INVALID_INPUT + "#{size**2}"
    @io.display_board
  end

  def invalid_cell_response
    @io.output_message INVALID_CELL
    @io.display_board
  end


  private

  def get_play_again_response
    play_again_input = @io.play_again_output PLAY_AGAIN

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

  def clear_board
    (1..size**2).each do |move|
      @board.fill_cell(move, nil)
    end
    @io.clear_screen
  end

  def invalid_input_response
    @io.output_message INVALID_INPUT + "#{@size}"
    @io.display_board
  end

  def invalid_cell_response
    @io.output_message INVALID_CELL
    @io.display_board
  end

  def valid_input?(move)
    (1..size**2).include?(move)
  end

  def valid_cell?(move)
    @board.cells[move - 1] == nil
  end

end
