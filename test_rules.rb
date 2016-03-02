require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    @life = GameOfLife.new
  end

  def test_existing_location_doesnt_survive_if_less_than_three_neighbors
    result = life.survivors(true, 2)
    assert_equal(false, result)
  end

  def test_existing_location_persists_if_three_neighbors
    result = life.survivors(true, 3)
    assert_equal(true, result)
  end

  def test_existing_location_persists_if_four_neighbors
    result = life.survivors(true, 4)
    assert_equal(true, result)
  end

  def test_existing_location_doesnt_survive_if_more_than_four_neighbors
    result = life.survivors(true, 5)
    assert_equal(false, result)
  end

end
