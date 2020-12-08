class BootLoader
  attr_accessor :accumulator, :cursor, :snapshots

  def initialize
    @accumulator = 0
    @cursor = 0
    @instructions = IO.readlines('input')
    @lines_seen = []
    @snapshots = []
  end

  def dupe?
    @lines_seen.include? @cursor
  end

  def eol?
    @cursor >= @instructions.length
  end

  def execute
    @lines_seen << @cursor
    op, arg = read_instruction
  
    case op
    when 'acc'
      @accumulator += arg
      @cursor += 1
    when 'jmp'
      take_snapshot
      @cursor += arg
    else
      take_snapshot
      @cursor += 1
    end
  end

  def read_instruction(c=nil)
    c ||= @cursor
    op, arg = @instructions[c].chomp.split
    arg = arg.to_i

    return op, arg
  end
  
  def take_snapshot
    @snapshots << { cursor: @cursor, accumulator: @accumulator }
  end
end
