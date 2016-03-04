require 'test/unit'
require_relative 'game_of_life'
require_relative 'surveyor'
require_relative 'rules'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    nav = XY_Surveyor.new
    rules = Rules.new
    @life = GameOfLife.new(nav, rules)
  end

  def test_generation
    locations = [
      { x: 0, y: 0 },
      { x: 1, y: 0 },
      { x: 0, y: 1 }
    ]
    result = life.generate(locations)
    expected = [
      { x: 0, y: 0 },
      { x: 1, y: 0 },
      { x: 0, y: 1 },
      { x: 1, y: 1 }
    ]
    expected.each { |coords| assert(result.include?(coords)) }
  end

  def test_another_bc_whatever
    locations = [
      { x: 0, y: 0 },
      { x: 1, y: 0 },
      { x: 2, y: 0 }
    ]
    result = life.generate(locations)
    expected = [
      { x: 1, y: -1 },
      { x: 1, y: 0 },
      { x: 1, y: 1 }
    ]
    expected.each { |coords| assert(result.include?(coords)) }
  end

end
