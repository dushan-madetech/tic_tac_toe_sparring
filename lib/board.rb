class Board
  def initialize(grid = Array.new(9, 0),
                current_player = 1
                )
    @grid = grid
    @current_player = current_player
  end

  def grid
    @grid
  end

  def current_player
    @current_player
  end

  def swap_player(current_player)
    current_player == 1 ? @current_player = 2 : @current_player = 1
  end
end
