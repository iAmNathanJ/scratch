require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :game

  def setup
    @game = GameOfLife.new
  end

  def test_game_exists
    assert_not_nil(game)
  end

  def test_interperets_non_existent_cells_as_zero
    assert_equal(0, game.interpret(nil))
  end

  def test_get_neighbor_returns_zero_if_cell_doenst_exist
    cell = game.get_cell(-1, -1)
    assert_equal(0, cell)
  end

  def test_generates_random_series_with_specified_length
    series = @game.random_series(8)
    assert(series.length == 8)
  end

  def test_generated_series_is_binary
    series = @game.random_series(8)
    series.each do |cell|
      assert(0 || 1 == cell)
    end
  end

  def test_seed_can_generate_square_grid
    game.seed(10)
    assert_equal(10, game.size(:x))
    assert_equal(10, game.size(:y))
  end

  def test_seed_can_generate_rectangle_grid
    game.seed(10, 5)
    assert_equal(10, game.size(:x))
    assert_equal(5, game.size(:y))
  end

  def test_cell_determines_own_next_state
    game.state = [
      [0, 1, 0, 0],
      [1, 1, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ]
    next_state = game.get_next_state(0, 0)
    assert_equal(1, next_state)
  end

  def test_next_generation_is_correct
    game.state = [
      [0, 1, 0, 0],
      [1, 1, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ]
    next_state = [
      [1, 1, 0, 0],
      [1, 1, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ]
    game.generate
    assert_equal(next_state, game.state)
  end

end
