module Rules

  def survivors(alive, neighbors)
    alive && neighbors.between?(3, 4)
  end

  def new_life(alive, neighbors)
    !alive && neighbors == 3
  end

end
