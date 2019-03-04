# frozen_string_literal: true

require 'save_game'
require 'load_game'
require 'make_move'
require 'determine_outcome'
require 'test_doubles/game_state_storage_gateway_fake'

describe 'Tic Tac Toe' do
  
  let(:game_state_gateway) { GameStateStorageGatewayFake.new }
  let(:save_game) do
    SaveGame.new(game_state_gateway: game_state_gateway)
  end
  let(:load_game) do
    LoadGame.new(game_state_gateway: game_state_gateway)
  end
  let(:make_move) do
    MakeMove.new(game_state_gateway: game_state_gateway)
  end
  
  def given_a_new_game
    game_state = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    save_game.execute(game_state)
  end

  it 'can start a new game' do
    given_a_new_game
    expect(load_game.execute).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0])
  end

  it 'can allow a player to make a move from a starting state' do
    given_a_new_game
    make_move.execute(6, 1)
    expect(load_game.execute).to eq([0, 0, 0, 0, 0, 1, 0, 0, 0])
  end

  it 'can validate if player 1 has won' do
    determine_outcome = DetermineOutcome.new(
      game_state_gateway: game_state_gateway
    )
    given_a_new_game
    make_move.execute(1, 1)
    make_move.execute(2, 1)
    make_move.execute(3, 1)
    expect(determine_outcome.execute).to eq(1)
  end
end
