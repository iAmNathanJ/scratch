 class XY_Surveyor

  def survey(proximity = 1)
    for x in (-proximity..proximity)
      for y in (-proximity..proximity)
        yield(x, y)
      end
    end
  end

  def living?(target, context)
    context.include?(target)
  end

  def offset(target, offset_x = 0, offset_y = 0)
    {
      x: target[:x] + offset_x,
      y: target[:y] + offset_y
    }
  end

  def neighbors(target, context)
    total = 0
    survey do |x, y|
      if x == 0 && y == 0
        next
      else
        neighbor = offset(target, x, y)
        total += 1 if living?(neighbor, context)
      end
    end
    total
  end

  def influence(target, context)
    possible_locations = []
    survey do |x, y|
      neighbor = offset(target, x, y)
      already_living = living?(neighbor, context)
      already_listed = possible_locations.include?(neighbor)
      possible_locations << neighbor if !already_living && !already_listed
    end
    possible_locations
  end

end

class XYZ_Surveyor

  def survey(proximity = 1)
    for x in (-proximity..proximity)
      for y in (-proximity..proximity)
        for z in (-proximity..proximity)
          yield(x, y, z)
        end
      end
    end
  end

  def living?(target, context)
    context.include?(target)
  end

  def offset(target, offset_x = 0, offset_y = 0, offset_z = 0)
    {
      x: target[:x] + offset_x,
      y: target[:y] + offset_y,
      z: target[:z] + offset_z
    }
  end

  def neighbors(target, context)
    total = 0
    survey do |x, y, z|
      if x == 0 && y == 0 && z == 0
        next
      else
        neighbor = offset(target, x, y, z)
        total += 1 if living?(neighbor, context)
      end
    end
    total
  end

  def influence(target, context)
    possible_locations = []
    survey do |x, y, z|
      neighbor = offset(target, x, y, z)
      already_living = living?(neighbor, context)
      already_listed = possible_locations.include?(neighbor)
      possible_locations << neighbor if !already_living && !already_listed
    end
    possible_locations
  end

end
