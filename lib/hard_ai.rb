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

  def minimax(current_player_token, opponent_token, maximizing_player, node, α = -100, β = 100)
    return 0 if GameRules.is_tie?(node)
    return 1 if GameRules.winner?(node) && maximizing_player == false
    return -1 if GameRules.winner?(node) && maximizing_player == true

    if maximizing_player == true
      node.available_spaces(node.cells).each do |space|
        node.cells[space] = current_player_token
        score = minimax(opponent_token, current_player_token, false, node, α, β)
        node.cells[space] = nil
        α = score if score > α
        return α if α >= β
      end
      return α
    elsif maximizing_player == false
      node.available_spaces(node.cells).each do |space|
        node.cells[space] = current_player_token
        score = minimax(opponent_token, current_player_token, true, node, α, β)
        node.cells[space] = nil
        β = score if score < β
        return β if α >= β
      end
      return β
    end
  end

end
