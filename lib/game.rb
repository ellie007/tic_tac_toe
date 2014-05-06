class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "
  PLAY_AGAIN_REPROMPT = "Please enter only Y or N."

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
  end

  def run
    set_players
    @io.display_board
    game_loop
    winner_display
    play_again?
  end

  def play_again?
    play_again_input = @io.play_again_output PLAY_AGAIN

    until play_again_input == "y" || play_again_input == "n" do
      @io.output_message PLAY_AGAIN_REPROMPT
      play_again_input = gets.chomp.downcase
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
      break if winner? || is_tie?
      @io.display_board
      toggle_current_player
    end
  end

  def toggle_current_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
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
    if move.is_a?(String) && move.downcase == 'restart'
      restart_clear_board
    end
  end

  def restart
    (1..size**2).each do |move|
      @board.fill_cell(move, nil)
    end
    @io.clear_screen
  end

  def ai_turn
    move = @ai.find_move
    @io.output_message @current_player.name + CURRENT_PLAYER_TURN + "#{move}"
    @board.fill_cell(move, @current_player.token)
  end

  def calculate_sum(cell)
     @sum += 1 if cell == @current_player.token
  end

  def set_winner
    @winner = @current_player.token if @sum == @size
    @winner
  end

  def winner?
    if @winner.nil? && @board.dimension_type ==  2
      board = @board
      row_winner || column_winner || principal_diagonal_winner || counter_diagonal_winner
    elsif @winner.nil? && @board.dimension_type == 3
      row_winner_vertical_face ||
      column_winner_vertical_face ||
      principal_diagonal_vertical_face ||
      counter_diagonal_vertical_face
    end
  end

  def vertical_column_transpose
    board_1 = []
    @board.cells.each_slice(size**2) { |board| board_1 << board }

    boards = []
    i = 0
    size.times do
      board = []
      board_1.flatten(1).each_with_index do |cell, index|
        if index % size == i
          board << index
        end
      end
      boards << board
      i += 1
    end

    board_2 = []
    boards.each do |board|
      board.each_slice(size) { |board| board_2 << board }
    end

    @sum = 0
    board_2.each do |row|
      row.each do |index|

        @sum += 1 if @board.cells[index] == @current_player.token
      end
    end
    set_winner
  end

  def row_winner_vertical_face
    board_1 = []
    @board.cells.each_slice(size**2) { |board| board_1 << board }

    board_2 = []
    board_1.each do |board|
      row_subset = []
      board.each_slice(size) {|row| row_subset << row }
      board_2 << row_subset
    end

    board_2.flatten(1).each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == 3
    end
    set_winner
  end

  def column_winner_vertical_face
    board_1 = []
    @board.cells.each_slice(size**2) { |board| board_1 << board }

    board_2 = []
    board_1.each do |board|
      row_subset = []
      board.each_slice(size) {|row| row_subset << row }
      board_2 << row_subset
    end

    transposed_board = []
    board_2.each do |board|
      transposed_board << board.transpose
    end

    transposed_board.flatten(1).each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == 3
    end
    set_winner
  end

  def principal_diagonal_vertical_face
    board_1 = []
    @board.cells.each_slice(@size**2) { |board| board_1 << board }

    board_1.each do |board|
      @sum = 0
      i = 0
      board.each_with_index do |cell, index|
        if index % @size == 0
          @sum += 1 if board[index + i] == @current_player.token
          i += 1
        end
      end
      break if @sum == 3
    end
    set_winner
  end

  def counter_diagonal_vertical_face
    board_1 = []
    @board.cells.each_slice(@size**2) { |board| board_1 << board }

    board_1.each do |board|
      @sum = 0
      i = @size - 1
      board.each_with_index do |cell, index|
        if index % @size == 0
          @sum += 1 if board[index + i] == @current_player.token
          i -= 1
        end
      end
      break if @sum == 3
    end
    set_winner
  end

  def row_winner
    row_win_possibilities = []
    @board.cells.each_slice(size) { |row| row_win_possibilities << row }
    row_win_possibilities.each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == @size
    end
    set_winner
  end

  def column_winner
    column_win_possibilities = []
    board.cells.each_slice(size) { |row| column_win_possibilities << row }
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

  def principal_diagonal_winner
    diagonal = []
    i = 0
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        diagonal << index + i
        i += 1
      end
    end

    @sum = 0
    diagonal.each do |cell|
      @sum += 1 if @board.cells[cell] == @current_player.token
    end
    set_winner
  end

  def counter_diagonal_winner
    diagonal = []
    i = @size - 1
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        diagonal << index + i
        i -= 1
      end
    end

    @sum = 0
    diagonal.each do |cell|
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

 #private

  def valid_input?(move)
    (1..board.size**2).include?(move) && move != " "
  end

  def valid_cell?(move)
    @board.cells[move - 1] == nil
  end

  def invalid_input_response
    @io.output_message INVALID_INPUT + "#{board.size**2}"
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
