# frozen_string_literal: true

class MakeMove
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(tile, player)
    board = @game_state_gateway.retrieve

    raise IndexError, 'Tile out of bounds' unless tile.between?(
      1, board.grid.length
    )

    if board.grid[tile - 1].zero?
      board.grid[tile - 1] = player
      board.swap_player(player)
    end
    @game_state_gateway.save(board)
    true
  end
end
