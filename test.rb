require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    state = [
      { x: 0, y: 0 },
      { x: 1, y: 0 },
      { x: 0, y: 1 },
      { x: 1, y: 1 }
    ]
    @life = GameOfLife.new(state)
  end

  def test_live_cell_continues_when_it_has_2_neighbors
    coords = life.state[0]
    cell = life.cell(:make, coords)
    assert( life.continue?(cell) )
  end

  def test_live_cell_continues_when_it_has_3_neighbors
    coords = life.state[0]
    cell = life.cell(:make, coords)
    assert( life.continue?(cell) )
  end

  def test_live_cell_dies_when_it_has_less_than_2_neighbors
    coords = life.state[0]
    cell = life.cell(:make, coords)
    assert( !life.continue?(cell) )
  end

  def test_live_cell_dies_when_it_has_more_than_3_neighbors
    coords = life.state[0]
    cell = life.cell(:make, coords)
    assert( !life.continue?(cell) )
  end

  def test_dead_cell_is_created_when_it_has_3_neighbors
    coords = life.state[0]
    cell = life.cell(:make, coords)
    assert( life.continue?(cell) )
  end

  def test_game_can_generate
  end

end
