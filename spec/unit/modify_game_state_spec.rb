 require 'modify_game_state'

describe ModifyGameState do

  class GameStateStorageGatewayFake
    attr_accessor :last_game_saved

    def save(game)
      @last_game_saved = game
    end

    def retrieve
       @last_game_saved
    end
  end
  
  def given_a_new_game
    game_state_gateway.last_game_saved = [0,0,0,0,0,0,0,0,0]
  end



  let (:game_state_gateway) { GameStateStorageGatewayFake.new }
  let (:game_state_modify) { ModifyGameState.new(game_state_gateway: game_state_gateway) }

  it 'can modify the game state from the starting state' do
    given_a_new_game

    game_state_modify.execute(3, 1)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,1,0,0,0,0,0,0])
  end

  it 'can modify the game state twice in row' do
    given_a_new_game

    game_state_modify.execute(3, 1)
    game_state_modify.execute(4, 2)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,1,2,0,0,0,0,0])
  end

  it 'can prevent a move on an occupied tile' do
    given_a_new_game

    game_state_modify.execute(3, 1)
    game_state_modify.execute(3, 2)
    last_game = game_state_gateway.last_game_saved
    expect(last_game).to eq([0,0,1,0,0,0,0,0,0])
  end

  it 'can prevent an invalid move (invalid tile number given)' do
    game_state_gateway = GameStateStorageGatewayFake.new
    game_state_modify = ModifyGameState.new(game_state_gateway: game_state_gateway)
    expect{ game_state_modify.execute(10, 1) }.to raise_exception(StandardError)
  end
end
