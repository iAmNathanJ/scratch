class Rules

  def survivors(neighbors)
    neighbors.between?(2, 3)
  end

  def new_life(neighbors)
    neighbors == 3
  end

end
