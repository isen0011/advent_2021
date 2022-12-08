require_relative "point_3d"

class ReactorReboot
  class ReactorInstruction
    attr_accessor :x, :y, :z, :state
    def initialize(line)
      state_split = line.split(" ")
      self.state = state_split.first
      coord_split = state_split.last.split(",")
      coord_split.each do |coord|
        set_split = coord.split("=")
        vals_split = set_split.last.split("..")
        case set_split.first
        when "x"
          self.x = Range.new(vals_split.first.to_i, vals_split.last.to_i)
        when "y"
          self.y = Range.new(vals_split.first.to_i, vals_split.last.to_i)
        when "z"
          self.z = Range.new(vals_split.first.to_i, vals_split.last.to_i)
        end
      end
    end

    def to_s
      "#{x}, #{y}, #{z}, set: #{state}"
    end
  end

  attr_accessor :cube_list, :instructions
  def initialize(filename)
    self.cube_list = Hash.new(false)
    self.instructions = get_instructions(filename)
  end

  def get_instructions(filename)
    File.readlines(filename).map(&:strip).map do |line|
      ReactorInstruction.new(line)
    end
  end

  def total_on_cubes
    cube_list.keys.count
  end

  def next_step
    next_instruction = instructions.shift
    process_step(next_instruction) unless invalid_instruction?(next_instruction)
  end

  def all_steps
    while instructions.any?
      next_step
    end
  end

  def process_step(instr)
    puts "processing #{instr}"
    Point3D.get_range_of_points(x_range: instr.x, y_range: instr.y, z_range: instr.z).each do |point|
      set_point(point: point, state: instr.state)
    end
  end

  def set_point(point:, state:)
    if state == "on"
      cube_list[point] = true
    else
      cube_list.delete(point)
    end
  end

  def invalid_instruction?(instruction)
    outside_range(instruction.x) ||
      outside_range(instruction.y) ||
      outside_range(instruction.z)
  end

  def outside_range(range)
    range.minmax.first < -50 || range.minmax.last > 50
  end
end
