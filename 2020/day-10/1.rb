current = 0
ones = 0
threes = 0

data = IO.readlines('input').map(&:to_i).sort

data.each do |a|
  plus_one = current + 1
  plus_three = current + 3
  if a >= plus_one && a <= plus_three
    ones += 1 if a == plus_one
    threes += 1 if a == plus_three
    current = a
    next
  end

  puts "skipped #{a}"
end

# phone built-in
threes += 1

puts threes
puts ones * threes
