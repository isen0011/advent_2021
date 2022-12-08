class CrabPositions
  attr_accessor :crabs

  def initialize(filename)
    self.crabs = get_crabs_from_file(filename)
  end

  def get_crabs_from_file(filename)
    File.readlines(filename).first.split(",").map(&:to_i).sort
  end

  def best_position
    start_point = mean(crabs)
    base_fuel = fuel_for_position(start_point)
    upper = fuel_for_position(start_point + 1)
    lower = fuel_for_position(start_point - 1)
    if base_fuel > upper
      direction = 1
      next_fuel = upper
    else
      direction = -1
      next_fuel = lower
    end
    while base_fuel > next_fuel do
      puts "at point #{start_point}, direction #{direction}, with basef: #{base_fuel}, and nextf: #{next_fuel}"
      base_fuel = next_fuel
      start_point += direction
      next_fuel = fuel_for_position(start_point + direction)
    end
    start_point
  end

  def fuel_for_position(x)
    crabs.sum do |crab|
      distance = (crab - x).abs
      (distance * (distance + 1)) / 2
    end
  end

  def best_position_fuel
    crabs.sum do |crab|
      distance = (crab - best_position).abs
      (distance * (distance + 1)) / 2
    end
  end

  def mean(array)
    (array.sum.to_f / array.length).round
  end
end
