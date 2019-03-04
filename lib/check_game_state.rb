# frozen_string_literal: true

class CheckGameState
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
    @winning_sets = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2]
    ]
  end

  def execute
    board = @game_state_gateway.retrieve
    check_for_winner(board)
  end

  private

  def check_for_winner(board)
    winner = 0
    @winning_sets.each do |winning_set|
      winner = 1 if winner?(board.values_at(*winning_set), 1)
      winner = 2 if winner?(board.values_at(*winning_set), 2)
    end
    winner
  end

  def winner?(indexes, player)
    return true if indexes.count(player) == 3

    false
  end
end
