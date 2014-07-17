require_relative 'board'
require_relative 'command_line'
require_relative 'easy_ai'
require_relative 'game'
require_relative 'hard_ai'
require_relative 'options_menu'
require_relative 'player_factory'
require_relative 'prefix_menu'

class GameInstantiation

  def initialize(io, io_options)
    @io = io
    @io_options = io_options
  end

  def start_game
    display_welcome_message
    create_game_objects
    @game.run
  end

private

  def display_welcome_message
    @io.output("Welcome to Tic Tac Toe!\n")
  end

  def create_game_objects
    menu = @io_options[:default] ? PrefixMenu.new : OptionsMenu.new(@io)
    board = Board.new(menu.get_board_size, menu.get_board_dimension)
    easy_ai = EasyAi.new
    hard_ai = HardAi.new
    player_factory = PlayerFactory.new(easy_ai, hard_ai, @io)
    game_objects = { :board => board, :io => @io, :menu => menu, :player_factory => player_factory, :default_mode => @io_options[:default] }
    @game = Game.new(game_objects)
  end

end



