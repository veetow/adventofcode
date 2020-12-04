valid = 0

IO.foreach('input') do |line|
  policy, password = line.chomp.strip.split(':')
  password.strip!
  policy = policy.split
  test_char = policy.last
  pos1, pos2 = policy.first.split('-')
  pos1 = pos1.to_i - 1
  pos2 = pos2.to_i - 1

  next if password[pos1] == test_char and password[pos2] == test_char
  next if password[pos1] != test_char and password[pos2] != test_char

  valid += 1
  puts "#{password} is valid for policy #{policy.first} #{test_char}"
  puts "pos1 is #{password[pos1]}, pos2 is #{password[pos2]}"
end

puts valid
