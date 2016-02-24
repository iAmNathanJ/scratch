class GameOfLife

  attr_reader :state

  CELL = {
    "create_id" => -> *coords { "#{coords[0]}:#{coords[1]}" },
    "x" => -> cell_id { cell_id.split(":")[0] },
    "y" => -> cell_id { cell_id.split(":")[1] }
  }

  def initialize(state)
    @state = state
    @neighbors = []
  end

  def continue?(cell)
    neighbors = get_neighbor_count(cell)
    if cell && neighbors > 1 && neighbors < 4
      true
    elsif neighbors === 3
      false
    end
  end

  def generate
    next_gen = []
    state.each do |cell|
      next_gen << cell if continue? cell
    end
    next_gen
  end

  private
  def get_neighbor_count(cell)
    0
  end

end
