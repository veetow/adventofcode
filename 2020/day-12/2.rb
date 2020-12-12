require_relative 'waypoint'

nav = Nav.new#(input: 'input-sample')

nav.parse_instructions!

puts nav.ship.manhattan_distance
