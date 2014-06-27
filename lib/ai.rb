require_relative 'game_rules'

class Ai

  def initialize(board)
    @board = board
  end

  def find_move(max_token, min_token, num_of_players = 2, board = @board)
    if board.dimension == 2 && board.size == 3 && num_of_players == 2
      moves = {}
      board.available_spaces(@board.cells).each do |space|
        board.cells[space] = max_token
        moves[space] = minimax(max_token, min_token, false, board)
        board.cells[space] = nil
      end
      moves.select { |key, value| value == moves.values.max }.keys[0]
    else
      simple_ai
    end
  end

  def minimax(max_token, min_token, maximizing_player, node)
    return 0 if GameRules.is_tie?(node)
    return 1 if GameRules.winner?(node) && maximizing_player == false
    return -1 if GameRules.winner?(node) && maximizing_player == true

    if maximizing_player == true
      best_score = -100
      node.available_spaces(node.cells).each do |space|
        node.cells[space] = max_token
        score = minimax(max_token, min_token, false, node)
        node.cells[space] = nil
        best_score = score if score > best_score
      end
      return best_score
    elsif maximizing_player == false
      best_score = 100
      node.available_spaces(node.cells).each do |space|
        node.cells[space] = min_token
        score = minimax(max_token, min_token, true, node)
        node.cells[space] = nil
        best_score = score if score < best_score
      end
      return best_score
    end
  end

private

  def simple_ai
    available_cells = []
    @board.cells.each_with_index do |value, index|
      available_cells << index if value.nil?
    end
    available_cells.sample
  end

end
