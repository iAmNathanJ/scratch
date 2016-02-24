require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    @life = GameOfLife.new
  end

  def test_game_exists
    assert_not_nil(life)
  end

  def test_life_can_populate_itself
    life.seed
    assert_not_equal({}, life.state)
  end

  def test_inital_seed_can_have_max_size
    life.seed(100)
    assert(life.state.length <= 100)
  end

  def test_increment_will_create_non_existant_indices
    projection = {}
    projection_updated = { 0 => { 0 => 1 } }
    life.increment(projection, 0, 0)
    assert_equal(projection, projection_updated)
  end

  def test_projection_cell_can_be_incremented
    projection = { 0 => { 0 => 0 } }
    projection_updated = { 0 => { 0 => 1 } }
    life.increment(projection, 0, 0)
    assert_equal(projection, projection_updated)
  end

  def test_row_can_project_fate
    row_num = 0
    row_cells = [0]
    projection_from_row = life.project_row(row_num, row_cells)
    mock_projection = {
      -1 => { -1 => 1, 0 => 1, 1 => 1 },
       0 => { -1 => 1, 1 => 1 },
       1 => { -1 => 1, 0 => 1 , 1 => 1 }
    }
    assert_equal(mock_projection, projection_from_row)
  end

  def test_projections_can_be_merged
    projection_1 = {
      -1 => { -1 => 1, 0 => 1, 1 => 1 },
       0 => { -1 => 1, 1 => 1 },
       1 => { -1 => 1, 0 => 1 , 1 => 1 }
    }
    projection_2 = {
      -1 => { -1 => 1, 0 => 1, 2 => 1 },
       0 => { -1 => 1, 1 => 1 },
       1 => { -1 => 1, 0 => 1 , 1 => 1 },
       2 => { -1 => 1, 0 => 1 , 1 => 1 }
    }
    result = {
      -1 => { -1 => 2, 0 => 2, 1 => 1, 2 => 1 },
       0 => { -1 => 2, 1 => 2 },
       1 => { -1 => 2, 0 => 2 , 1 => 2 },
       2 => { -1 => 1, 0 => 1 , 1 => 1 }
    }
    merged_projection = life.merge_projections(projection_1, projection_2)
    assert_equal(result, merged_projection)
  end

  def test_mutiple_rows_can_project
    life.set_state({
      0 => [0],
      1 => [0]
      })
    mock_projection = {
      -1 => { -1 => 1, 0 => 1, 1 => 1 },
       0 => { -1 => 2, 0 => 1, 1 => 2 },
       1 => { -1 => 2, 0 => 1, 1 => 2 },
       2 => { -1 => 1, 0 => 1, 1 => 1 }
    }
    assert_equal(mock_projection, life.project_all)
  end

  def test_state_can_be_generated_from_projection
    life.set_state({
      0 => [1],
      1 => [0, 1]
      })
    projection = life.project_all
    new_state = life.parse_state(projection)
    mock_state = {
      0 => [0, 1],
      1 => [0, 1]
    }
    assert_equal(mock_state, new_state)
  end

  def test_life_can_generate
    life.set_state({
      1 => [1],
      2 => [1, 2]
    })
    life.generate
    new_state = {
      1 => [1, 2],
      2 => [1, 2]
    }
    assert_equal(new_state, life.state)
  end

  def test_cells_can_die
    life.set_state({
      2 => [1, 2, 3]
      })
    life.generate
    new_state = {
      1 => [2],
      2 => [2],
      3 => [2]
    }
    assert_equal(new_state, life.state)
  end

  def test_cells_can_exist_in_negative_space
    life.set_state({
      1 => [0],
      2 => [0],
      3 => [0]
      })
    life.generate
    new_state = {
      2 => [-1, 0, 1]
    }
    assert_equal(new_state, life.state)
  end

end
