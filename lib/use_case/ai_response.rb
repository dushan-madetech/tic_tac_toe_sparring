class AIResponse
  WINNING_SETS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def execute(board)
    try_move(board)
  end

  def try_move(board)
    new_board = board.dup
    index = 0
    while index < new_board.length
      if new_board[index].zero?
        new_board[index] = 1
        puts new_board.to_s
        if check_for_winner(new_board) == 1
          return index+1
        end
        new_board[index] = 0
      end
      index += 1
    end
    index
  end

  def check_for_winner(board)
    winner = 0
    WINNING_SETS.each do |winning_set|
      winner = 1 if winner?(board.values_at(*winning_set), 1)
      winner = 2 if winner?(board.values_at(*winning_set), 2)
    end
    winner
  end

  def check_for_draw(board)
    board.count { |x| [1, 2].include?(x) }
  end

  def winner?(indexes, player)
    return true if indexes.count(player) == 3

    false
  end
end
