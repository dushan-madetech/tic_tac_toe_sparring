require_relative 'gateway/game_state_storage_gateway_fake'
require_relative 'make_move'
require_relative 'determine_outcome'
require_relative 'board'
require_relative 'save_game'

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
      validation(@make_move.execute(request_input))
    end
    puts draw_grid(board.grid)
    output_outcome(@determine_outcome.execute)
  end

  private

  def validation(error)
    case error
    when :invalid
      puts "\nValid tile number required. Choose a tile between 1 and 9!"
    when :occupied
      puts "\nCannot place mark on occupied tile!"
    end
  end

  #   @make_move.execute(request_input)
  # rescue IndexError, ArgumentError
  #   puts "\nValid mark required. Choose a tile between 1 and 9!"
  # rescue OccupiedError
  #   puts "\nCannot place mark on occupied tile!"
  # end

  def output_outcome(outcome_code)
    outcomes = {
      1 => 'Player 1 Wins!',
      2 => 'Player 2 Wins!',
      3 => 'Draw!'
    }
    puts outcomes[outcome_code]
  end

  def draw_grid(grid)
    output = "\n"
    0.upto(grid.length - 1) do |position|
      output << (grid[position] || position).to_s
      case position % 3
      when 0, 1 then output << ' | '
      when 2 then output << "\n----------\n" unless position == grid.length - 1
      end
    end
    output << "\n\n"
  end

  def request_input
    print "Player #{@board_gateway.retrieve.current_player}, " \
          'please enter the tile number you wish to play in: '
    tile = gets
    letters = tile.chomp.scan(/\D/)
    if letters.length >= 1
      tile = -1
    else
      tile.to_i
    end
  end
end

board_storage = GameStateStorageGatewayFake.new
board_storage.save(Board.new)

ui = UserInterface.new(board_storage)
ui.execute
