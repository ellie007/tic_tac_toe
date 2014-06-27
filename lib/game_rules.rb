class GameRules

  def self.game_over?(board)
    winner?(board) || is_tie?(board)
  end

  def self.winner?(board)
    dice_dimensional_board(board).each { |sub_board|
      return true if row_winner?(sub_board) ||
        column_winner?(sub_board) ||
        principal_diagonal_winner?(sub_board) ||
        counter_diagonal_winner?(sub_board) }
    return true if board.dimension == 3 && three_d_diagonal_winner?(board)
    return false
  end

  def self.is_tie?(board)
    board.cells.select { |cell| cell.nil? }.empty? && winner?(board) == false
  end

private

  def self.row_winner?(sub_board)
    row_column_winner?(split_board_into_rows(sub_board))
  end

  def self.column_winner?(sub_board)
    row_column_winner?(split_board_into_rows(sub_board).transpose)
  end

  def self.principal_diagonal_winner?(sub_board)
    diagonal_winner?(create_principal_diagonal(sub_board))
  end

  def self.counter_diagonal_winner?(sub_board)
    diagonal_winner?(create_counter_diagonal(sub_board))
  end

  def self.three_d_diagonal_winner?(board)
    create_3d_diagonals(board).each { |diagonal| return true if diagonal_winner?(diagonal) }
    return false
  end

  def self.dice_dimensional_board(board)
    @boards = []
    if board.dimension == 2
      @boards << board.cells
    else
      create_x_axis_boards(board)
      create_z_axis_boards(board)
      create_y_axis_boards(board)
    end
    @boards
  end

  def self.split_board_into_rows(board)
    split_board = []
    board.each_slice(Math.sqrt(board.length)) { |row| split_board << row }
    split_board
  end

  def self.row_column_winner?(split_board)
    split_board.each do |row|
      return true if row.uniq.count == 1 && row.uniq[0] != nil
    end
    return false
  end

  def self.create_principal_diagonal(board)
    create_diagonal(board, 0, 1)
  end

  def self.create_counter_diagonal(board)
    create_diagonal(board, Math.sqrt(board.length) - 1, -1)
  end

  def self.create_diagonal(board, i_value, incrementor)
    values = []
    board.each_with_index do |cell, index|
      if index % Math.sqrt(board.length) == 0
        values << board[index + i_value]
        i_value += incrementor
      end
    end
    values
  end

  def self.diagonal_winner?(values)
    return true if values.uniq.count == 1 && values.uniq[0] != nil
    return false
  end

  def self.create_3d_diagonals(board)
    @diagonals = []
    create_3d_sub_diagonal(board, 0, upper_left_and_right_diagonal_incrementor(board))
    create_3d_sub_diagonal(board, board.size - 1, upper_left_and_right_diagonal_incrementor(board) - 2)
    create_3d_sub_diagonal(board, board.size**2 - board.size, lower_left_and_right_diagonal_incrementor(board))
    create_3d_sub_diagonal(board, board.size**2 - 1, lower_left_and_right_diagonal_incrementor(board) - 2)
    @diagonals
  end

  def self.create_3d_sub_diagonal(board, i, inner_diagonal_i)
    sub_diagonal = []
    board.size.times do
      sub_diagonal << board.cells[i]
      i += inner_diagonal_i
    end
    @diagonals << sub_diagonal
  end

  def self.upper_left_and_right_diagonal_incrementor(board)
    board.cells.length / (board.size - 1)
  end

  def self.lower_left_and_right_diagonal_incrementor(board)
    board.size * (board.size - 1) + 1
  end

  def self.create_x_axis_boards(board)
    board.cells.each_slice(board.size**2) { |sub_board| @boards << sub_board }
  end

  def self.create_z_axis_boards(board)
    temp = []
    board.size.times { |i| temp << board.size * (board.size * i) }
    single_board = []
    board.size.times { |i| single_board << temp.map { |x| x + (i * board.size) } }
    board.size.times { |i| @boards << single_board.flatten.map { |x| board.cells[x] } }
  end

  def self.create_y_axis_boards(board)
    temp = []
    board.size.times { |i| temp << i }
    single_board = []
    board.size.times { |i| single_board << temp.map { |x| x + (i * board.size**2) } }
    board.size.times { |i| @boards << single_board.flatten.map { |x| board.cells[x + (board.size * i)]} }
  end

end
