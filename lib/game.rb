require_relative 'game_rules'

class Game

  attr_accessor :board, :winner, :size, :play_again, :current_player, :opponent_player, :players

  def initialize(options)
    @board = options[:board]
    @io = options[:io]
    @menu = options[:menu]
    @easy_ai = options[:easy_ai]
    @hard_ai = options[:hard_ai]

    @players = []
    @size = options[:board].size.to_i
    @play_again = true

    @io.size = @size
    @io.dimension = options[:board].dimension.to_i
  end

  def run
    set_players
    while play_again == true
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
      if player_options[:player_type] == 1
        player = HumanPlayer.new(player_options, @io)
      elsif player_options[:player_type] == 2 && player_options[:computer_player_type] == 1
        player = AiPlayer.new(player_options, EasyAi.new(board))
      elsif player_options[:player_type] == 2 && player_options[:computer_player_type] == 2
        player = AiPlayer.new(player_options, HardAi.new(board))
      end
      players << player
    end
    set_current_and_opponent_player
  end

  def set_current_and_opponent_player
    self.current_player = players[0]
    self.opponent_player = players[1]
  end

  def ask_to_play_again
    get_play_again_response
    set_play_again_response
  end

  def game_loop
    until GameRules.game_over?(board)
      make_move
    end
    @io.clear_screen
  end

  def make_move
    move = current_player.make_move(current_player.token, opponent_player.token, players.count)
    if move.is_a?(String) && move.downcase == 'restart'
      restart_current_game
    elsif move.is_a?(String) && move.downcase == 'menu'
      start_new_game
    elsif move.is_a?(String) && move.downcase == 'quit'
      exit
    elsif !valid_input?(move)
      invalid_input_response
      make_move
    elsif !valid_cell?(move.to_i)
      invalid_cell_response
      make_move
    else
      play_successful_move(move.to_i)
    end
  end

  def display_winner_information
    set_winner
    display_board
    if GameRules.winner?(board)
      @io.output("#{current_player.name} Won!")
    elsif GameRules.is_tie?(board)
      @io.output('It was a tie game.')
    end
  end

private

  def toggle_current_player
    current_player_index = players.index(current_player)
    next_player_index = (current_player_index + 1) % players.size
    self.current_player = players[next_player_index]
  end

  def toggle_opponent_player
    if players.index(current_player) == players.count - 1
      self.opponent_player = players.first
    else
      self.opponent_player = players[players.index(current_player) + 1]
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
    board.fill_cell(move, current_player.token)
    @io.output(current_player.name + " made the move: #{move}.")
    @io.clear_screen
    display_board
    toggle_current_player unless GameRules.game_over?(board)
    toggle_opponent_player unless GameRules.game_over?(board)
  end

  def valid_input?(move)
    if move == ''
      return false
    elsif move.is_a?(String) && ('a..z').include?(move.downcase[0])
      return false
    elsif (0..board.cells.count - 1).include?(move.to_i)
      return true
    end
  end

  def valid_cell?(move)
    board.cells[move].nil?
  end

  def invalid_input_response
    invalid_input_comment = "That is invalid input.  Please choose open spaces 0 to #{size**2 - 1}."
    @io.output(invalid_input_comment)
    display_board
  end

  def invalid_cell_response
    invalid_cell_comment = "That spot is already taken.  Please choose an empty spot."
    @io.output(invalid_cell_comment)
    display_board
  end

  def set_winner
    self.winner = current_player.token if GameRules.winner?(board)
    winner
  end

  def get_play_again_response
    play_again_prompt = "Would you like to play again (y/n)?: "
    @io.output(play_again_prompt)
    @play_again_input = @io.input.downcase
    if @play_again_input != "y" && @play_again_input != "n"
      get_play_again_response
    else
      return @player_again_input
    end
  end

  def set_play_again_response
    if @play_again_input == "y"
      @io.clear_screen
      clear_board
      set_current_and_opponent_player
   elsif @play_again_input == "n"
      self.play_again = false
    end
  end

  def clear_board
    board.cells.each_with_index do |cell, index|
      board.fill_cell(index, nil)
    end
  end

  def display_board
    @io.display_board(board.cells)
  end

end
