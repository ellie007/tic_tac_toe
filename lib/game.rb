class Game

  attr_accessor :board, :winner

  WIN_POSSIBILITIES =
    [[0,1,2], [3,4,5], [6,7,8],
     [0,3,6], [1,4,7], [2,5,8],
     [0,4,8], [2,4,6]]

  def initialize(board, ai, player)
    @board = board
    @ai = ai
    @player = player
    @winner
  end

  def human_turn(move)
    @board.fill_cell(move, @player.token)
  end

  def ai_turn(rand_move)
    @board.fill_cell(rand_move, @ai.token)
  end

  def calculate_sum(cell)
     @sum += 1 if cell == @ai.token
     @sum -= 1 if cell == @player.token
  end

  def set_winner
    @winner = @ai.token if @sum == 3
    @winner = @player.token if @sum == -3
    @winner
  end

  def is_winner
    WIN_POSSIBILITIES.each do |set|
      @sum = 0
      set.each do |cell|
        calculate_sum(@board.cells[cell])
      end
      break if @sum == 3 || @sum == -3
    end
    set_winner
  end

  def is_tie?
    @board.cells.select { |cell| cell == "   " }.empty? if @winner == nil
  end

  def valid_input?(move)
    valid_move = [1,2,3,4,5,6,7,8,9]
    valid_move.include?(move)
  end

  def valid_cell?(move)
    @board.cells[move - 1] == @player.token || @board.cells[move -1] == @ai.token ? true : false
  end

end
