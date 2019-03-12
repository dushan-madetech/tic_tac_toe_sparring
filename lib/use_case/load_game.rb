# frozen_string_literal: true

class LoadGame
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute
    @game_state_gateway.retrieve.grid
  end
end
