class Grid

  DEFAULT_SIZE = 20

  def initialize(params = {})
    @width = params.fetch(:width, DEFAULT_SIZE)
    @height = params.fetch(:height, @width)
    @format = params.fetch(:format, nil)
    @top = 0
    @left = 0
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

  def render(data)
    data.each do |datum|
      x = datum[:x]
      y = datum[:y]
      @grid[y][x] = @format.call(datum)
    end
    @render.call(@grid)
  end

end

grid = Grid.new({
  format: -> data do
    output = data ? "*" : "."
  end
})

grid.render([
  { x: 1, y: 1 }
])
