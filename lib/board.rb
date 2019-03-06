# frozen_string_literal: true

class Board
  attr_reader :grid, :current_player

  def initialize(grid = Array.new(9, 0),
                 current_player = 1)
    @grid = grid
    @current_player = current_player
  end

  def swap_player(current_player)
    @current_player = current_player == 1 ? 2 : 1
  end
end
