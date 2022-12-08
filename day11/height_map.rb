class HeightMap
  attr_accessor :map, :basins
  def initialize(filename)
    self.map = load_values_from_file(filename)
    self.basins = low_points.map { |point| [point] }
    fill_basins
  end

  def fill_basins
    (1..8).each do |test_height|
      map.select {|_, point_height| point_height == test_height}.keys.each do |(row, col)|

        next if basins.any? { |basin| basin.include?([row, col])}
        adjacent_points = adjacent_points(row, col)
        found_basin = basins.find do |basin|
          (basin & adjacent_points).length != 0
        end
        found_basin.push([row, col])
      end
    end
  end

  def large_basin_sizes
    basins.map(&:size).max(3).reduce(1, :*)
  end

  def load_values_from_file(filename)
    new_map = Hash.new
    File.readlines(filename).map(&:strip).each_with_index do |line, row|
      line.chars.each_with_index do |height, col|
        new_map[[ row.to_i,col.to_i ]] = height.to_i
      end
    end
    new_map
  end

  def to_s
    "map:\n#{map.to_a.map { |(row,col), height| "[#{row},#{col}] = #{height}"}.join("\n") }"
  end

  def sum_of_low_risks
    map.fetch_values(*low_points).sum { |height| height + 1 }
  end

  def low_points
    @low_point ||= find_low_points
  end

  def find_low_points
    map.select{ |(row,col), height| all_adjacent_points_higher?(row, col, height) }.keys
  end

  def adjacent_points(row, col)
    [[row -1, col],[row + 1, col], [row, col-1], [row, col+1]]
  end

  def all_adjacent_points_higher?(row, col, height)
    checked_points = adjacent_points(row, col)
    checked_points.all? {|point| map.fetch(point,9) > height }
  end
end
