# frozen_string_literal: true

class Board
  attr_accessor :grid, :current_player, :ai_player

  def initialize(grid = Array.new(9, 0), current_player = 1, ai_player = false)
    @grid = grid
    @current_player = current_player
    @ai_player = ai_player
  end

  def swap_player
    @current_player = @current_player == 1 ? 2 : 1
  end

  def play_ai
    @ai_player = true
  end
end
