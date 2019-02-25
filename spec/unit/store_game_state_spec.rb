require 'store_game_state'
require 'test_doubles/game_state_storage_gateway_spy'

describe StoreGameState do

  let (:game_state_gateway) {GameStateStorageGatewaySpy.new}
  let (:game_state_store) {StoreGameState.new(game_state_gateway: game_state_gateway)}

  it 'can store a game state for an empty board' do
    game = [0,0,0,0,0,0,0,0,0]
    game_state_store.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,0,0,0,0,0,0,0])
  end

  it 'can store a game state for a board that has been modified by player moves' do
    game = [1,2,1,0,0,0,2,1,2]
    game_state_store.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([1,2,1,0,0,0,2,1,2])
  end

  it 'can overwrrite an existing game state' do
    game = [0,0,0,0,0,0,0,0,0]
    game_state_store.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,0,0,0,0,0,0,0])
    game = [0,0,0,0,0,0,0,0,1]
    game_state_store.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,0,0,0,0,0,0,1]) 
  end
end
