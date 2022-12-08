class Polymer
  attr_accessor :polymer, :insertion_rules
  def initialize(filename)
    self.polymer = File.open(filename) {|f| f.readline }.strip
    self.insertion_rules = load_data_from_file(filename)
  end

  def step(steps)
    steps.times do |cycle|
      puts "starting cycle #{cycle} - #{polymer.length}"
      new_polymer = polymer[0]
      (1..(polymer.length - 1)).each do |i|
        el_one = polymer[i - 1]
        el_two = polymer[i]

        if insertion_rules.has_key?([el_one, el_two])
          new_polymer += insertion_rules[[el_one, el_two]]
        end
        new_polymer += el_two
      end
      self.polymer = new_polymer
    end
  end

  def most_common_element
    polymer.chars.count(polymer.chars.max_by { |i| polymer.chars.count(i) })
  end

  def least_common_element
    polymer.chars.count(polymer.chars.min_by { |i| polymer.chars.count(i) })
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
