class Grid
  TREE = '#'.freeze

  attr_accessor :trees

  def initialize(input: 'input', column: 0, row: 0, right: 1, down: 1)
    @column = column
    @down   = down
    @grid   = []
    @right  = right
    @row    = row
    @trees  = 0

    IO.foreach(input) { |line| @grid << line.chomp.split(//) }
  end

  def current_location
    @grid[@row][@column]
  end

  def move!
    move_down!
    return false if off_grid?

    move_right!
    @trees += 1 if tree?

    true
  end

  def move_down!
    @row += @down
  end

  def move_right!
    @column += @right
    width = @grid[@row].length

    while @column >= width do
      @column -= width
    end
  end

  def off_grid?
    @row >= @grid.length
  end

  def tree?
    current_location == TREE
  end
end
