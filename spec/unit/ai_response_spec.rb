describe AIResponse do
  let(:game_state_gateway) { GameStateStorageGatewayFake.new }
  let(:ai_response) { described_class.new }

  context 'when given different games the ai can win in one move' do
    it 'can win in one move' do
      game_state_gateway.game_state = [1, 2, 0, 0, 2, 0, 1, 0, 0]
      ai_response.execute(game_state_gateway.game_state)
      expect(game_state_gateway.game_state).to eq([1, 2, 0, 1, 2, 0, 1, 0, 0])
    end

    it 'can win in one move example two' do
      game_state_gateway.game_state = [0, 2, 1, 0, 2, 0, 0, 0, 1]
      ai_response.execute(game_state_gateway.game_state)
      expect(game_state_gateway.game_state).to eq([0, 2, 1, 0, 2, 1, 0, 0, 1])
    end

    xit 'can win in one move example three' do
      game_state_gateway.game_state = [0, 0, 1, 0, 0, 2, 1, 0, 2]
      expect(ai_response.execute(game_state_gateway.game_state)).to eq(5)
    end
  end

  context 'when given different games the ai can block a winning move' do
    xit 'can block in one move' do
      game_state_gateway.game_state = [1, 0, 0, 0, 2, 0, 2, 0, 1]
      expect(ai_response.execute(game_state_gateway.game_state)).to eq(3)
    end
  end
end
