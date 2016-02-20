class GameOfLife

  attr_accessor :state

  def initialize
    @state = []
    @dimension = {
      :x => -> { @state[0].length },
      :y => -> { @state.length }
    }
  end

  def size(x_or_y)
    @dimension[x_or_y].call
  end

  def interpret(input)
    input || 0
  end

  def random_series(how_many)
    series = []
    for i in (1..how_many) do
      series << (rand).round
    end
    series
  end

  def seed(size_x, size_y = nil)
    size_y = size_x if !size_y
    for i in (1..size_y) do
      @state[i-1] = random_series(size_x)
    end
  end

  def get_cell(x, y)
    row = @state.fetch(y, nil)
    if row
      row.fetch(x, 0)
    else
      0
    end
  end

  def get_next_state(x, y)
    current_state = state[y][x]
    alive = (current_state == 1)
    neighbors = [
      get_cell(x-1, y-1),
      get_cell(x, y-1),
      get_cell(x+1, y-1),
      get_cell(x-1, y),
      get_cell(x+1, y),
      get_cell(x-1, y+1),
      get_cell(x, y+1),
      get_cell(x+1, y+1)
    ]

    live_neighbors = neighbors.reduce(:+)

    if alive
      (live_neighbors == 2 || live_neighbors == 3) ? 1 : 0
    else
      live_neighbors == 3 ? 1 : 0
    end
  end

  def generate
    new_state = state.each_with_index.map do |row, y_pos|
      row.each_with_index.map do |cell, x_pos|
        cell = get_next_state(x_pos, y_pos)
      end
    end
    @state = new_state
  end

end
