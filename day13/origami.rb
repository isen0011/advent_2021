class Origami
  attr_accessor :dots, :folds

  def initialize(filename)
    self.dots = []
    self.folds = []
    load_data_from_file(filename)
    puts folds.map{ |fold| "fold on #{fold.first} at line #{fold.last}"}.join("\n")
  end

  def fold(n = folds.length)
    n.times do
      fold_paper(folds.shift)
    end
  end

  def fold_paper(fold)
    axis = fold.first
    line = fold.last.to_i

    if axis == "x"
      dots.map! { |point| [folded_value(point.first,line),point.last] }
    else
      dots.map! { |point| [point.first, folded_value(point.last,line)] }
    end
    dots.uniq!
  end

  def folded_value(start_coordinate, fold_line)
    start_coordinate < fold_line ? start_coordinate : fold_line * 2 - start_coordinate
  end

  def dot_count
    dots.count
  end

  def load_data_from_file(filename)
    File.readlines(filename).each do |line|
      if line.start_with?("fold")
        folds.push(read_fold(line))
      elsif !line.empty?
        (x,y) = line.strip.split(",").map(&:to_i)
        dots.push([x,y]) unless x.nil? || y.nil?
      end
    end
  end

  def read_fold(line)
    line.split.last.split("=")
  end

  def to_s
    (0..max_y).map do |y|
      (0..max_x).map do |x|
        dots.include?([x, y]) ? "#" : "."
      end.join
    end.join("\n")
  end

  def max_x
    dots.map { |point| point.first }.max
  end

  def max_y
    dots.map { |point| point.last }.max
  end
end
