class CheckGameState

  def initialize(game_state_gateway:)
    @game_state_gateway = game_state_gateway
  end

  def execute
    board = @game_state_gateway.retrieve
  
    if board[0] == 1
      return 'Player one wins'
    end 

  end
end
