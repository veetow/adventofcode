input = IO.readlines('input')

timestamp = input[0].chomp.to_i
bus_ids   = input[1].chomp.split(',').reject { |x| x == 'x' }.map(&:to_i)

nearest_times = bus_ids.map do |id|
  at_least = timestamp / id
  at_least += 1 unless timestamp % id == 0
  
  id * at_least
end

nearest_time     = nearest_times.min
nearest_time_idx = nearest_times.index(nearest_time)

puts bus_ids[nearest_time_idx] * (nearest_time - timestamp)
