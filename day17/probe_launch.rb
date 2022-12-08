class ProbeLaunch
  attr_accessor :x_range, :y_range
  def initialize(x:, y:)
    self.x_range = x
    self.y_range = y
  end

  def list_of_hits
    possible_trajectories.select { |trajectory| hits_target?(trajectory) }
  end

  def possible_trajectories
    possible_x_values.map do |x|
      possible_y_values.map do |y|
        [x, y]
      end
    end.flatten(1)
  end

  def hits_target?(trajectory)
    possible_points(trajectory).any?{ |point| inside_range(point) }
  end

  def possible_points(trajectory)
    x_speed = trajectory.first
    y_speed = trajectory.last
    points = [[x_speed, y_speed]]
    until overshot?(points.last)
      x_speed = adjusted_x_speed(x_speed)
      y_speed = adjusted_y_speed(y_speed)
      points.push([points.last.first + x_speed, points.last.last + y_speed])
    end
    points
  end

  def overshot?(point)
    point.first > x_range.max || point.last < lowest_y_point
  end

  def adjusted_x_speed(speed)
    speed > 0 ? speed - 1 : 0
  end

  def adjusted_y_speed(speed)
    speed - 1
  end

  def inside_range(point)
    x_range.cover?(point[0]) && y_range.cover?(point[1])
  end

  def possible_x_values
    (min_x_speed..max_x_speed)
  end

  def possible_y_values
    (min_y_speed..max_y_speed)
  end

  def min_x_speed
    (Integer.sqrt(x_range.min * 2 - 0.25) - 0.5).ceil
  end

  def max_x_speed
    x_range.max
  end

  def min_y_speed
    lowest_y_point
  end

  def max_y_speed
    (lowest_y_point * -1) - 1
  end

  def max_y_height
    max_y_speed * (max_y_speed + 1) / 2
  end

  def lowest_y_point
    y_range.min
  end
end
