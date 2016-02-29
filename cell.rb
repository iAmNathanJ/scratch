class Cell

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
  end

  def coords(offest_x = 0, offset_y = 0)
    {
      x: @x + offest_x,
      y: @y + offset_y
    }
  end

  def influence(reach = 1)
    possible_cells = []
    for i in (-reach..reach)
      for j in (-reach..reach)
        possible_cells << coords(i, j) unless (i == 0 && j == 0)
      end
    end
    possible_cells
  end
end
