require_relative 'board'
require_relative 'command_line'
require_relative 'easy_ai'
require_relative 'game'
require_relative 'hard_ai'
require_relative 'custom_menu'
require_relative 'player_factory'
require_relative 'prefix_menu'

class GameInstantiation

  def initialize(io, default_options)
    @io = io
    @default_options = default_options
  end

  def start_game
    display_welcome_message
    create_game_objects
    @game.run
  end

  def display_welcome_message
    @io.output("Welcome to Tic Tac Toe!\n")
  end

private

  def create_game_objects
    menu = @default_options[:default] ? PrefixMenu.new : CustomMenu.new(@io)
    board = Board.new(menu.get_board_size, menu.get_board_dimension)
    easy_ai = EasyAi.new
    hard_ai = HardAi.new
    player_factory = PlayerFactory.new(easy_ai, hard_ai, @io)
    game_objects = { :board => board, :io => @io, :menu => menu, :player_factory => player_factory, :default_mode => @default_options[:default] }
    @game = Game.new(game_objects)
  end

end



