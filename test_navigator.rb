require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life, :locations

  def setup
    @locations = [
      { x: 0, y: 0 }, # <- 2 neighbors, will remain
      { x: 1, y: 0 },
      { x: 0, y: 1 }
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

  def test_navigator_informs_of_location_influence
    result = life.influence({ x: 0, y: 0 }, locations)
    expected = [
      { x: -1, y: -1 },
      { x: -1, y:  0 },
      { x: -1, y:  1 },
      { x:  0, y: -1 },
      { x:  1, y: -1 },
      { x:  1, y:  1 }
    ]
    assert_equal(expected, result)
  end

end
