class SegDisplay
  attr_accessor :lines

  def initialize(filename)
    self.lines = load_seg_data(filename)
  end

  def load_seg_data(filename)
    File.readlines(filename).map { |line| SegLine.new(line) }
  end

  def output_digits_count(list_of_digits)
    lines.sum { |line| line.digit_output.count {|digit| list_of_digits.include?(digit) } }
  end

  def output_digits_sum
    lines.sum { |line| line.translated_value }
  end

  class SegLine
    attr_accessor :raw_signal_patterns, :signal_patterns, :digit_output
    def initialize(line)
      self.raw_signal_patterns = load_signal_patterns(line.split("|")[0])
      self.signal_patterns = Hash.new
      translate_signal_patterns
      self.digit_output = load_digit_output(line.split("|")[1])
    end

    def translated_value
      digit_output.join.to_i
    end

    def load_signal_patterns(line_data)
      line_data.split.map { |data| data.chars.sort.join }
    end

    def load_digit_output(line_data)
      line_data.split.map { |seg| translate_segment_code_to_digit(seg) }
    end

    def translate_segment_code_to_digit(code)
      signal_patterns[code.chars.sort.join]
    end

    def translate_signal_patterns
      load_fixed_length_values
      load_sixth_length_values
      load_five_length_values
    end

    def load_fixed_length_values
      raw_signal_patterns.select {|sig| [2,3,4,7].include?(sig.length) }.each do |code|
        signal_patterns[code] = if code.length == 2
                                  1
                                elsif code.length == 3
                                  7
                                elsif code.length == 4
                                  4
                                elsif code.length == 7
                                  8
                                end
      end
    end

    def load_sixth_length_values
      one = signal_patterns.key(1).chars
      four = signal_patterns.key(4).chars
      raw_signal_patterns.select {|sig| sig.length == 6 }.each do |code|
        signal_patterns[code] = if one.intersection(code.chars).length == 1
                                  6
                                elsif four.intersection(code.chars).length == 4
                                  9
                                else
                                  0
                                end
      end
    end

    def load_five_length_values
      one = signal_patterns.key(1).chars
      nine = signal_patterns.key(9).chars
      raw_signal_patterns.select {|sig| sig.length == 5 }.each do |code|
        signal_patterns[code] = if one.intersection(code.chars).length == 2
                                  3
                                elsif nine.intersection(code.chars).length == 5
                                  5
                                else
                                  2
                                end
      end
    end
  end
end
