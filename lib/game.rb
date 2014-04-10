class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "

  WELCOME = "Welcome to Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "
  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."
  TIE = "It is a tie game."
  WATSON_WON = "Watson Won!"
  YOU_WON = "You Won!"

  attr_accessor :board, :winner, :sum, :size


  def initialize(board, ai, player, io, size)
    @board = board
    @ai = ai
    @player = player
    @io = io
    @size = size
  end

  def run
    @io.output_message WELCOME
    @io.display_board
    game_loop
    winner_display
    #play_again
  end

  def game_loop
    until game_over do
      human_turn
      winner?
      break if game_over

      ai_turn
      winner?
    end
  end

  # def play_again
  #   response = @io.play_again PLAY_AGAIN
  #   if response == "y"
  #     new_game = 'ruby ./game_runner.rb'
  #   end
  # end

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
    row_winner || column_winner if @winner.nil?
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

  # def diagonal_winner
  #   @board.cells.each do |cell, index|
  #     if index %
  #   end
  #   @board.cells
  # end

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
