require_relative "game-of-life"

game = GameOfLife.new

game.seed

p game.state

game.generate

p game.state
