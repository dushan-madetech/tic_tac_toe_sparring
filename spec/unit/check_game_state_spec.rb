require 'check_game_state'

describe CheckGameState do

  class CheckGameStateStorageGatewayStub
    attr_writer :last_game_saved

    def retrieve
       return @last_game_saved
    end
  end

  let (:game_state_gateway) { CheckGameStateStorageGatewayStub.new }
  let (:check_game_state) { CheckGameState.new(game_state_gateway: game_state_gateway) }

  it 'can show when player one wins from a line' do
    game_state_gateway.last_game_saved = [1,1,1,0,0,0,0,0,0]
    expect(check_game_state.execute).to eq('Player one wins')
  end
end
