# frozen_string_literal: true

class MakeMove
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(tile)
    board = @game_state_gateway.retrieve
    player = board.current_player
    check_mark_within_bounds(tile, board)

    if board.grid[tile - 1].zero?
      board.grid[tile - 1] = player
      board.swap_player
    else
      raise OccupiedError, 'Cannot make the same move twice'
    end
    @game_state_gateway.save(board)
    true
  end

  private

  def check_mark_within_bounds(tile, board)
    raise IndexError, 'Tile out of bounds' unless tile.between?(
      1, board.grid.length
    )
  end
end

class OccupiedError < StandardError
end
