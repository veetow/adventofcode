require_relative 'nav'

nav = Nav.new#(input: 'input-sample')

nav.parse_instructions!

puts nav.manhattan_distance
