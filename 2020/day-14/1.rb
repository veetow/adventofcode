mask   = 'X' * 36
memory = {}

def apply_mask(mask, value)
  value = ("%036b" % value)
  mask  = mask.split(//)
  zeros = mask.each_index.select { |i| mask[i] == '0' }
  ones  = mask.each_index.select { |i| mask[i] == '1' }

  zeros.each { |z| value[z] = '0' }
  ones.each  { |o| value[o] = '1' }

  value.to_i(2)
end

IO.foreach('input') do |line|
  line.chomp!
  m = line.match(/^mask = (.*)/)

  if m
    mask = m[1]
    next
  end

  m = line.match(/^mem\[(\d+)\] = (.*)/)

  mem_loc = m[1]
  value   = m[2]

  memory[mem_loc] = apply_mask(mask, value)
end

puts memory.values.reduce(:+)
