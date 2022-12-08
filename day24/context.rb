class Context
  attr_accessor :registers, :input
  def initialize(input)
    self.input = input.chars
    self.registers = Hash.new(0)
  end

  def w
    registers["w"]
  end

  def x
    registers["x"]
  end

  def y
    registers["y"]
  end

  def z
    registers["z"]
  end

  def w=(value)
    registers["w"] = value
  end

  def x=(value)
    registers["x"] = value
  end

  def y=(value)
    registers["y"] = value
  end

  def z=(value)
    registers["z"] = value
  end
end
