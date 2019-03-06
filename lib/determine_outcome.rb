# frozen_string_literal: true

class DetermineOutcome
  WINNING_SETS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ].freeze

  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute
    board = @game_state_gateway.retrieve
    winner = check_for_winner(board)
    winner = 3 if check_for_draw(board) == 9
    winner
  end

  private

  def check_for_winner(board)
    winner = 0
    WINNING_SETS.each do |winning_set|
      winner = 1 if winner?(board.grid.values_at(*winning_set), 1)
      winner = 2 if winner?(board.grid.values_at(*winning_set), 2)
    end
    winner
  end

  def check_for_draw(board)
    board.grid.count { |x| [1, 2].include?(x) }
  end

  def winner?(indexes, player)
    return true if indexes.count(player) == 3

    false
  end
end
