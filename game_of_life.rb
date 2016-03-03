class GameOfLife

  def initialize(nav, rules)
    @navigate = nav
    @rule = rules
  end

  def generate(locations)
    survivors = locations.select do |location|
      neighbors = @navigate.neighbors(location, locations)
      @rule.survivors(neighbors)
    end

    affected = locations.reduce([]) do |new_locations, location|
      new_locations + @navigate.influence(location, locations)
    end

    new_life = affected.select do |location|
      neighbors = @navigate.neighbors(location, locations)
      @rule.new_life(neighbors)
    end

    survivors + new_life
  end

end
