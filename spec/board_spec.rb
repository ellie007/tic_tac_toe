require 'menu'
require 'game'
require 'player'
require 'board'

describe Board do
  let(:menu) { Menu.new }
  let(:player_1) { Player.new }
  let(:player_2) { Player.new}
  let(:board) { Board.new(3) }
  let(:game) { Game.new(board,{},{},menu,player_1,player_2) }


  it "places a move for the player on the board" do
    menu.turn_response = nil
    player_1.token  = "X"
    @current_player = game.set_current_player
    board.fill_cell(4, @current_player.token)

    expect(board.cells[3]).to eq(@current_player.token)
  end

  it "places a move for the player on the board" do
    menu.turn_response = nil
    player_2.token  = "O"
    @current_player = game.set_current_player
    board.fill_cell(4, @current_player.token)

    expect(board.cells[3]).to eq(@current_player.token)
  end


end
