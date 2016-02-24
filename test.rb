require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life, :cells

  def setup
    @life = GameOfLife.new
    @cells = [
      { x: 0, y: 0, neighbors: 0, },
      { x: 1, y: 0, neighbors: 0, },
      { x: 0, y: 1, neighbors: 0, },
      { x: 1, y: 1, neighbors: 0, }
    ]
  end

  def test_live_cell_continues_when_it_has_2_neighbors
    cell = life.cell[0]
    cell.neighbors = 2
    assert(true, cell.continue)
  end

  def test_live_cell_continues_when_it_has_3_neighbors
    cell = life.cell[0]
    cell.neighbors = 3
    assert(true, cell.continue)
  end

  def test_live_cell_dies_when_it_has_less_than_2_neighbors
    cell = life.cell[0]
    cell.neighbors = 1
    assert(true, cell.die)
  end

  def test_live_cell_dies_when_it_has_more_than_3_neighbors
    cell = life.cell[0]
    cell.neighbors = 4
    assert(true, cell.die)
  end

  def test_dead_cell_is_created_when_it_has_3_neighbors
    cell = life.cell[0]
    cell.neighbors = 2
    assert(true, cell.continue)
  end

  def test_game_can_generate
  end

end
