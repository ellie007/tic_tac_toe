require_relative 'game_rules'

class Ai

  def initialize(board)
    @board = board
  end

  def find_move(current_player, players, board = @board)
    max_token = current_player.token
    min_token = find_opponent_player(current_player, players).token
    moves = {}
    available_spaces(board.cells).each do |space|
      board.cells[space] = max_token
      moves[space] = minimax(max_token, min_token, false, board)
      board.cells[space] = nil
    end
    moves.select { |k, v| v == moves.values.max }.keys[0]
  end

  def minimax(max_token, min_token, maximizing_player, board)
    return 0 if GameRules.is_tie?(board)
    return 1 if GameRules.winner?(board) && maximizing_player == false
    return -1 if GameRules.winner?(board) && maximizing_player == true

    if maximizing_player == true
      best_score = -100
      available_spaces(board.cells).each do |space|
        board.cells[space] = max_token
        score = minimax(max_token, min_token, false, board)
        board.cells[space] = nil
        best_score = score if score > best_score
      end
      return best_score
    elsif maximizing_player == false
      best_score = 100
      available_spaces(board.cells).each do |space|
        board.cells[space] = min_token
        score = minimax(max_token, min_token, true, board)
        board.cells[space] = nil
        best_score = score if score < best_score
      end
      return best_score
    end
  end

  def available_spaces(node)
    available_spaces = []
    node.each_with_index do |value, index|
      available_spaces << index if value.nil?
    end
    available_spaces
  end

  def find_opponent_player(current_player, players)
    current_player_index = players.index(current_player)
    current_player_index == 1 ? opponent_player_index = 0 : opponent_player_index = 1
    players[opponent_player_index]
  end

end
