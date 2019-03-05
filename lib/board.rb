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

end