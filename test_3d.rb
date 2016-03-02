require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    state = [
      { x: 0, y: 0, z: 0 }, # <- 2 neighbors, will remain
      { x: 1, y: 0, z: 0 },
      { x: 0, y: 1, z: 0 },
      # { x: 1, y: 1, z: 0 }, # <- 3 neighbors, will come to life

      { x: 3, y: 3, z: 0 }, # <- 0 neighbors, will die

      { x: 14, y: 15, z: 0 },
      { x: 15, y: 15, z: 0 }, # <- 3 neighbors, will remain
      { x: 16, y: 15, z: 0 },
      { x: 15, y: 16, z: 0 },

      { x: 25, y: 24, z: 0 },
      { x: 25, y: 25, z: 0 }, # <- 4 neighbors, will die
      { x: 25, y: 26, z: 0 },
      { x: 26, y: 25, z: 0 },
      { x: 26, y: 26, z: 0 }
    ]
    @life = GameOfLife.new(state)
  end

  def test_live_cell_continues_when_it_has_2_neighbors
    coords = { x: 0, y: 0, z: 0 }
    assert( life.survivor?(coords) )
  end

  def test_live_cell_continues_when_it_has_3_neighbors
    coords = { x: 15, y: 15, z: 0 }
    assert( life.survivor?(coords) )
  end

  def test_live_cell_dies_when_it_has_less_than_2_neighbors
    coords = { x: 3, y: 3, z: 0 }
    assert( !life.survivor?(coords) )
  end

  def test_live_cell_dies_when_it_has_more_than_3_neighbors
    coords = { x: 25, y: 25, z: 0 }
    assert( !life.survivor?(coords) )
  end

  def test_non_existent_cell_is_created_when_it_has_3_neighbors
    coords = { x: 1, y: 1, z: 0 }
    assert( life.new_life?(coords) )
  end

  def test_life_can_generate
    life = GameOfLife.new([
      { x: 1, y: 0, z: 0 },
      { x: 1, y: 1, z: 0 },
      { x: 1, y: 2, z: 0 }
    ])

    next_gen = [
      { x: 0, y: 1, z: 0 },
      { x: 1, y: 1, z: 0 },
      { x: 2, y: 1, z: 0 }
    ]

    next_gen2 = [
      { x: 1, y: 0, z: 0 },
      { x: 1, y: 1, z: 0 },
      { x: 1, y: 2, z: 0 }
    ]

    life.generate
    life.state.each do |cell|
      assert(next_gen.include?(cell.coords))
    end

    life.generate
    life.state.each do |cell|
      assert(next_gen2.include?(cell.coords))
    end
  end

  def test_no_life
    life = GameOfLife.new([{ x: 1, y: 1, z: 0 }])
    life.generate
    assert_equal([], life.state)
    life.run do |msg|
      msg.each { |line| puts line }
    end
  end

end
