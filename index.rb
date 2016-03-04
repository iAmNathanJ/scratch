require_relative 'game_of_life'
require_relative 'surveyor'
require_relative 'rules'
require_relative 'grid'

class GameOfLifeDriver

  def initialize

    nav = XY_Surveyor.new
    rules = Rules.new
    @game_instance = GameOfLife.new(nav, rules)

    @input = [
      { x: 0, y: 0 },
      { x: 1, y: 0 },
      { x: 2, y: 0 },
      { x: 1, y: 1 },
      { x: 2, y: 2 },
      { x: 3, y: 2 },
      { x: 3, y: 3 },
      { x: 4, y: 3 }
    ]

    @output = XY_Grid.new({
      width: 20,
      height: 30,
      format: -> point do
        !point || point == "." ? "." : "*"
      end
    })

    @game_instance.add_observer(@output)

  end

  def run
    count = 0
    loop do
      count += 1
      go = gets.chomp
      if go
        puts "\n Generation #{count}"
        @input = @game_instance.generate(@input)
        @output.print_grid
      end
    end
  end

end


driver = GameOfLifeDriver.new
driver.run
