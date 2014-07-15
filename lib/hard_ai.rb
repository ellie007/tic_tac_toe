require_relative 'game_rules'

class HardAi

  def find_move(max_token, min_token, num_of_players = 2, board)
    moves = {}
    board.available_spaces(board.cells).each do |space|
      board.cells[space] = max_token
      moves[space] = minimax(min_token, max_token, false, board)
      board.cells[space] = nil
    end
    moves.select { |key, value| value == moves.values.max }.keys[0]
  end

  def minimax(current_player_token, opponent_token, maximizing_player, node)
    return 0 if GameRules.is_tie?(node)
    return 1 if GameRules.winner?(node) && maximizing_player == false
    return -1 if GameRules.winner?(node) && maximizing_player == true

    maximizing_player ? best_score = -100 : best_score = 100
    operator = maximizing_player ? '>' : '<'

    node.available_spaces(node.cells).each do |space|
      node.cells[space] = current_player_token
      score = minimax(opponent_token, current_player_token, !maximizing_player, node)
      node.cells[space] = nil
      best_score = score if score.send(operator, best_score)
    end
    best_score
  end

end
