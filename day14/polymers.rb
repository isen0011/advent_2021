class Polymer
  attr_accessor :polymer, :insertion_rules, :element_counts
  def initialize(filename)
    initial_poly = File.open(filename) { |f| f.readline }.strip
    self.polymer = load_polymer(initial_poly)
    self.insertion_rules = load_data_from_file(filename)
    self.element_counts = count_chars(initial_poly)
  end

  def load_polymer(line)
    poly = Hash.new(0)
    (1..(line.length - 1)).each do |i|
      poly[[line[i - 1], line[i]]] += 1
    end
    puts "loaded polymer: #{poly}"
    poly
  end

  def count_chars(initial_poly)
    chars = Hash.new(0)
    initial_poly.chars.each do |ch|
      chars[ch] += 1
    end
    chars
  end

  def step(steps)
    steps.times do |cycle|
      puts "starting cycle #{cycle}"
      puts "-- poly: #{polymer}"
      puts "-- elecnt: #{element_counts}"
      new_polymer = Hash.new(0)
      polymer.each do |pair, count|
        if insertion_rules.has_key?(pair)
          new_polymer[[pair.first, insertion_rules[pair]]] += count
          new_polymer[[insertion_rules[pair], pair.last]] += count
          self.element_counts[insertion_rules[pair]] += count
          # puts "------ pair #{pair} found: #{insertion_rules[pair]}"
        else
          new_polymer[pair] += 1
        end
      end
      self.polymer = new_polymer
    end
  end

  def most_common_element
    element_counts.values.max
  end

  def least_common_element
    element_counts.values.min
  end

  def to_s
    polymer
  end

  def load_data_from_file(filename)
    File.readlines(filename)[2..-1].map do |line|
      get_rule_key_value_pair(line)
    end.to_h
  end

  def get_rule_key_value_pair(line)
    (elements, added) = line.strip.split(" -> ")
    (one, two) = elements.chars
    [[one, two], added]
  end
end
