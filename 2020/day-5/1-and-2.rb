F = 'F'.freeze
B = 'B'.freeze
L = 'L'.freeze
R = 'R'.freeze

class Array
  def half
    self.each_slice((self.size/2.0).round).to_a
  end
end

seat_ids = []

IO.foreach('input') do |pass|
  rows = (0..127).to_a
  cols = (0..7).to_a

  pass.split(//).each do |c|
    case c
    when F
      rows, _ = rows.half
    when B
      _, rows = rows.half
    when L
      cols, _ = cols.half
    when R
      _, cols = cols.half
    end

    if rows.length == 1 && cols.length == 1 then
      seat_ids << rows[0] * 8 + cols[0]
    end
  end
end

seat_ids.sort!
high = seat_ids[seat_ids.length - 1]
missing = (seat_ids[0]..high).to_a.select { |s| ! seat_ids.include? s }

puts high
puts missing.inspect
