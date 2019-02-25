# frozen_string_literal: true

require 'retrieve_game_state'
require 'test_doubles/game_state_storage_gateway_stub'

describe RetrieveGameState do
  let(:game_state_gateway) { GameStateStorageGatewayStub.new }

  it 'can retrieve a stored game state' do
    game_state_gateway.game_state = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    retrieve_game_state = described_class.new(
      game_state_gateway: game_state_gateway
    )
    expect(retrieve_game_state.execute).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0])
  end
end
