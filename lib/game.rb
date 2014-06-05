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

    @io.size = @size
    @io.dimension = options[:board].dimension.to_i
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
    (1..@menu.get_number_of_players).each do |i|
      player_options = @menu.get_player_options(i)
      if player_options[:type] == 1
        player = HumanPlayer.new(player_options, @io)
      else
        player = AiPlayer.new(player_options, @ai)
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
    end
    @io.clear_screen
  end

  def make_move
    move = @current_player.make_move
    if move == 'restart'
      restart_current_game
    elsif move == 'menu'
      start_new_game
    elsif !valid_input?(move.to_i)
      invalid_input_response
      make_move
    elsif !valid_cell?(move.to_i)
      invalid_cell_response
      make_move
    else
      play_successful_move(move.to_i)
    end
  end

  def restart_current_game
    clear_board
    @io.clear_screen
    display_board
  end

  def start_new_game
    @io.clear_screen
    GameInstantiation.new(@io).start_game
  end

  def play_successful_move(move)
    @board.fill_cell(move, @current_player.token)
    @io.output(@current_player.name + " made the move: #{move}.")
    @io.clear_screen
    display_board
    toggle_current_player unless @game_rules.game_over?
  end

  def display_winner_information
    set_winner
    display_board
    if @game_rules.winner?
      @io.output("#{current_player.name} Won!")
    elsif @game_rules.is_tie?
      @io.output('It was a tie game.')
    end
  end

private

  def toggle_current_player
    current_player_index = players.index(current_player)
    next_player_index = (current_player_index + 1) % players.size
    self.current_player = players[next_player_index]
  end

  def valid_input?(move)
    (1..board.cells.count).include?(move)
  end

  def valid_cell?(move)
    @board.cells[move - 1].nil?
  end

  def invalid_input_response
    invalid_input_comment = "That is invalid input.  Please choose open spaces 1 to #{size**2}."
    @io.output(invalid_input_comment)
    display_board
  end

  def invalid_cell_response
    invalid_cell_comment = "That spot is already taken.  Please choose an empty spot."
    @io.output(invalid_cell_comment)
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
      @io.output(play_again_prompt)
      @play_again_input = @io.input.downcase
    end
  end

  def set_play_again_response
    if @play_again_input == "y"
      @io.clear_screen
      clear_board
    elsif @play_again_input == "n"
      @play_again = false
    end
  end

  def clear_board
    @board.cells.each_with_index do |cell, index|
      @board.fill_cell(index + 1, nil)
    end
  end

  def display_board
    @io.display_board(board.cells)
  end

end
