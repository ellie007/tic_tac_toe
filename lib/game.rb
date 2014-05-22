class Game

  attr_accessor :board, :winner, :size, :play_again, :current_player

  def initialize(board, ai, io, menu, players, game_rules)
    @board = board
    @ai = ai
    @players = players
    @io = io
    @menu = menu
    @game_rules = game_rules

    @size = board.size.to_i
    @play_again = true
    @current_player = @players[0]
    @io.size = @size.to_i
  end

  def run
    while @play_again == true do
      @io.clear_screen
      @io.display_board(board.cells)
      game_loop
      winner_display
      play_again?
    end
  end

  def play_again?
    get_play_again_response
    set_play_again_response
    self.play_again
  end

  def game_loop
    until @game_rules.game_over? do
      make_move
      break if @game_rules.winner? || @game_rules.is_tie?
      toggle_current_player
    end
    @io.clear_screen
  end

  def toggle_current_player
    if self.current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end
  end

  def make_move
    move = @current_player.make_move.to_i
    valid_move_check(move)
    @board.fill_cell(move, @current_player.token)
    @io.clear_screen
    display_board
  end

  def winner_display
    tie_memo = "It was a tie game."

    set_winner
    display_board
    if @game_rules.winner?
      @io.output_message(@current_player.name + " Won!")
    elsif @game_rules.is_tie?
      @io.output_message(tie_memo)
    end
  end

  private

  def valid_move_check(move)
    if !valid_input?(move)
      invalid_input_response
      make_move
    elsif !valid_cell?(move)
      invalid_cell_response
      make_move
    end
  end

  def valid_input?(move)
    (1..size**2).include?(move)
  end

  def valid_cell?(move)
    @board.cells[move - 1].nil?
  end

  def invalid_input_response
    invalid_input_memo = "That is invalid input.  Please choose open spaces 1 to "
    @io.output_message(invalid_input_memo + "#{size**2}.")
    display_board
  end

  def invalid_cell_response
    invalid_cell_memo = "That spot is already taken.  Please choose an empty spot."
    @io.output_message(invalid_cell_memo)
    display_board
  end

  def set_winner
    @winner = @current_player.token if @game_rules.winner?
    self.winner
  end

  def get_play_again_response
    play_again_prompt = "Would you like to play again (y/n)?: "

    @play_again_input = nil
    until @play_again_input == "y" || @play_again_input == "n" do
      @play_again_input = (@io.prompt_for_input(play_again_prompt)).downcase
    end
  end

  def set_play_again_response
    if @play_again_input == "y"
      @io.clear_screen
      play_again_reset
    elsif @play_again_input == "n"
      @play_again = false
    end
  end

  def play_again_reset
    @board.cells.each_with_index { |cell, index| @board.fill_cell(index + 1, nil) }
  end

  def display_board
    @io.display_board(board.cells)
  end

end
