class RetrieveGameState
  def initialize(game_state_gateway:)
      @game_state_gateway = game_state_gateway
  end

  def execute
    @game_state_gateway.retrieve
  end
end
