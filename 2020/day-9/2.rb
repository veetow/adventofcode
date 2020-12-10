data = IO.readlines('input').map(&:to_i)
target = 27911108

loop do
  data.each_with_index do |d, idx|
    (idx+1..data.length-1).each do |_end|
      range = data[idx.._end]
      if range.sum == target
        low = range.min
        high = range.max
        puts low + high
        exit
      end
    end
  end
end
