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

  def influence
    [
      coords(-1, -1),
      coords( 0, -1),
      coords( 1, -1),
      coords(-1,  0),
      coords( 1,  0),
      coords(-1,  1),
      coords( 0,  1),
      coords( 1,  1)
    ]
  end
end
