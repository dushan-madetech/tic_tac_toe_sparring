# frozen_string_literal: true

require 'load_game'
require 'gateway/game_state_storage_gateway_stub'

describe LoadGame do
  let(:game_state_gateway) { GameStateStorageGatewayStub.new }

  it 'can load a stored game state' do
    game_state_gateway.game_state = Array.new(9, 0)
    load_game = described_class.new(
      game_state_gateway: game_state_gateway
    )
    expect(load_game.execute).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0])
  end
end
