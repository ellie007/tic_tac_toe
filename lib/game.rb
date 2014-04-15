class Game

  PLAY_AGAIN = "Would you like to play again (y/n)?: "
  PLAY_AGAIN_REPROMPT = "Please enter only Y or N."

  WELCOME = "Welcome to Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "
  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."
  TIE = "It is a tie game."
  # WATSON_WON = "Watson Won!"
  # YOU_WON = "You Won!"
  PLAYER_1_WON = "PLAYER ONE WON: " #+ @player_1.token
  PLAYER_2_WON = "PLAYER TWO WON: " #+ @player_2.token

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
    @io.display_board
    set_players
    game_loop
    winner_display
    play_again?
  end

  def play_again?
    play_again_input = @io.play_again_output PLAY_AGAIN

    until play_again_input == "y" || play_again_input == "n" do
      puts PLAY_AGAIN_REPROMPT
      play_again_input = gets.chomp.downcase
    end

    if play_again_input == "y"
      @play_again = true
      @io.clear_screen
    elsif play_again_input == "n"
      @play_again = false
    end

    return @play_again
  end

  def set_current_player
    case @menu.turn_response
    when 1
    @current_player = @player_1
    when 2
    @current_player = @player_2
    end
  end

  # def set_players
  #   case @menu.turn_response
  #   when 1
  #     @player_1.type = "human"
  #     @player_2.type = "ai"
  #     @player_1.token = " X "
  #     @player_2.token = " O "
  #   when 2
  #     @player_1.type = "ai"
  #     @player_2.type = "human"
  #     @player_1.token = " O "
  #     @player_2.token = " X "
  #   end
  # end

  def player_turn
    if @current_player.type == "ai"
      ai_turn
    elsif @current_player.type == "human"
      human_turn
    end
  end

  def game_loop
    until game_over do
      @player_1.make_move
      winner?
      break if game_over

      @player_2.make_move
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
      @board.fill_cell(move, " X ")
      @io.display_board
    end
  end

#FIX THE TOKEN VALUES AS DYNAMIC
  def ai_turn
    move = @ai.find_move
    @io.output_message AI_TURN + "#{move}"
    @board.fill_cell(move, " O ")
    @io.display_board
  end

  def calculate_sum(cell)
     @sum += 1 if cell == @player_1.token
     @sum -= 1 if cell == @player_2.token
  end

  def set_winner
    @winner = @player_1.token if @sum == @size
    @winner = @player_2.token if @sum == -@size
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
      @sum += 1 if @board.cells[cell] == @player_1.token
      @sum -= 1 if @board.cells[cell] == @player_2.token
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
      @sum += 1 if @board.cells[cell] == @player_1.token
      @sum -= 1 if @board.cells[cell] == @player_2.token
    end
    set_winner
  end

  def is_tie?
    @winner == nil && @board.cells.select { |cell| cell == nil }.empty?
  end

  def winner_display
    @io.output_message PLAYER_1_WON + @player_1.token if @winner == @player_1.token
    @io.output_message PLAYER_2_WON + @player_2.token if @winner == @player_2.token
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
