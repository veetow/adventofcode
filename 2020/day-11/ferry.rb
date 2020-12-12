class Ferry
  EMPTY    = 'L'.freeze
  FLOOR    = '.'.freeze
  OCCUPIED = '#'.freeze

  def initialize(input: 'input')
    @stabilized = false
    @current_layout = []
    IO.foreach(input) { |line| @current_layout << line.chomp }
    @rows = @current_layout.length
    @columns = @current_layout[0].length
    copy_current_layout
  end

  def copy_current_layout
    @next_layout = Marshal.load(Marshal.dump(@current_layout))
  end

  def copy_next_layout
    @current_layout = Marshal.load(Marshal.dump(@next_layout))
  end

  def all_aboard
    for r in (0..@rows-1) do
      for c in (0..@columns-1) do
        boop_the_seat(r, c)
      end
    end

    finalize!
  end

  def all_aboard_2
    for r in (0..@rows-1) do
      for c in (0..@columns-1) do
        boop_the_seat_2(r, c)
      end
    end

    finalize!
  end

  def boop_the_seat(row, column)
    case seat_status(row, column)
    when EMPTY
      @next_layout[row][column] = OCCUPIED if occupied_adjacent_seat_count(row, column) == 0
    when OCCUPIED
      @next_layout[row][column] = EMPTY if occupied_adjacent_seat_count(row, column) >= 4
    end
  end

  def boop_the_seat_2(row, column)
    case seat_status(row, column)
    when EMPTY
      @next_layout[row][column] = OCCUPIED if occupied_visible_seat_count(row, column) == 0
    when OCCUPIED
      @next_layout[row][column] = EMPTY if occupied_visible_seat_count(row, column) >= 5
    end
  end

  def stabilized?
    @stabilized
  end

  def finalize!
    return @stabilized if @stabilized

    if @next_layout == @current_layout
      return @stabilized = true
    end

    copy_next_layout

    false
  end

  def occupied_seat_count
    count = 0
    for r in (0..@rows-1) do
      for c in (0..@columns-1) do
        count += 1 if occupied?(r, c)
      end
    end

    count
  end

  def empty?(row, column)
    seat_status(row, column) == EMPTY
  end

  def occupied?(row, column)
    seat_status(row, column) == OCCUPIED
  end

  def seat_status(row, column)
    return if row < 0 || column < 0 || row > @rows - 1 || column > @columns - 1

    @current_layout[row][column]
  end

  def occupied_adjacent_seat_count(row, column)
    adjacent_seat_locations(row, column).select { |r, c| occupied?(r, c) }.length
  end

  def adjacent_seat_locations(row, column)
    [
      [row-1, column-1], [row-1, column], [row-1, column+1],
      [row,   column-1],                  [row,   column+1],
      [row+1, column-1], [row+1, column], [row+1, column+1]
    ]
  end

  def occupied_visible_seat_count(row, column)
    [
      look_up_left(row, column),   look_up(row, column),   look_up_right(row, column),
      look_left(row, column),                              look_right(row, column),
      look_down_left(row, column), look_down(row, column), look_down_right(row, column)
    ].count(true)
  end

  def look_up_left(row, column)
    return false if row == 0 || column == 0

    loop do
      row -= 1
      column -= 1

      return false if row < 0 || column < 0 || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_up(row, column)
    return false if row == 0

    loop do
      row -= 1

      return false if row < 0 || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_up_right(row, column)
    return false if row == 0 || column > @columns-1

    loop do
      row -= 1
      column += 1

      return false if row < 0 || column == @columns || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_left(row, column)
    return false if column == 0

    loop do
      column -= 1

      return false if column < 0 || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_right(row, column)
    return false if column > @columns-1

    loop do
      column += 1

      return false if column == @columns || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_down_left(row, column)
    return false if row > @rows-1 || column == 0

    loop do
      row += 1
      column -= 1

      return false if row == @rows || column < 0 || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_down(row, column)
    return false if row > @rows-1

    loop do
      row += 1

      return false if row == @rows || empty?(row, column)
      return true if occupied?(row, column)
    end
  end

  def look_down_right(row, column)
    return false if row > @rows-1 || column > @columns-1

    loop do
      row += 1
      column += 1

      return false if row == @rows || column == @columns || empty?(row, column)
      return true if occupied?(row, column)
    end
  end
end
