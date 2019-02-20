class StoreGameState
  
  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute(game_state)
    @game_state_gateway.save(game_state)
  end

end
