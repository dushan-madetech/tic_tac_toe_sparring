# frozen_string_literal: true

class CheckGameState
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute
    board = @game_state_gateway.retrieve
    return 'Player one wins' if check_winner_from_row == 1 || check_winner_from_column == 1 || check_winner_from_diagonal == 1
    return 'Player two wins' if check_winner_from_row == 2 || check_winner_from_column == 2 || check_winner_from_diagonal == 2
  end

  def check_winner_from_row
    board = @game_state_gateway.retrieve
    row_start_index = 0
    winner = 0
    while row_start_index <= 6 do
      winner = 1 if row_winner?(board[row_start_index..row_start_index+2],1)
      winner = 2 if row_winner?(board[row_start_index..row_start_index+2],2)
      row_start_index += 3
    end
    winner
  end

  def row_winner?(row, player)
    return true if row.count(player) == 3
    false
  end

  def check_winner_from_column
    board = @game_state_gateway.retrieve
    column_start_index = 0
    winner = 0
    while column_start_index <= 2 do
      winner = 1 if column_winner?(board.values_at(column_start_index, column_start_index+3, column_start_index+6),1)
      winner = 2 if column_winner?(board.values_at(column_start_index, column_start_index+3, column_start_index+6),2)
      column_start_index += 1
    end
    winner
  end

  def column_winner?(column, player)
    return true if column.count(player) == 3
    false
  end

  def check_winner_from_diagonal
    board = @game_state_gateway.retrieve
    column_start_index = 0
    winner = 0
    winner = 1 if diagonal_winner?(board.values_at(0,4,8),1) || diagonal_winner?(board.values_at(2,4,6),1)
    winner = 2 if diagonal_winner?(board.values_at(0,4,8),2) || diagonal_winner?(board.values_at(2,4,6),2)
    winner
  end

  def diagonal_winner?(diagonal, player)
    return true if diagonal.count(player) == 3
    false
  end

end
