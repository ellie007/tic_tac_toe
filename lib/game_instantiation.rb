require './lib/board'
require './lib/ai'
require './lib/human_player'
require './lib/ai_player'
require './lib/game'
require './lib/command_line'
require './lib/menu'
require './lib/game_rules'
require './spec/mock_command_line'

class GameInstantiation

  def initialize(io)
    @io = io
  end

  def start_game
    display_welcome_message
    create_game_objects
    @game.run
  end

  def display_welcome_message
    @io.output("\nWelcome to Tic Tac Toe!")
  end

  def create_game_objects
    menu = Menu.new(@io)
    board = Board.new(menu.get_board_size, menu.get_board_dimension)
    ai = Ai.new(board.cells)
    game_rules = GameRules.new(board)
    options = { :board => board, :ai => ai, :io => @io, :menu => menu, :game_rules => game_rules }
    @game = Game.new(options)
  end

end



