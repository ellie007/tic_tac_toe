require_relative 'game_rules'

class Ai

  def initialize(board)
    @board = board
  end

 def minimax(board = @board, depth = board.cells.length, maximizing_player = true)
    return 1 * depth if GameRules.winner?(board) && maximizing_player == false
    return -1 * depth if GameRules.winner?(board) && maximizing_player == true
    return 0 if GameRules.is_tie?(board)

    best_score = -100 if maximizing_player == true
    best_score = 100 if maximizing_player == false
    best_move = nil

    available_spaces(board.cells).each do |space|
      if maximizing_player == true
        board.cells[space] = "X"
        score = minimax(board, depth - 1, !maximizing_player)
        if score > best_score
          best_score = score
          best_move = space
        end
        board.cells[space] = nil
      elsif maximizing_player == false
        board.cells[space] = "O"
        score = minimax(board, depth - 1, !maximizing_player)
        if score < best_score
          best_score = score
          best_move = space
        end
        board.cells[space] = nil
      end
    end
    return best_move
  end

  def available_spaces(node)
    available_spaces = []
    node.each_with_index do |value, index|
      available_spaces << index if value.nil?
    end
    available_spaces
  end

end
