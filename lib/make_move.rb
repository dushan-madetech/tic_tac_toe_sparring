# frozen_string_literal: true

class MakeMove
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(tile, player)
    raise TileInvalidError, 'Tile out of bounds' if tile <= 0 || tile >= 10

    old_board = @game_state_gateway.retrieve
    new_board = old_board
    if new_board.grid[tile - 1].zero?
      new_board.grid[tile - 1] = player
      new_board.swap_player(player)
    end
    @game_state_gateway.save(new_board)
    true
  end
end
