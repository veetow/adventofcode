def main
  IO.foreach('input') do |first|
    first = first.chomp.to_i

    IO.foreach('input') do |second|
      second = second.chomp.to_i

      IO.foreach('input') do |third|
        third = third.chomp.to_i

        sum = first + second + third
        if sum == 2020 then
          puts first * second * third
          return
        end
      end
    end
  end
end

main
