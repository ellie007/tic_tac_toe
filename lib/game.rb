class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "

  CURRENT_PLAYER_TURN = "'s Turn: "

  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to "
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."

  CURRENT_PLAYER_WON = " Won!"
  TIE = "It is a tie game."

  attr_accessor :board, :winner, :sum, :size, :play_again

  def initialize(board, ai, io, menu, player_1, player_2)
    @board = board
    @ai = ai
    @player_1 = player_1
    @player_2 = player_2
    @io = io
    @menu = menu
    @size = board.size
    @play_again = true
    @current_player = @player_1
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
      break if winner? || is_tie?
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

  def calculate_sum(cell)
     @sum += 1 if cell == @current_player.token
  end

  def set_winner
    @winner = @current_player.token if @sum == @size
    @winner
  end

  def winner?
    row_winner || column_winner || principal_diagonal_winner || counter_diagonal_winner if @winner.nil?
  end

  def row_winner
    split_board = []
    @board.cells.each_slice(size) { |row| split_board << row }
    row_column_win_checker(split_board)
  end

  def column_winner
    column_win_possibilities = []
    @board.cells.each_slice(size) { |row| column_win_possibilities << row }
    split_board = column_win_possibilities.transpose
    row_column_win_checker(split_board)
  end

  def row_column_win_checker(split_board)
     split_board.each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == @size
    end
    set_winner
  end

  def principal_diagonal_winner
    indicies= []
    i = 0
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        indicies << index + i
        i += 1
      end
    end
    diagonal_win_checker(indicies)
  end

  def counter_diagonal_winner
    indicies = []
    i = @size - 1
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        indicies << index + i
        i -= 1
      end
    end
    diagonal_win_checker(indicies)
  end

  def diagonal_win_checker(indicies)
    @sum = 0
    indicies.each do |cell|
      @sum += 1 if @board.cells[cell] == @current_player.token
    end
    set_winner
  end

  def is_tie?
    @winner == nil && @board.cells.select { |cell| cell == nil }.empty?
  end

  def winner_display
    @io.display_board
    @io.output_message @current_player.name + CURRENT_PLAYER_WON unless is_tie?
    @io.output_message TIE if is_tie?
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
