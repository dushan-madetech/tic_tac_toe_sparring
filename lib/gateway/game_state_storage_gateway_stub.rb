# frozen_string_literal: true

class GameStateStorageGatewayStub
  attr_writer :game_state

  def retrieve
    @game_state
  end
end
