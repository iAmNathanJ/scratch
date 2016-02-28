require_relative 'cell'
require_relative 'next_gen'

class GameOfLife

  attr_reader :state, :next_generation

  def initialize(initial_state)
    @state = []
    @next_generation = Generation.new
    initial_state.each { |coords| @state << Cell.new(coords[:x], coords[:y]) }
  end

  def build_next_gen
    state.each do |cell|
      cell.influence.each do |coords|
        status = living?(coords)
        next_generation.add(coords, status)
      end
    end
  end

  def living?(coords)
    for i in (0..state.length)
      return true if state[i].coords == coords
    end
  end

  def generate
    build_next_gen
    state = next_generation.output.map do |cell|
      Cell.new(cell.coords)
    end
    next_generation.reset
  end
end
