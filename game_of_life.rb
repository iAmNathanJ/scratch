class GameOfLife

  def initialize(nav, rules)
    @navigate = nav
    @rules = rules
  end

  def generate(locations)
    locations
      .select { |l| @rules.survivors(@navigate.neighbors(l, locations)) }
      .concat(locations
        .reduce([]) { |acc, l| (acc + @navigate.influence(l, locations)) }
        .select { |l| @rules.new_life(@navigate.neighbors(l, locations)) })
  end

end
