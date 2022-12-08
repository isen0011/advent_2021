require_relative 'point'
require 'Heap'

class ShortestPath
  class TotalRiskHeapItem
    include Comparable
    attr_accessor :point, :value
    def initialize(point, value)
      self.point = point
      self.value = value
    end

    def <=>(other)
      value <=> other.value
    end

    def to_s
      "#{point}:#{value}"
    end
  end

  attr_accessor :total_risk, :visited, :destination_point, :origin, :destination_value, :base_risk_orig

  def initialize(filename)
    self.base_risk_orig = load_risks_from_file(filename)
    self.visited = Hash.new(false)
    self.origin = Point.new(x: 0, y: 0)
    self.total_risk = Heap::BinaryHeap::MinHeap.new(create_starting_heap)
    Point.max_x = (max_x + 1) * 5 - 1
    Point.max_y = (max_y + 1) * 5 - 1
    self.destination_point = Point.new(x: Point.max_x, y: Point.max_y)
  end

  def lowest_risk
    find_shortest_path
    destination_value
  end

  def create_starting_heap
    [TotalRiskHeapItem.new(origin, 0)]
  end

  def base_risk(point)
#    if wrap_modifier(point) > 0
#      puts "wrapping point #{point} from #{wrap_point(point)}-#{base_risk_orig[wrap_point(point)]} mod by #{wrap_modifier(point)} to #{get_base_risk(point)}"
#    end
    get_base_risk(point)
  end

  def get_base_risk(point)
    unmodded_risk = (base_risk_orig[wrap_point(point)] + wrap_modifier(point))
    unmodded_risk > 9 ? unmodded_risk - 9 : unmodded_risk
  end

  def wrap_modifier(point)
    point.x / (max_x + 1) + point.y / (max_y + 1)
  end

  def wrap_point(point)
    Point.new(x: point.x % (max_x + 1), y: point.y % (max_y + 1))
  end


  def find_shortest_path
    until visited[destination_point]
      current_heap = get_lowest_risk_unvisited_point
      current_point = current_heap.point
      current_value = current_heap.value
      # puts "visiting #{current_point}, risk of #{current_value}"

      visited[current_point] = true
      if current_point == destination_point
        self.destination_value = current_value
      end
      current_point.adjacent.reject { |point| visited[point] }.each do |point|
        updated_risk = current_value + base_risk(point)
        total_risk.add(TotalRiskHeapItem.new(point, updated_risk))
        # puts "looked at #{point}, set risk to #{updated_risk}"
      end
      puts "count of total heap: #{total_risk.count}"
      puts "next element: #{total_risk.extract_min}"
    end
  end

  def get_lowest_risk_unvisited_point
    new_min = total_risk.extract_min!
    while visited[new_min.point]
      new_min = total_risk.extract_min!
    end
    new_min
  end

  def load_risks_from_file(filename)
    new_map = Hash.new
    File.readlines(filename).map(&:strip).each_with_index do |line, row|
      line.chars.each_with_index do |risk, col|
        new_map[Point.new(x: col.to_i, y: row.to_i)] = risk.to_i
      end
    end
    new_map
  end

  def max_x
    base_risk_orig.keys.map { |point| point.x }.max
  end

  def max_y
    base_risk_orig.keys.map { |point| point.y }.max
  end
end
