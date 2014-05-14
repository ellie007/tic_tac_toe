class GameRules

  def initialize(board)
    @board = board
    @size = board.size
  end

  def row_winner?
    split_board = []
    @board.cells.each_slice(@size) { |row| split_board << row }
    row_column_win_checker(split_board)
  end

  def column_winner?
    column_win_possibilities = []
    @board.cells.each_slice(@size) { |row| column_win_possibilities << row }
    split_board = column_win_possibilities.transpose
    row_column_win_checker(split_board)
  end

  def principal_diagonal_winner?
    indices = []
    i = 0
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        indices << index + i
        i += 1
      end
    end
    diagonal_win_checker(indices)
  end

  def counter_diagonal_winner?
    indices = []
    i = @size - 1
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        indices << index + i
        i -= 1
      end
    end
    diagonal_win_checker(indices)
  end

  def winner?
    row_winner? || column_winner? || principal_diagonal_winner? || counter_diagonal_winner?
  end

  def is_tie?
    @board.cells.select { |cell| cell == nil }.empty?
  end

  def game_over
    winner? == true || is_tie?
  end

private

  def row_column_win_checker(split_board)
    split_board.each do |row|
      return true if row.uniq.count == 1 && row.uniq[0] != nil
    end
    return false
  end

  def diagonal_win_checker(indices)
    diagonal = []
    indices.each do |cell|
      diagonal << @board.cells[cell]
    end

    if diagonal.uniq.count == 1 &&  diagonal.uniq[0] != nil
      return true
    else
      return false
    end
  end


end
