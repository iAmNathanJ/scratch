require 'test/unit'
require_relative 'game_of_life'

class TestGameOfLife < Test::Unit::TestCase

  attr_reader :life

  def setup
    @life = GameOfLife.new
  end

end
