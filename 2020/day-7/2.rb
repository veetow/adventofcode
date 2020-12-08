NO_OTHER   = 'no other bags'.freeze
SHINY_GOLD = 'shiny gold bags'.freeze
RULES      = IO.readlines('input').freeze

def count_inside(rule, multiplier)
  count = 0
  inside_count = 0
  _, inside = rule.chomp.split(/contain/).map(&:strip)

  inside.split(',').map(&:strip).each do |i|
    i.gsub!(/\.$/, '')
    return 0 if i.match(/^#{NO_OTHER}/)

    i = i.split
    num = i[0].to_i
    color = i[1..2].join(' ')

    count += num
    inside_count += count_inside(rule_for_color(color), num * multiplier)
  end

  multiplier * count + inside_count
end

def rule_for_color(color)
  RULES.find do |line|
    line.match(/^#{color}/)
  end
end

puts count_inside(rule_for_color(SHINY_GOLD), 1)
