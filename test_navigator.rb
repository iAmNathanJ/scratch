require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    state = [
      { x: 0, y: 0 }, # <- 2 neighbors, will remain
      { x: 1, y: 0 },
      { x: 0, y: 1 },
      # { x: 1, y: 1 }, <- 3 neighbors, will come to life

      { x: 3, y: 3 }, # <- 0 neighbors, will die

      { x: 14, y: 15 },
      { x: 15, y: 15 }, # <- 3 neighbors, will remain
      { x: 16, y: 15 },
      { x: 15, y: 16 },

      { x: 25, y: 24 },
      { x: 25, y: 25 }, # <- 4 neighbors, will die
      { x: 25, y: 26 },
      { x: 26, y: 25 },
      { x: 26, y: 26 }
    ]
    @life = GameOfLife.new
  end

end
