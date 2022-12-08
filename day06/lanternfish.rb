class Lanternfish
  attr_accessor :fishes

  def initialize(filename)
    self.fishes = Array.new(9,0)
    load_hash_from_file(filename)
  end

  def load_hash_from_file(filename)
    File.readlines(filename).first.split(",").map(&:to_i).each do |fish_age|
      fishes[fish_age] = fishes[fish_age] + 1
    end
  end

  def advance_days(days)
    puts "Initial state: #{fishes}"
    days.times do |day|
      advance_day
      puts "After #{day} days: #{fishes}"
    end
    fishes.sum
  end

  def advance_day
    fishes[9] = fishes[0]
    fishes[7] = fishes[7] + fishes[0]
    (0..8).each do |day|
      fishes[day] = fishes[day + 1]
    end
    fishes[9] = 0
  end
end
