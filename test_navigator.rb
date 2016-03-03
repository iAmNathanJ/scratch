require 'test/unit'
require_relative 'navigator'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :locations, :nav

  def setup
    @locations = [
      { x: 0, y: 0 },
      { x: 1, y: 0 },
      { x: 0, y: 1 }
    ]
    @nav = XY_Navigator.new
  end

  def test_navigator_confirms_location_exists
    result = nav.living?({ x: 0, y: 0 }, locations)
    assert_equal(true, result)
  end

  def test_navigator_counts_existing_neighbors_of_given_location
    result = nav.neighbors({ x: 0, y: 0 }, locations)
    assert_equal(2, result)
    result = nav.neighbors({ x: -1, y: 0 }, locations)
    assert_equal(2, result)
  end

  def test_navigator_informs_possible_influence_of_given_location
    result = nav.influence({ x: 0, y: 0 }, locations)
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
