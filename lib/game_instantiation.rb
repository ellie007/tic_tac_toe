require_relative 'ai_player'
require_relative 'board'
require_relative 'command_line'
require_relative 'easy_ai'
require_relative 'game'
require_relative 'hard_ai'
require_relative 'human_player'
require_relative 'menu'

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
    @io.output("Welcome to Tic Tac Toe!\n")
  end

private

  def create_game_objects
    menu = Menu.new(@io)
    board = Board.new(menu.get_board_size, menu.get_board_dimension)
    easy_ai = EasyAi.new(board)
    hard_ai = HardAi.new(board)
    options = { :board => board, :hard_ai => hard_ai, :easy_ai => easy_ai, :io => @io, :menu => menu}
    @game = Game.new(options)
  end

end



