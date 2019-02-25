# frozen_string_literal: true

class CheckGameState
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute
    board = @game_state_gateway.retrieve

    return 'Player one wins' if board[0] == 1
  end
end
