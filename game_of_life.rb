require_relative './navigator'
require_relative './rules'

class GameOfLife

  include Navigator
  include Rules

  def generate(locations)
    locations
      .select { |l| survivors(neighbors(l, locations)) }
      .concat(locations
        .reduce([]) { |acc, l| (acc + influence(l, locations)).uniq }
        .select { |l| new_life(neighbors(l, locations)) })
  end

end
