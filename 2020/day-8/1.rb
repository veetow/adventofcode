require_relative 'bootloader'

bl = BootLoader.new

while !bl.dupe? do
  bl.execute
end

puts bl.accumulator
