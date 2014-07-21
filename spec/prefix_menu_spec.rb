require 'prefix_menu'

describe PrefixMenu do

  let(:prefix_menu) { PrefixMenu.new }

  it 'sets the board size to default 3' do
    expect(prefix_menu.get_board_size).to eq(3)
  end

  it 'sets the board dimension to default 2' do
    expect(prefix_menu.get_board_dimension).to eq(2)
  end

  it 'sets the number of players to default 2' do
    expect(prefix_menu.get_number_of_players).to eq(2)
  end

end
