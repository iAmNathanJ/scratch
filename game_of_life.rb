class GameOfLife

  def initialize(state)
    @life_list = []
    @dead_list = []
    @neighbor_list = {}
    @cell = {
      :make => -> coords { "#{coords[:x]}:#{coords[:y]}" },
      :x => -> cell { cell.split(":")[0].to_i },
      :y => -> cell { cell.split(":")[1].to_i }
    }
    state.each { |coords| @life_list << cell(:make, coords) }
  end

  def cell(fn, args)
    @cell[fn].call(args)
  end

  def continue?(c)
    neighbors = @neighbor_list[c] || 0
    alive?(c) ?
      (neighbors > 1 && neighbors < 4) :
      (neighbors === 3)
  end

  def alive?(c)
    @life_list.include?(c)
  end

  def add_neighbors(c)
    cs = []
    for i in (-1..1) do
      for j in (-1..1) do
        if(i != 0 && j != 0)
          cs << cell(:make, {x: cell(:x, c)-1, y: cell(:y, c)-1})
        end
      end
    end
    # [
    #   cell(:make, {x: cell(:x, c)-1, y: cell(:y, c)-1}),
    #   cell(:make, {x: cell(:x, c)-1, y: cell(:y, c)  }),
    #   cell(:make, {x: cell(:x, c)-1, y: cell(:y, c)+1}),
    #   cell(:make, {x: cell(:x, c)  , y: cell(:y, c)  }),
    #   cell(:make, {x: cell(:x, c)  , y: cell(:y, c)  }),
    #   cell(:make, {x: cell(:x, c)+1, y: cell(:y, c)-1}),
    #   cell(:make, {x: cell(:x, c)+1, y: cell(:y, c)  }),
    #   cell(:make, {x: cell(:x, c)+1, y: cell(:y, c)+1})
    # ]
    cs.each do |c|
      @neighbor_list[c] = 1
    end
  end

  def build_neighbors
    @life_list.each do |c|
      add_neighbors(c)
    end
    p @neighbor_list
  end

  def generate
    next_gen = []
    build_neighbors
    @state.each { |c| next_gen << c if continue?(c) }
    next_gen
  end

  def state
    @life_list.map do |c|
      {
        x: cell(:x, c),
        y: cell(:y, c)
      }
    end
  end

end

life = GameOfLife.new([
  { x: 0, y: 0 },
  { x: 1, y: 0 },
  { x: 0, y: 1 },
  { x: 1, y: 1 }
])

life.build_neighbors
