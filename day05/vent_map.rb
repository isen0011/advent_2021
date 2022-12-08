class VentMap
  attr_accessor :vents

  def initialize(filename)
    self.vents = Hash.new(0)
    plot_vents_from_file(filename)
  end

  def plot_vents_from_file(filename)
    File.readlines(filename).map(&:strip).each do |line|
      (first_point, _unused, second_point) = line.split
      (start_point, end_point) = [Point.from_string(first_point), Point.from_string(second_point)].sort
        list_of_points = start_point.line_to(end_point)
        # puts "got line of points: #{list_of_points.join("-")}"
        list_of_points.each do |point|
          # puts "adding point #{point} with hash #{point.hash} to the map.  Old value: #{vents[point]}"
          vents[point] = vents[point] + 1
          # puts "   new value: #{vents[point]}"
        end
        # puts "after line: vents contains #{vents.keys.join("-")}"
        # puts "values: #{vents.values.join(".")}"
    end
  end

  def to_s
    (0..max_y).map do |y|
      (0..max_x).map do |x|
        vents[Point.new(x, y)] == 0 ? "." : vents[Point.new(x, y)]
      end.join
    end.join("\n")
  end

  def max_x
    # puts "called max x: #{vents.keys.join("-")}"
    vents.keys.map { |point| point.x }.max
  end

  def max_y
    vents.keys.map { |point| point.y }.max
  end

  def overlap_count
    vents.values.count{ |value| value > 1 }
  end

  class Point
    attr_accessor :x, :y

    def initialize(x, y)
      self.x = x
      self.y = y
    end

    def <=>(other)
      if x == other.x
        y <=> other.y
      else
        x <=> other.x
      end
    end

    def straight_to?(other)
      x == other.x || y == other.y
    end

    def eql?(other)
      x == other.x && y == other.y
    end

    def self.from_string(string)
      (x, y) = string.split(",").map(&:to_i)
      Point.new(x, y)
    end

    def line_to(point)
      if x < point.x && y == point.y
        [self, Point.new(x + 1, y).line_to(point)].flatten(999)
      elsif y < point.y && x == point.x
        [self, Point.new(x, y + 1).line_to(point)].flatten(999)
      elsif x < point.x && y > point.y
        [self, Point.new(x + 1, y - 1).line_to(point)].flatten(999)
      elsif x < point.x && y < point.y
        [self, Point.new(x + 1, y + 1).line_to(point)].flatten(999)
      else
        [self]
      end
    end

    def to_s
      "Point #{x}, #{y}"
    end

    def hash
      x.hash + y.hash
    end
  end
end
