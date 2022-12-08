class Point
  @@max_x = 999
  @@max_y = 999
  def self.max_x=(value)
    @@max_x = value
  end

  def self.max_y=(value)
    @@max_y = value
  end

  def self.max_x
    @@max_x
  end

  def self.max_y
    @@max_y
  end

  attr_accessor :x, :y
  def initialize(x:, y:)
    self.x = x
    self.y = y
  end

  def adjacent
    [Point.new(x: x - 1, y: y),
     Point.new(x: x + 1, y: y),
     Point.new(x: x, y: y - 1),
     Point.new(x: x, y: y + 1)].reject(&:invalid?)
  end

  def invalid?
    x < 0 || y < 0 || x > Point.max_x || y > Point.max_y
  end

  def ==(other)
    x == other.x && y == other.y
  end

  alias eql? ==

  def hash
    x.hash ^ y.hash
  end

  def to_s
    "(#{x}, #{y})"
  end
end
