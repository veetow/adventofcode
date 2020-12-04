valid = 0

IO.foreach('input') do |line|
  policy, password = line.chomp.strip.split(':')
  password.strip!
  policy = policy.split
  required_char = policy.last
  min, max = policy.first.split('-')
  min = min.to_i
  max = max.to_i
  found = password.scan(required_char).length

  if found >= min and found <= max then
    valid += 1
  end
end

puts valid
