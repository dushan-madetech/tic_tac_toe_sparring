

class UserInterface
  def initialize(board)
    draw_grid(board.grid)
  end

  def output_outcome(outcome_code)
    outcomes = {
      1 => "Player 1 Wins!",
      2 => "Player 2 Wins!",
      3 => "Draw!"
    }
    puts outcomes[outcome_code]
    outcomes[outcome_code]
  end

  private

  def draw_grid(grid)
    output = "\n\n"
    0.upto((grid.length)-1) do |position|
      output << "#{grid[position] || position}"
      case position % 3
        when 0, 1 then output << " | "
        when 2 then output << "\n-----------\n" unless position == (grid.length)-1
      end
    end
    output
  end

  def request_input
    puts "please enter the tile number you wish to play in"
    tile = gets
    Integer(tile)
  end
end
