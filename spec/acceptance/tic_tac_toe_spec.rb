require 'store_game_state'
require'retrieve_game_state'
require 'modify_game_state'
require 'check_game_state'
require 'test_doubles/game_state_storage_gateway_fake'

describe 'Tic Tac Toe' do

  def given_a_new_game
    game_state = [0,0,0,0,0,0,0,0,0]
    store_game_state.execute(game_state)
  end

  let (:game_state_gateway) { GameStateStorageGatewayFake.new }
  let (:store_game_state) { StoreGameState.new(game_state_gateway: game_state_gateway) }
  let (:retrieve_game_state) { RetrieveGameState.new(game_state_gateway: game_state_gateway) }
  let (:modify_game_state) { ModifyGameState.new(game_state_gateway: game_state_gateway) }

  it 'can start a new game' do
    given_a_new_game
    expect(retrieve_game_state.execute).to eq([0,0,0,0,0,0,0,0,0])
  end

  it 'can allow a player to make a move from a starting state' do
    given_a_new_game
    modify_game_state.execute(6, 1)
    expect(retrieve_game_state.execute).to eq([0,0,0,0,0,1,0,0,0])
  end

  it 'can validate if player 1 has won' do
    check_game_state = CheckGameState.new(game_state_gateway: game_state_gateway)
    given_a_new_game
    modify_game_state.execute(1, 1)
    modify_game_state.execute(2, 1)
    modify_game_state.execute(3, 1)
    expect(check_game_state.execute).to eq('Player one wins')
  end




end
