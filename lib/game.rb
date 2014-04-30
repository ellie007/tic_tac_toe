class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "

  CURRENT_PLAYER_TURN = "'s Turn: "

  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."

  CURRENT_PLAYER_WON = " Won!"
  TIE = "It is a tie game."

  attr_reader :current_player
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
  end

  def run
    set_players
    @io.display_board
    game_loop
    winner_display
    play_again?
  end

  def play_again?
    play_again_input = @io.play_again PLAY_AGAIN
    until play_again_input == "y" || play_again_input == "n" do
      play_again_input = @io.play_again PLAY_AGAIN
    end

    if play_again_input == "y"
      @play_again = true
      @io.clear_screen
    elsif play_again_input == "n"
      @play_again = false
    end

    @play_again
  end

  def set_current_player
    case @menu.turn_response
    when nil
    @current_player = @player_1
    when 1
    @current_player = @player_1
    when 2
    @current_player = @player_2
    end
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
      break if is_winner || is_tie?
      @io.display_board
      toggle_current_player
    end
  end

  def toggle_current_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def human_turn
    move = @io.player_input @current_player.name + CURRENT_PLAYER_TURN
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

  def is_winner
    if @winner.nil? && @menu.dimension_response == 2
      board = @board.cells
      row_winner(board) ||
        column_winner(board) ||
        principal_diagonal_winner(board) ||
        counter_diagonal_winner(board)
    elsif @winner_displaynner.nil? && @menu.dimension_response == 3
      board = @board.cells
      row_winner(board) ||
      vertical_side_row(board)
    end
  end

  def row_winner(board)
    row_win_possibilities = []
    board.each_slice(size) { |row| row_win_possibilities << row }
    row_win_possibilities.each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == @size
    end
    set_winner
  end

  def column_winner(board)
    column_win_possibilities = []
    board.each_slice(size) { |row| column_win_possibilities << row }
    transposed_win_possibilties = column_win_possibilities.transpose
    transposed_win_possibilties.each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == @size
    end
    set_winner
  end

  def principal_diagonal_winner(board)
    diagonal = []
    i = 0
    board.each_with_index do |cell, index|
      if index % @size == 0
        diagonal << index + i
        i += 1
      end
    end

    @sum = 0
    diagonal.each do |cell|
      @sum += 1 if board[cell] == @current_player.token
    end
    set_winner
  end

  def counter_diagonal_winner(board)
    diagonal = []
    i = @size - 1
    board.each_with_index do |cell, index|
      if index % @size == 0
        diagonal << index + i
        i -= 1
      end
    end

    @sum = 0
    diagonal.each do |cell|
      @sum += 1 if board[cell] == @current_player.token
    end
    set_winner
  end

  def vertical_side_row(board)
    i = 0
    j = 1
    greater_array = []
      (size**2).times do
        size.times do
          greater_array << board[i]
          i += (size**2)
        end
        i = j
        j += 1
      end
    row_winner(greater_array)
  end

  def is_tie?
    @winner == nil && @board.cells.select { |cell| cell == nil }.empty?
  end

  def winner_display
    @io.display_board
    @io.output_message @current_player.name + CURRENT_PLAYER_WON unless is_tie?
    @io.output_message TIE if is_tie?
  end

# private

  def valid_input?(move)
    (0..size**2).include?(move) && move != " "
  end

  def valid_cell?(move)
    @board.cells[move - 1] == nil
  end

  def invalid_input_response
    @io.output_message INVALID_INPUT
    @io.display_board
  end

  def invalid_cell_response
    @io.output_message INVALID_CELL
    @io.display_board
  end

  def game_over
    @winner != nil || is_tie?
  end

end
