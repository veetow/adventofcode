class Nav
  NORTH   = 'N'.freeze
  SOUTH   = 'S'.freeze
  EAST    = 'E'.freeze
  WEST    = 'W'.freeze
  LEFT    = 'L'.freeze
  RIGHT   = 'R'.freeze
  FORWARD = 'F'.freeze

  def initialize(input: 'input')
    @input = input
    @east_west = 0
    @north_south = 0
    @heading = 0
    @compass = [EAST, SOUTH, WEST, NORTH]
  end

  def calibrate_compass!
    while @heading >= @compass.length do
      @heading -= @compass.length
    end
    while @heading < 0 do
      @heading += @compass.length
    end
  end

  def heading
    @compass[@heading]
  end

  def manhattan_distance
    @east_west.abs + @north_south.abs
  end

  def move!(direction, distance)
    case direction
    when NORTH
      @north_south += distance
    when SOUTH
      @north_south -= distance
    when EAST
      @east_west += distance
    when WEST
      @east_west -= distance
    when FORWARD
      move!(@compass[@heading], distance)
    when LEFT
      @heading -= distance/90

      calibrate_compass!
    when RIGHT
      @heading += distance/90

      calibrate_compass!
    end
  end

  def parse_instructions!
    IO.foreach(@input) { |ins| move!(ins[0], ins[1..-1].to_i) }
  end
end
