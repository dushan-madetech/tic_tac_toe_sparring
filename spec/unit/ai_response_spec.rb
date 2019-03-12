describe AIResponse do
  let(:game_state_gateway) { GameStateStorageGatewayFake.new }
  let(:ai_response) { described_class.new }

  context 'when given different games the ai can win in one move' do
    it 'can win in one move' do
      game_state_gateway.game_state = [1, 2, 0, 0, 2, 0, 1, 0, 0]
      expect(ai_response.execute(game_state_gateway.game_state)).to eq(4)
    end

    it 'can win in one move example two' do
      game_state_gateway.game_state = [0, 2, 1, 0, 2, 0, 0, 0, 1]
      expect(ai_response.execute(game_state_gateway.game_state)).to eq(6)
    end
  end
end
