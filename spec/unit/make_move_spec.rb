# frozen_string_literal: true

describe MakeMove do
  let(:game_state_gateway) { GameStateStorageGatewayFake.new }
  let(:make_move) do
    described_class.new(game_state_gateway: game_state_gateway)
  end
  let(:current_player) { game_state_gateway.retrieve.current_player }

  def given_a_new_game
    board = Board.new
    game_state_gateway.save(board)
  end

  context 'when given a new game' do
    before do
      given_a_new_game
    end

    it 'can return true when successfully executed' do
      expect(make_move.execute(3)).to eq(true)
    end

    it 'can modify the game state from the starting state' do
      make_move.execute(3)
      last_game = game_state_gateway.retrieve
      expect(last_game.grid).to eq([0, 0, 1, 0, 0, 0, 0, 0, 0])
    end

    it 'can modify the game state twice in row' do
      make_move.execute(3)
      make_move.execute(4)
      last_game = game_state_gateway.retrieve
      expect(last_game.grid).to eq([0, 0, 1, 2, 0, 0, 0, 0, 0])
    end

    it 'can swap the current player after a successful move' do
      make_move.execute(4)
      make_move.execute(5)
      last_game = game_state_gateway.retrieve
      expect(last_game.grid).to eq([0, 0, 0, 1, 2, 0, 0, 0, 0])
    end

    it 'can prevent a move on an occupied tile' do
      make_move.execute(3)
      expect(make_move.execute(3)).to eq(:occupied)
    end

    it 'can prevent an invalid move (invalid tile number given)' do
      expect(make_move.execute(10)).to eq(:invalid)
    end
  end
end
