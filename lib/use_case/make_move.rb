# frozen_string_literal: true

class MakeMove
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(tile)
    board = @game_state_gateway.retrieve
    player = board.current_player

    return :invalid unless tile.between?(1, board.grid.length)
    return :occupied unless board.grid[tile - 1].zero?

    board.grid[tile - 1] = player
    board.swap_player
    @game_state_gateway.save(board)
    true
  end
end
