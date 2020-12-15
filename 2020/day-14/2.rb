mask   = '0' * 36
memory = {}

def apply_mask(mask, address)
  mask.split(//).each_with_index do |m, i|
    address[i] = m unless m == '0'
  end
  
  address
end

def apply_permutation(perms, indices, mask)
  values = []

  perms.each do |perm|
    addr = mask.dup
    indices.each do |i|
      addr[i] = perm.pop.to_s
    end

    values << addr
  end

  values
end

IO.foreach('input') do |line|
  line.chomp!
  m = line.match(/^mask = (.*)/)

  if m
    mask = m[1]
    next
  end

  m = line.match(/^mem\[(\d+)\] = (.*)/)

  arr     = []
  value   = m[2].to_i
  mem_loc = apply_mask(mask, ("%036b" % m[1].to_i))
  exes    = mem_loc.split(//).each_index.select { |i| mask[i] == 'X' }

  exes.length.times do arr << 0; arr << 1 end
  perms = arr.combination(exes.length).to_a.uniq
  
  apply_permutation(perms, exes, mem_loc).each do |loc|
    memory[loc] = value
  end
end

puts memory.values.reduce(:+)
