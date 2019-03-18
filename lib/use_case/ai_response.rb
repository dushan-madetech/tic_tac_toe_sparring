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

  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
    @board = @game_state_gateway.retrieve
  end

  def execute(board)
    board = @game_state_gateway.retrieve
    player = board.ai_player
    board[3] = 1
    board
  end

  def score(board)
    new_board = board.dup
    if check_for_draw?(new_board) == true
      return 0
    elsif check_for_winner(new_board) == 1
      return -10
    elsif check_for_winner(new_board) == 2
      return 10
    end
  end

  def check_for_winner(board)
    winner = 0
    WINNING_SETS.each do |winning_set|
      winner = 1 if winner?(board.values_at(*winning_set), 1)
      winner = 2 if winner?(board.values_at(*winning_set), 2)
    end
    winner
  end

  def check_for_draw?(board)
    return true if board.count { |x| [1, 2].include?(x) }

    false
  end

  def winner?(indexes, player)
    return true if indexes.count(player) == 3

    false
  end
end
