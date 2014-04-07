# the data that represents the board
# contains presentation logic
# e.g. three spaces for an empty cell,
# not because that is meaningful in the board representation,
# but because that prints to a console conveniently.
# would be better to represent the board independently
# of the presentation logic.

class Game

  WELCOME = "Welcome to Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "
  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."
  TIE = "It is a tie game."
  WATSON_WON = "Watson Won!"
  YOU_WON = "You Won!"

  attr_accessor :board, :winner, :sum

  WIN_POSSIBILITIES =
    [[0,1,2], [3,4,5], [6,7,8],
     [0,3,6], [1,4,7], [2,5,8],
     [0,4,8], [2,4,6]]

  def initialize(board, ai, player, io)
    @board = board
    @ai = ai
    @player = player
    @io = io
  end

  def run
    @io.output_message WELCOME
    @io.display_board
    game_loop
    winner_display
  end

  def game_loop
    until game_over do
      human_turn
      @io.display_board
      is_winner
      break if game_over
      ai_turn
      @io.display_board
      is_winner
    end
  end

  def human_turn
    move = @io.player_input(USER_TURN)
    if valid_move_check(move)
      @board.fill_cell(move, @player.token)
    else
      human_turn
    end
  end

  def ai_turn
    move = @ai.find_move
    @io.output_message AI_TURN + "#{move}"
    @board.fill_cell(move, @ai.token)
  end

  def calculate_sum(cell)
     @sum += 1 if cell == @ai.token
     @sum -= 1 if cell == @player.token
  end

  def set_winner
    @winner = @ai.token if @sum == 3
    @winner = @player.token if @sum == -3
    @winner
  end

  # needs a better name
  def is_winner
    WIN_POSSIBILITIES.each do |set|
      @sum = 0
      set.each do |cell|
        calculate_sum(@board.cells[cell])
      end
      break if @sum == 3 || @sum == -3
    end
    set_winner
  end

  # rename to tie?
  def is_tie?
    @winner == nil && @board.cells.select { |cell| cell == nil }.empty?
  end

  def valid_move_check(move)
    if !valid_input?(move)
      @io.output_message INVALID_INPUT
      @io.display_board
      false
    elsif !valid_cell?(move)
      @io.output_message INVALID_CELL
      @io.display_board
      false
    else
      true
    end
  end

  def valid_input?(move)
    [1,2,3,4,5,6,7,8,9].include?(move)
  end

  def valid_cell?(move)
    @board.cells[move - 1] == nil
  end

  def game_over
    @winner != nil || is_tie?
  end

  def winner_display
    @io.output_message WATSON_WON if @winner == @ai.token
    @io.output_message YOU_WON if @winner == @player.token
    @io.output_message TIE if is_tie?
  end

end
