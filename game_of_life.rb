class GameOfLife

  def initialize(nav, rules)
    @navigate = nav
    @rules = rules
  end

  def generate(locations)
    survivors = locations.select { |location| @rules.survivors(@navigate.neighbors(location, locations)) }
    affected = locations.reduce([]) { |new_locations, location| new_locations + @navigate.influence(location, locations) }
    new_life = affected.select { |location| @rules.new_life(@navigate.neighbors(location, locations)) }
    survivors + new_life
  end

end
