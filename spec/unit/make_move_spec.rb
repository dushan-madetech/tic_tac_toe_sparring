# frozen_string_literal: true

require 'make_move'
require 'board'
require 'tile_invalid_error'
require 'gateway/game_state_storage_gateway_fake'

describe MakeMove do
  def given_a_new_game
    board = Board.new
    game_state_gateway.game_state = board
  end

  let(:game_state_gateway) { GameStateStorageGatewayFake.new }
  let(:game_state_modify) do
    described_class.new(game_state_gateway: game_state_gateway)
  end

  context 'when given a new game' do
    before do
      given_a_new_game
    end

    it 'can return true when successfully executed' do
      expect(game_state_modify.execute(3, 1)).to eq(true)
    end

    it 'can modify the game state from the starting state' do
      game_state_modify.execute(3, 1)
      last_game = game_state_gateway.game_state
      expect(last_game.grid).to eq([0, 0, 1, 0, 0, 0, 0, 0, 0])
    end

    it 'can modify the game state twice in row' do
      game_state_modify.execute(3, 1)
      game_state_modify.execute(4, 2)
      last_game = game_state_gateway.game_state
      expect(last_game.grid).to eq([0, 0, 1, 2, 0, 0, 0, 0, 0])
    end

    it 'can prevent a move on an occupied tile' do
      game_state_modify.execute(3, 1)
      game_state_modify.execute(3, 2)
      last_game = game_state_gateway.game_state
      expect(last_game.grid).to eq([0, 0, 1, 0, 0, 0, 0, 0, 0])
    end
  end

  it 'can prevent an invalid move (invalid tile number given)' do
    game_state_gateway = GameStateStorageGatewayFake.new
    game_state_modify = described_class.new(
      game_state_gateway: game_state_gateway
    )
    expect do
      game_state_modify.execute(10, 1)
    end.to raise_exception(TileInvalidError, 'Tile out of bounds')
  end
end
