data = IO.readlines('input').map(&:to_i)
bad_one = nil

def has_sum(preamble, target)
  preamble.each do |i|
    preamble.each do |j|
      next if i == j
      return true if i + j == target
    end
  end

  false
end

until bad_one do
  (25..data.length-1).to_a.each do |idx|
    preamble = data[idx-25..idx-1]
    target   = data[idx]

    bad_one = target unless has_sum(preamble, target)
  end
end

puts bad_one
