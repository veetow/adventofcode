require_relative 'grid'

def main
  grid = Grid.new(right: 3, down: 1)

  loop do
    break if not grid.move!
  end

  puts grid.trees
end

main
