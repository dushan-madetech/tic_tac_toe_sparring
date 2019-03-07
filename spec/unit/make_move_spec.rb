# frozen_string_literal: true

require 'make_move'
require 'board'
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
      expect do
        game_state_modify.execute(3, 2)
      end.to raise_error(OccupiedError, 'Cannot make the same move twice')
    end

    it 'can prevent an invalid move (invalid tile number given)' do
      expect do
        game_state_modify.execute(10, 1)
      end.to raise_error(IndexError, 'Tile out of bounds')
    end
  end
end
