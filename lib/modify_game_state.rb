class ModifyGameState
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(tile, player)
    raise TileInvalidError, "Tile out of bounds" if tile >= 10
    old_board = @game_state_gateway.retrieve
    new_board = old_board
    if(new_board[tile-1] == 0)
      new_board[tile-1] = player
    end
    @game_state_gateway.save(new_board)
  end
end
