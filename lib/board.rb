# frozen_string_literal: true

class Board
  def initialize(grid = Array.new(9, 0),
                 current_player = 1)
    @grid = grid
    @current_player = current_player
  end

  attr_reader :grid

  attr_reader :current_player

  def swap_player(current_player)
    @current_player = current_player == 1 ? 2 : 1
  end
end
