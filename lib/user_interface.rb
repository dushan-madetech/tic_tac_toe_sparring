

class UserInterface
  def initialize(board)
    draw_grid(board.grid)
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
end
