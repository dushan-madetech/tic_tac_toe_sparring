# frozen_string_literal: true

require 'save_game'
require 'gateway/game_state_storage_gateway_spy'

describe SaveGame do
  let(:game_state_gateway) { GameStateStorageGatewaySpy.new }
  let(:save_game) do
    described_class.new(game_state_gateway: game_state_gateway)
  end

  it 'can return true when successfully executed' do
    game = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    expect(save_game.execute(game)).to eq(true)
  end

  it 'can store a game state for an empty board' do
    game = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    save_game.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0])
  end

  it 'can store a game state of a modified board' do
    game = [1, 2, 1, 0, 0, 0, 2, 1, 2]
    save_game.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([1, 2, 1, 0, 0, 0, 2, 1, 2])
  end

  it 'can overwrrite an existing game state' do
    game = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    save_game.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0])
    game = [0, 0, 0, 0, 0, 0, 0, 0, 1]
    save_game.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0, 0, 0, 0, 0, 0, 0, 0, 1])
  end
end
