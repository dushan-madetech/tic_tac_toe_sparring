require 'retrieve_game_state'

describe RetrieveGameState do
  class GameStateStorageGatewayStub
    attr_writer :game_state

    def retrieve
      @game_state
    end
  end

  let (:game_state_gateway) { GameStateStorageGatewayStub.new }


  it 'can retrieve a stored game state' do
    game_state_gateway.game_state = [0,0,0,0,0,0,0,0,0]
    retrieve_game_state = RetrieveGameState.new(game_state_gateway: game_state_gateway)
    expect(retrieve_game_state.execute).to eq([0,0,0,0,0,0,0,0,0])
  end
end
