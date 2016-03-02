module Navigator

  include Rules

  def living?(location, locations)
    locations.include?(location)
  end

  def offset(location, offset_x = 0, offset_y = 0)
    {
      x: location[:x] + offset_x,
      y: location[:x] + offset_y
    }
  end

  def neighbors(location, locations, proximity = 1)
    total = 0
    for x in (-proximity..proximity)
      for y in (-proximity..proximity)
        if(x == 0 && y == 0)
          next
        else
          neighbor = offset(location, x, y)
          total += 1 if living?(neighbor, locations)
        end
      end
    end
    total
  end

end
