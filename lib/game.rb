class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "

  CURRENT_PLAYER_TURN = "'s Turn: "

  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to "
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."

  CURRENT_PLAYER_WON = " Won!"
  TIE = "It is a tie game."

  attr_accessor :board, :winner, :sum, :size, :play_again, :current_player

  def initialize(board, ai, io, menu, players)
    @board = board
    @ai = ai
    @io = io
    @menu = menu
    @players = players

    @size = board.size
    @play_again = true
    @current_player = @players[0]
  end

  def run
    @io.display_board
    game_loop
    winner_display
    play_again?
  end

  def play_again?
    play_again_input = @io.play_again_output PLAY_AGAIN

    until play_again_input == "y" || play_again_input == "n" do
      play_again_input = @io.play_again_output PLAY_AGAIN
    end

    if play_again_input == "y"
      @play_again = true
      @io.clear_screen
    elsif play_again_input == "n"
      @play_again = false
    end

    @play_again
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
    current_player_index = @players.index(@current_player)
    next_player_index = (current_player_index + 1) % @players.size
    @current_player = @players[next_player_index]
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

  def winner?
    row_winner || column_winner || principal_diagonal_winner ||counter_diagonal_winner
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

  def valid_input?(move)
    (0..size**2).include?(move) && move != " "
  end

  def valid_cell?(move)
    @board.cells[move - 1] == nil
  end

  def invalid_input_response
    @io.output_message INVALID_INPUT + "#{@size}"
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
