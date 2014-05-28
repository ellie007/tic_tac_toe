class Game

  attr_accessor :board, :winner, :size, :play_again, :current_player, :players

  def initialize(options)
    @board = options[:board]
    @ai = options[:ai]
    @io = options[:io]
    @menu = options[:menu]
    @game_rules = options[:game_rules]

    @players = []
    @size = options[:board].size.to_i
    @play_again = true
    @io.size = @size.to_i
  end

  def run
    set_players
    while @play_again == true do
      @io.clear_screen
      @io.display_board(board.cells)
      game_loop
      display_winner_information
      ask_to_play_again
    end
  end

  def set_players
    (1..2).each do |i|
      name = @menu.get_player_name(i)
      token = @menu.get_player_token(i)
      type = @menu.get_player_type(i)
      if type == 1
        player = HumanPlayer.new(name, token, @io)
      elsif type == 2
        player = AiPlayer.new(name, token, @ai)
      end
      @players << player
    end
    set_current_player
  end

  def set_current_player
    self.current_player = self.players[0]
  end

  def ask_to_play_again
    get_play_again_response
    set_play_again_response
  end

  def game_loop
    until @game_rules.game_over? do
      make_move
      toggle_current_player unless @game_rules.game_over?
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
    if !valid_input?(move)
      invalid_input_response
      make_move
    elsif !valid_cell?(move)
      invalid_cell_response
      make_move
    else
      @board.fill_cell(move, @current_player.token)
      @io.output_message(@current_player.name + " made the move: #{move}.")
      @io.clear_screen
      display_board
    end
  end

  def display_winner_information
    set_winner
    display_board
    if @game_rules.winner?
      @io.output_message(@current_player.name + " Won!")
    elsif @game_rules.is_tie?
      @io.output_message("It was a tie game.")
    end
  end


  private

  def valid_input?(move)
    (1..size**2).include?(move)
  end

  def valid_cell?(move)
    @board.cells[move - 1].nil?
  end

  def invalid_input_response
    invalid_input_comment = "That is invalid input.  Please choose open spaces 1 to #{size**2}."
    @io.output_message(invalid_input_comment)
    display_board
  end

  def invalid_cell_response
    invalid_cell_comment = "That spot is already taken.  Please choose an empty spot."
    @io.output_message(invalid_cell_comment)
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
      @io.output_message(play_again_prompt)
      @play_again_input = @io.input_prompt.downcase
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
