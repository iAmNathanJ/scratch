require_relative 'cell'

class GameOfLife

  attr_reader :state

  def initialize(initial_state)
    @state = []
    @future = []
    initial_state.each { |coords| @state << Cell.new(coords) }
    build_future
  end

  def build_future
    @future.clear
    state.each do |cell|
      cell.influence.each do |neighbor|
        @future << neighbor
      end
    end
  end

  def state_coords
    @state.map do |cell|
      cell.coords
    end
  end

  def living?(coords)
    state_coords.include?(coords)
  end

  def neighbors(coords)
    @future.count(coords)
  end

  def survivor?(coords)
    neighbor_count = neighbors(coords)
    living?(coords) && neighbor_count > 1 && neighbor_count < 4
  end

  def new_life?(coords)
    neighbor_count = neighbors(coords)
    !living?(coords) && neighbor_count == 3
  end

  def generate
    build_future
    next_gen = @future.select { |coords| survivor?(coords) }.uniq
    next_gen += @future.select { |coords| new_life?(coords) }.uniq
    @state = next_gen.map do |coords|
      Cell.new(coords)
    end
  end

  def run
    begin
      generate
      sleep 0.5
    end while @future.length > 0
    yield(the_end)
  end

  private
  def the_end
    message = []
    File.open("./the_end.txt", "r") do |f|
      f.each_line { |line| message << line }
    end
    message
  end

end
