# frozen_string_literal: true

class GameStateStorageGatewaySpy
  attr_reader :last_game_saved

  def save(game)
    @last_game_saved = game
  end
end
