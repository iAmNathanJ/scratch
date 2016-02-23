# XXX: OVERVIEW
# In this solution, state is stored in a hash where each hash key is an integer
# and represents each row in the 2D grid. Each "row" (hash[key]) is an array of
# integers. Each integer in the "row" array, represents a cell's location.
# The cells that exist in a given row are implicitly alive.
# Non-existent cells are implicitly dead. Dead cells have no bearing on the
# fate of neighboring cells and therefore are not tracked.

# XXX: EXAMPLE STATE
# {
#   1 => [1, 2,    4],
#   2 => [   2      ],
#   3 => [1, 2, 3, 4]
# }

# XXX: PROJECTIONS
# subsequent states are calculated by projecting scores for the possible cells
# that surround only the living (existing) cells.

# XXX: EXAMPLE PROJECTION
# {
#   # row
#   1 => {
#     # cells and their respective scores
#     1 => 4,
#     3 => 5
#   },
#
#   # row
#   2 => {
#     1 => 2,
#     3 => 4
#   }
# }

class GameOfLife

  attr_reader :state

  def initialize
    @state = {}
  end

  def seed(size = 10)
    for i in (1..size) do
      @state[i] = random_row(size)
    end
  end

  def set_state(new_state)
    @state = new_state
  end

  def increment(projection, y, x)
    projection[y] ||= {}
    projection[y][x] ||= 0
    projection[y][x] += 1
  end

  def project_row(row_num, row_cells)
    projection = {}
    row_cells.each do |cell|
      # left & right
      increment(projection, row_num, cell+1)
      increment(projection, row_num, cell-1)
      # top
      increment(projection, row_num-1, cell-1)
      increment(projection, row_num-1, cell)
      increment(projection, row_num-1, cell+1)
      # bottom
      increment(projection, row_num+1, cell-1)
      increment(projection, row_num+1, cell)
      increment(projection, row_num+1, cell+1)
    end
    projection
  end

  def merge_projections(projection_1, projection_2)
    projection_1.each_key do |row|
      new_row = {}
      if projection_2[row]
        new_row = projection_1[row].merge(projection_2[row]) do |cell, val_1, val_2|
          val_1 + val_2
        end
        projection_1[row] = new_row
      end
    end
    projection_2.merge(projection_1)
  end

  def project_all
    fate = {}
    @state.each_key do |row_num|
      row_projection = project_row(row_num, @state[row_num])
      fate = merge_projections(row_projection, fate)
    end
    fate
  end

  def update_cell(st, row, cell, score)
    if st[row] && st[row].include?(cell)
      if score < 2 || score > 3 # This cell is alive
        st[row].delete(cell) # Kill
        st.delete(row) if st[row].empty? # Remove dead rows
      end
    elsif score === 3 # This cell is dead
      st[row] ||= [] # Bring to life
      st[row] << cell
      st[row].sort!
      st[row].uniq!
    end
    st
  end

  def state_from_projection(projection)
    current_state = @state
    projection.each_key do |row_num|
      projection[row_num].each_key do |cell|
        cell_score = projection[row_num][cell]
        current_state = update_cell(current_state, row_num, cell, cell_score)
      end
    end
    current_state
  end

  def generate
    @state = state_from_projection(project_all)
  end

  private
  def random_row(max_size)
    row = []
    for i in (0..max_size)
      row << i if rand < 0.3
    end
    row
  end

end
