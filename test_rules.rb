require 'test/unit'
require_relative 'rules'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :rules

  def setup
    @rules = Rules.new
  end

  def test_existing_location_doesnt_survive_if_less_than_two_neighbors
    result = rules.survivors(1)
    assert_equal(false, result)
  end

  def test_existing_location_persists_if_two_neighbors
    result = rules.survivors(2)
    assert_equal(true, result)
  end

  def test_existing_location_persists_if_three_neighbors
    result = rules.survivors(3)
    assert_equal(true, result)
  end

  def test_existing_location_doesnt_survive_if_more_than_three_neighbors
    result = rules.survivors(4)
    assert_equal(false, result)
  end

  def test_nonexistent_location_comes_to_life_if_3_neighbors
    result = rules.new_life(3)
    assert_equal(true, result)
  end

end
