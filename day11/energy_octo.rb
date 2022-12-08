class EnergyOcto
  attr_accessor :octo_map, :flash_count, :flash_list, :generation

  def initialize(filename)
    self.octo_map = load_values_from_file(filename)
    self.flash_count = 0
    self.generation = 0
    self.flash_list = []
  end

  def simultaneous_flash
    while !all_flashed do
      increase_all_energy
      handle_flashes
      reset_flashed
      self.generation += 1
    end
    generation
  end

  def all_flashed
    octo_map.values.all? { |value| value == 0 }
  end

  def step(count)
    count.times do
      increase_all_energy
      handle_flashes
      reset_flashed
      self.generation += 1
      # puts "After step #{generation}:\n#{self}"
    end
  end

  def increase_all_energy
    octo_map.each_key do |point|
      increase_brightness(point)
    end
  end

  def handle_flashes
    while (flashing = flash_list.shift) do
      adjacent_points(flashing).each do |point|
        increase_brightness(point)
      end
    end
  end

  def adjacent_points(point)
    (row, col) = point
    [[row + 1, col - 1],
     [row + 1, col + 1],
     [row + 1, col],
     [row, col - 1],
     [row, col + 1],
     [row - 1, col - 1],
     [row - 1, col + 1],
     [row - 1, col]].select {|point| inside_of_range?(point) }
  end

  def inside_of_range?(point)
    (row, col) = point
    row > -1 && col > -1 && row < 10 && col < 10
  end

  def reset_flashed
    octo_map.each_pair do |point, brightness|
      if brightness > 9
        octo_map[point] = 0
        up_flash_count
      end
    end
  end

  def up_flash_count
    self.flash_count += 1
  end

  def increase_brightness(point)
    octo_map[point] = octo_map[point] + 1
    flash_list.push(point) if octo_map[point] == 10
  end

  def load_values_from_file(filename)
    new_map = Hash.new
    File.readlines(filename).map(&:strip).each_with_index do |line, row|
      line.chars.each_with_index do |brightness, col|
        new_map[[ row.to_i,col.to_i ]] = brightness.to_i
      end
    end
    new_map
  end

  def to_s
    (0..9).map do |row|
      (0..9).map do |col|
        octo_map[[row, col]]
      end.join
    end.join("\n")
  end
end
