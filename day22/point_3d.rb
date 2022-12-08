class Point3D
  def self.get_range_of_points(x_range:, y_range:, z_range:)
    x_range.map do |x|
      y_range.map do |y|
        z_range.map do |z|
          Point3D.new(x: x, y: y, z: z)
        end.flatten
      end.flatten
    end.flatten
  end

  attr_accessor :x, :y, :z

  def initialize(x:, y:, z:)
    self.x = x
    self.y = y
    self.z = z
  end

  def ==(other)
    x == other.x && y == other.y && z == other.z
  end

  alias eql? ==

  def hash
    x.hash ^ y.hash ^ z.hash
  end

  def to_s
    "(#{x}, #{y}, #{z})"
  end
end
