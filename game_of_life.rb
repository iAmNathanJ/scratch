require_relative './navigator'
require_relative './rules'

class GameOfLife

  include Navigator
  include Rules

  def generate(locations)

  end

end

# life = GameOfLife.new()
#
# state = [
#   {x: 0, y: 0},
#   {x: 1, y: 0},
#   {x: 2, y: 0},
#   {x: 0, y: 1},
#   {x: 1, y: 1},
# ]
#
# p life.generate(state)
