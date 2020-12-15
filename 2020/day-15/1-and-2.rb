input = [6,19,0,5,7,13,1]
MAX_T = 30000000

numbers     = {}
turn        = 1
last_spoken = nil

until turn > MAX_T do
  starting_number = input.length > 0
  consider = input.shift
  consider ||= last_spoken
  numbers[consider] ||= []
  seen = starting_number ? :starting_number : numbers[consider].length

  case seen
  when :starting_number
    last_spoken = consider
  when 2
    last_spoken = numbers[consider].reduce(:-).abs
  else
    last_spoken = 0
  end

  numbers[last_spoken] ||= []
  numbers[last_spoken] << turn
  numbers[last_spoken].shift if numbers[last_spoken].length > 2

  puts last_spoken if turn == 2020 || turn == 30000000
  turn += 1
end
