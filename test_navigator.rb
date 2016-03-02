require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life, :locations

  def setup
    @locations = [
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

  def test_navigator_confirms_location_exists
    result = life.living?({ x: 0, y: 0 }, locations)
    assert_equal(true, result)
  end

  def test_navigator_counts_existing_neighbors_of_location
    result = life.neighbors({ x: 0, y: 0 }, locations)
    assert_equal(2, result)
  end

  def test_navigator_informs_of_locations_influence
    result = life.influence({ x: 0, y: 0 })
    expected = [
      { x: -1, y: -1 },
      { x: -1, y:  0 },
      { x: -1, y:  1 },
      { x:  0, y: -1 },
      { x:  0, y:  1 },
      { x:  1, y: -1 },
      { x:  1, y:  0 },
      { x:  1, y:  1 }
    ]
    assert_equal(expected, result)
  end

end
