require_relative 'make_move'
require_relative 'determine_outcome'
require_relative 'board'
# require 'spec/test_doubles/game_state_storage_gateway_fake'
require_relative 'save_game'

class GameStateStorageGatewayFake
  attr_accessor :game_state

  def save(game)
    @game_state = game
  end

  def retrieve
    @game_state.dup
  end
end

class UserInterface
  def initialize(board_gateway)
    @board_gateway = board_gateway
    @make_move = MakeMove.new(game_state_gateway: @board_gateway)
    @determine_outcome = DetermineOutcome.new(
      game_state_gateway: @board_gateway
    )
  end

  def execute
    while @determine_outcome.execute.zero?
      board = @board_gateway.retrieve
      puts draw_grid(board.grid)
      @make_move.execute(request_input, board.current_player)
    end
    puts draw_grid(board.grid)
    output_outcome(@determine_outcome.execute)
  end

  private

  def output_outcome(outcome_code)
    outcomes = {
      1 => 'Player 1 Wins!',
      2 => 'Player 2 Wins!',
      3 => 'Draw!'
    }
    puts outcomes[outcome_code]
    outcomes[outcome_code]
  end

  def draw_grid(grid)
    output = "\n\n"
    0.upto(grid.length - 1) do |position|
      output << (grid[position] || position).to_s
      case position % 3
      when 0, 1 then output << ' | '
      when 2 then output << "\n-----------\n" unless position == grid.length - 1
      end
    end
    output << "\n"
    output
  end

  def request_input
    puts "\nplease enter the tile number you wish to play in"
    tile = gets
    Integer(tile)
  end
end
board_storage = GameStateStorageGatewayFake.new
board_storage.save(Board.new)

ui = UserInterface.new(board_storage)
ui.execute
