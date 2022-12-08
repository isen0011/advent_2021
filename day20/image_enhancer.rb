require_relative "point"

class ImageEnhancer
  attr_accessor :image, :algorithm
  def initialize(filename)
    load_data_from_file(filename)
  end

  def enhance(count = 1)
    count.times do |t|
      new_image = Hash.new(zero_default)
      ((min_y - 1)..(max_y + 1)).each do |y|
        ((min_x - 1)..(max_x + 1)).each do |x|
          point = Point.new(x: x, y: y)
          new_image[point] = enhance_point(point)
        end
      end
      self.image = new_image
      puts "enhanced #{t} times, #{lit_pixels} pixels lit"
    end
  end

  def lit_pixels
    image.select { |_, v| v == "#" }.keys.count
  end

  def zero_default
    algorithm[enhancement_number(Point.new(x: 9_999_999, y: 9_999_999))]
  end

  def enhance_point(point)
    algorithm[enhancement_number(point)]
  end

  def enhancement_number(point)
    binary = point
      .square
      .map { |sq_point| image[sq_point] }
      .map { |val| val == "#" ? "1" : "0" }
      .join
    number = binary.to_i(2)
    number
  end

  def to_s
    (min_y..max_y).map do |y|
      (min_x..max_x).map do |x|
        image[Point.new(x: x, y: y)]
      end.join
    end.join("\n")
  end

  def min_y
    image.keys.map(&:y).min
  end

  def max_y
    image.keys.map(&:y).max
  end

  def min_x
    image.keys.map(&:x).min
  end

  def max_x
    image.keys.map(&:x).max
  end

  def points
    image.keys.map(&:to_s).join("-")
  end

  def load_data_from_file(filename)
    self.image = Hash.new(".")
    File.readlines(filename).map(&:strip).each_with_index do |line, y|
      if y == 0
        self.algorithm = line
      elsif y > 1
        line.chars.each_with_index do |char, x|
          image[Point.new(x: x, y: y - 2)] = char unless char == "."
        end
      end
    end
  end
end
