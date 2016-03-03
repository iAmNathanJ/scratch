class XY_Navigator

  def living?(location, locations)
    locations.include?(location)
  end

  def offset(location, offset_x = 0, offset_y = 0)
    {
      x: location[:x] + offset_x,
      y: location[:y] + offset_y
    }
  end

  def navigate(location, locations, proximity = 1)
    for x in (-proximity..proximity)
      for y in (-proximity..proximity)
        yield(x, y, location, locations)
      end
    end
  end

  def neighbors(location, locations)
    total = 0
    navigate(location, locations) do |x, y, loc, locs|
      if x == 0 && y == 0
        next
      else
        neighbor = offset(loc, x, y)
        total += 1 if living?(neighbor, locations)
      end
    end
    total
  end

  def influence(location, locations)
    possible_locations = []
    navigate(location, locations) do |x, y, loc, locs|
      neighbor = offset(loc, x, y)
      already_living = living?(neighbor, locs)
      already_listed = possible_locations.include?(neighbor)
      possible_locations << neighbor if !already_living && !already_listed
    end
    possible_locations
  end

end
