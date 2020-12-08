require_relative 'bootloader'

bl = BootLoader.new
already_duped = false
snap = nil
snapshots = []

until bl.eol? do
  bl.execute

  if bl.dupe?
    if !already_duped
      snapshots = bl.snapshots.dup
      already_duped = true
    else
      snap = snapshots.pop
      bl.accumulator = snap[:accumulator]
      bl.cursor = snap[:cursor] + 1
    end
  end
end

puts bl.accumulator
