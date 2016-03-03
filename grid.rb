class XY_Grid

  DEFAULT_SIZE = 20

  def initialize(params = {})
    @width  = params.fetch(:width, DEFAULT_SIZE)
    @height = params.fetch(:height, @width)
    @format = params.fetch(:format, nil)
    @top = @left = 0
    @grid = []
    @height.times { @grid << Array.new(@width) }
    format_grid
  end

  def register(top, left)
    @top = top
    @left = left
  end

  def format_grid
    @grid = @grid.map do |row|
      row.map { |point| @format.call(point) }
    end
  end

  def clear_grid
    @grid = @grid.map do |row|
      row.map { |location| '.' }
    end
  end

  def update(locations)
    clear_grid
    locations.each do |point|
      x = point[:x]
      y = point[:y]
      @grid[y][x] = @format.call(point)
    end
  end

  def print_grid
    @grid.each { |row| p row }
  end

end

# grid = Grid.new({
#   format: -> point do
#     output = point ? "*" : "."
#   end
# })
