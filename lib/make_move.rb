# frozen_string_literal: true

class MakeMove
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(tile)
    board = @game_state_gateway.retrieve
    player = board.current_player
    # check_mark_within_bounds(tile, board)

    unless tile.between?(1, board.grid.length)
      return :invalid
    end

    if board.grid[tile - 1].zero?
      board.grid[tile - 1] = player
      board.swap_player
    else
      return :occupied
    end
    @game_state_gateway.save(board)
    true
  end
end
