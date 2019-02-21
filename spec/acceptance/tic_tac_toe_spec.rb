require 'store_game_state'
require'retrieve_game_state'

describe 'Tic Tac Toe' do

  class GameStateStorageGateway

    def save(game)
      @game_state = game
    end

    def retrieve
      @game_state
    end
  end


  it 'can start a new game' do
    # game = Game.new
    game_state_gateway = GameStateStorageGateway.new
    store_game_state = StoreGameState.new(game_state_gateway: game_state_gateway)
    retrieve_game_state = RetrieveGameState.new(game_state_gateway: game_state_gateway)
    game_state = [0,0,0,0,0,0,0,0,0]
    store_game_state.execute(game_state)

    expect(retrieve_game_state.execute).to eq([0,0,0,0,0,0,0,0,0])
  end

  it 'can allow a player to make a move from a starting state' do
    game_state_gateway = GameStateStorageGateway.new
    store_game_state = StoreGameState.new(game_state_gateway: game_state_gateway)
    retrieve_game_state = RetrieveGameState.new(game_state_gateway: game_state_gateway)
    modify_game_state = ModifyGameState.new(game_state_gateway: game_state_gateway)
    game_state = [0,0,0,0,0,0,0,0,0]
    store_game_state.execute(game_state)
    expect(retrieve_game_state.execute).to eq([0,0,0,0,0,0,0,0,0])
    modify_game_state.execute(6, 1)
    expect(retrieve_game_state.execute).to eq([0,0,0,0,0,1,0,0,0])
  end
end
