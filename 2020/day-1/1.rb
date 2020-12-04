def main
  IO.foreach('input') do |first|
    first = first.chomp.to_i
    IO.foreach('input') do |second|
      second = second.chomp.to_i
      sum = first + second

      if sum == 2020 then
        puts first * second
        return
      end
    end
  end
end

main
