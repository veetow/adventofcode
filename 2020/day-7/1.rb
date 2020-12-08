require_relative 'bag'

bags  = {}
count = 0

NO_OTHER   = 'no other'.freeze
SHINY_GOLD = 'shiny gold'.freeze

IO.foreach('input') do |line|
  line.chomp!
  outside, inside = line.split(/contain/)
                        .map { |x| x.gsub(/bags?\.?/, '').gsub(/[\d]+/, '') }
                        .map(&:strip)
  inside = inside.split(',').map(&:strip)

  bags[outside] = Bag.new(name: outside) unless bags[outside]
  inside.each do |i|
    next if i == NO_OTHER
    bags[i] = Bag.new(name: i) unless bags[i]
    bags[outside].bags << bags[i]
  end
end

bags.each do |_, bag|
  count +=1 if bag.flatten_bags.uniq.include? SHINY_GOLD
end

puts count
