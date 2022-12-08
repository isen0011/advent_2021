class Point
  attr_accessor :x, :y
  def initialize(x:, y:)
    self.x = x
    self.y = y
  end

  def square
    [ Point.new(x: x - 1, y: y - 1),
      Point.new(x: x,     y: y - 1),
      Point.new(x: x + 1, y: y - 1),
      Point.new(x: x - 1, y: y),
      Point.new(x: x,     y: y),
      Point.new(x: x + 1, y: y),
      Point.new(x: x - 1, y: y + 1),
      Point.new(x: x,     y: y + 1),
      Point.new(x: x + 1, y: y + 1)]
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
