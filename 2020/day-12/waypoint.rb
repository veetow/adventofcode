class Locatable
  def initialize(east_west:, north_south:)
    @east_west = east_west
    @north_south = north_south
  end

  def location
    return @east_west, @north_south
  end

  def manhattan_distance
    @east_west.abs + @north_south.abs
  end

  def move_north!(distance)
    @north_south += distance

    location
  end

  def move_south!(distance)
    @north_south -= distance

    location
  end

  def move_east!(distance)
    @east_west += distance

    location
  end

  def move_west!(distance)
    @east_west -= distance

    location
  end
end

class Waypoint < Locatable
  def initialize
    super(east_west: 10, north_south: 1)
  end

  def rotate_left!(degrees)
    (degrees/90).times { rotate_left_90! }

    location
  end

  def rotate_right!(degrees)
    (degrees/90).times { rotate_right_90! }

    location
  end

  def rotate_left_90!
    orig_ew = @east_west
    @east_west = -1 * @north_south
    @north_south = orig_ew

    location
  end

  def rotate_right_90!
    orig_ns = @north_south
    @north_south = -1 * @east_west
    @east_west = orig_ns

    location
  end
end

class Ship < Locatable
  def initialize
    super(east_west: 0, north_south: 0)
  end
end

class Nav
  NORTH   = 'N'.freeze
  SOUTH   = 'S'.freeze
  EAST    = 'E'.freeze
  WEST    = 'W'.freeze
  LEFT    = 'L'.freeze
  RIGHT   = 'R'.freeze
  FORWARD = 'F'.freeze

  attr_reader :ship, :waypoint

  def initialize(input: 'input')
    @input    = input
    @ship     = Ship.new
    @waypoint = Waypoint.new
  end

  def move!(direction, arg)
    case direction
    when NORTH
      @waypoint.move_north!(arg)
    when SOUTH
      @waypoint.move_south!(arg)
    when EAST
      @waypoint.move_east!(arg)
    when WEST
      @waypoint.move_west!(arg)
    when LEFT
      @waypoint.rotate_left!(arg)
    when RIGHT
      @waypoint.rotate_right!(arg)
    when FORWARD
      move_ship_toward_waypoint!(arg)
    end
  end

  def move_ship_toward_waypoint!(multiplier)
    wew, wns = @waypoint.location

    if wew > 0
      @ship.move_east!(multiplier * wew.abs)
    elsif wew < 0
      @ship.move_west!(multiplier * wew.abs)
    end

    if wns > 0
      @ship.move_north!(multiplier * wns.abs)
    elsif wns < 0
      @ship.move_south!(multiplier * wns.abs)
    end
  end

  def parse_instructions!
    IO.foreach(@input) { |ins| move!(ins[0], ins[1..-1].to_i) }
  end
end
