require_relative 'ferry'

def main
  ferry = Ferry.new

  until ferry.stabilized? do
    ferry.all_aboard_2
  end

  puts ferry.occupied_seat_count
end

main
