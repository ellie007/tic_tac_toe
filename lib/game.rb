class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "
  PLAY_AGAIN_REPROMPT = "Please enter only Y or N."

  WELCOME = "Welcome to Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "
  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."
  TIE = "It is a tie game."
  WATSON_WON = "Watson Won!"
  YOU_WON = "You Won!"

  attr_accessor :board, :winner, :sum, :size, :play_again

  def initialize(board, ai, player, io, size, menu)
    @board = board
    @ai = ai
    @player = player
    @io = io
    @size = size
    @play_again = true
    @menu = menu
  end

  def run1
    @io.output_message WELCOME
    @io.display_board
    game_loop1
    winner_display
  end

  def run
    @io.display_board
    game_loop2
    winner_display
    play_again?
  end

  def play_again?
    @io.same_line PLAY_AGAIN
    play_again_input = gets.chomp.downcase

    until play_again_input == "y" || play_again_input == "n" do
      puts PLAY_AGAIN_REPROMPT
      play_again_input = gets.chomp.downcase
    end

    if play_again_input == "y"
      @play_again = true
    elsif play_again_input == "n"
      @play_again = false
    end

    return @play_again
  end

  def game_loop1
    until game_over do
      human_turn
      winner?
      break if game_over

      ai_turn
      winner?
    end
  end

  def game_loop2
    until game_over do
      ai_turn
      winner?
      break if game_over

      human_turn
      winner?
    end
  end

  def human_turn
    move = @io.player_input USER_TURN
    if !valid_input?(move)
      invalid_input_response
      human_turn
    elsif !valid_cell?(move)
      invalid_cell_response
      human_turn
    else
      @board.fill_cell(move, @player.token)
      @io.display_board
    end
  end

  def ai_turn
    move = @ai.find_move
    @io.output_message AI_TURN + "#{move}"
    @board.fill_cell(move, @ai.token)
    @io.display_board
  end

  def calculate_sum(cell)
     @sum += 1 if cell == @ai.token
     @sum -= 1 if cell == @player.token
  end

  def set_winner
    @winner = @ai.token if @sum == @size
    @winner = @player.token if @sum == -@size
    @winner
  end

  def winner?
    row_winner || column_winner || principal_diagonal_winner || counter_diagonal_winner if @winner.nil?
  end

  def row_winner
    row_win_possibilities = []
    @board.cells.each_slice(size) { |row| row_win_possibilities << row }
    row_win_possibilities.each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == @size || @sum == -@size
    end
    set_winner
  end

  def column_winner
    column_win_possibilities = []
    @board.cells.each_slice(size) { |row| column_win_possibilities << row }
    transposed_win_possibilties = column_win_possibilities.transpose
    transposed_win_possibilties.each do |row|
      @sum = 0
      row.each do |cell|
        calculate_sum(cell)
      end
      break if @sum == @size || @sum == -@size
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
      @sum += 1 if @board.cells[cell] == @ai.token
      @sum -= 1 if @board.cells[cell] == @player.token
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
      @sum += 1 if @board.cells[cell] == @ai.token
      @sum -= 1 if @board.cells[cell] == @player.token
    end
    set_winner
  end

  def is_tie?
    @winner == nil && @board.cells.select { |cell| cell == nil }.empty?
  end

  def winner_display
    @io.output_message WATSON_WON if @winner == @ai.token
    @io.output_message YOU_WON if @winner == @player.token
    @io.output_message TIE if is_tie?
  end


 #private

  def valid_input?(move)
    (0..size**2).include?(move)
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
