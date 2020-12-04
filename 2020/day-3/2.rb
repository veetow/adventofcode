require_relative 'grid'

def main
  product = nil
  steps = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ]

  steps.each do |step|
    grid = Grid.new(right: step[0], down: step[1])

    loop do
      break if not grid.move!
    end

    if product then
      product *= grid.trees
    else
      product = grid.trees
    end
  end

  puts product
end

main
