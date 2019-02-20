require 'store_game_state'
describe StoreGameState do

  class GameStateStorageGatewaySpy
    attr_reader :last_game_saved

    def save(game)
      @last_game_saved = game
    end
  end

  it 'can store a game state for an empty board' do 
    game_state_gateway = GameStateStorageGatewaySpy.new
    game_state_store = StoreGameState.new(game_state_gateway: game_state_gateway)
    game = [0,0,0,0,0,0,0,0,0]
    game_state_store.execute(game)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,0,0,0,0,0,0,0])
  end

end