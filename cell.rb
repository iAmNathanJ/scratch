class Cell

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
    # add z axis
    # @z = coords[:z]
  end

  def coords(offest_x = 0, offset_y = 0, offset_z = 0)
    {
      x: @x + offest_x,
      y: @y + offset_y
      # add z axis
      # z: @z + offset_z
    }
  end

  def influence(reach = 1)
    possible_cells = []
    for x in (-reach..reach)
      for y in (-reach..reach)
        # add loop for z axis
        # for z in (-reach..reach)
          possible_cells << coords(x, y, z) unless (x == 0 && y == 0 && z == 0)
        # end
      end
    end
    possible_cells
  end
end
