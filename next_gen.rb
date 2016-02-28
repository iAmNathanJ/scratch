class Generation

  attr_reader :generation

  def initialize
    @generation = {}
  end

  def id(coords)
    "#{coords[:x]}:#{coords[:y]}"
  end

  def add(coords, status)
    id = id(coords)
    if generation[id]
      generation[id][:neighbors] += 1
    else
      generation[id] = {}
      generation[id][:coords] = coords
      generation[id][:neighbors] = 1
      generation[id][:previously_living] = status
    end
  end

  def survivors(cell)
    cell[:previously_living] && cell[:neighbors] > 1 && cell[:neighbors] < 4
  end

  def new_life(cell)
    !cell[:previously_living] && cell[:neighbors] == 3
  end

  def output
    next_generation = generation.select { |cell| survivors(cell) }
    next_generation += generation.select { |cell| new_life(cell) }
    next_generation
  end

  def reset
    generation = {}
  end

end
