# frozen_string_literal: true

require 'check_game_state'
require 'test_doubles/game_state_storage_gateway_stub'

describe CheckGameState do
  let(:game_state_gateway) { GameStateStorageGatewayStub.new }
  let(:check_game_state) do
    described_class.new(game_state_gateway: game_state_gateway)
  end

  it 'can show when player one wins from a row' do
    game_state_gateway.game_state = [1, 1, 1, 0, 0, 0, 0, 0, 0]
    expect(check_game_state.execute).to eq(1)
  end

  it 'can show when player two wins from a row' do
    game_state_gateway.game_state = [2, 2, 2, 0, 0, 0, 0, 0, 0]
    expect(check_game_state.execute).to eq(2)
  end

  it 'can show winner when player one wins from a different row' do
    game_state_gateway.game_state = [0, 0, 0, 1, 1, 1, 0, 0, 0]
    expect(check_game_state.execute).to eq(1)
  end

  it 'can show when player one wins from a column' do
    game_state_gateway.game_state = [1, 0, 0, 1, 0, 0, 1, 0, 0]
    expect(check_game_state.execute).to eq(1)
  end

  it 'can show when player two wins from a column' do
    game_state_gateway.game_state = [2, 0, 0, 2, 0, 0, 2, 0, 0]
    expect(check_game_state.execute).to eq(2)
  end

  it 'can show winner when player one wins from a different column' do
    game_state_gateway.game_state = [0, 1, 0, 0, 1, 0, 0, 1, 0]
    expect(check_game_state.execute).to eq(1)
  end

  it 'can show winner when player one wins from a diagonal' do
    game_state_gateway.game_state = [1, 0, 0, 0, 1, 0, 0, 0, 1]
    expect(check_game_state.execute).to eq(1)
  end

  it 'can show winner when player two wins from a diagonal' do
    game_state_gateway.game_state = [2, 0, 0, 0, 2, 0, 0, 0, 2]
    expect(check_game_state.execute).to eq(2)
  end

  it 'can show winner when player one wins from a different diagonal' do
    game_state_gateway.game_state = [0, 0, 1, 0, 1, 0, 1, 0, 0]
    expect(check_game_state.execute).to eq(1)
  end
end
