group = []
sum = 0

def sum(ary)
  ary.flatten.uniq.count
end

IO.foreach('input') do |line|
  line = line.chomp.strip
  if line == "" then
    sum += sum(group)
    group = []
  else
    group << line.split(//)
  end
end

unless group.empty?
  sum += sum(group)
end

puts sum
