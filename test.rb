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

end
