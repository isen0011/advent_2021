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


