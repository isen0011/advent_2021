require_relative "point_3d"
require_relative "reactor_instruction"

class ReactorReboot
  attr_accessor :instructions
  def initialize(filename)
    self.instructions = get_instructions(filename)
  end

  def get_instructions(filename)
    File.readlines(filename).map(&:strip).map do |line|
      ReactorInstruction.new(line)
    end
  end

  def total_on_cubes
  end

  def all_steps
    instructions.each {|instruction| process_step(instr) }
  end

  def process_step(instr)
    base_size = get_size_of_cube(instr)
  end

  def set_point(point:, state:)
  end

  def outside_range(range)
    range.minmax.first < -50 || range.minmax.last > 50
  end
end
