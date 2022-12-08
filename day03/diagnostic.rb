class Diagnostic
  def initialize(filename)
    self.filename = filename
  end

  def oxygen_generator
    current_list = binary_data.dup
    binary_length.times do |index|
      max_val = max_value_column(index, current_list)
      current_list.select!{ |data| data[index] == max_val }
    end
    current_list.first.to_i(2)
  end

  def co2_scrubber
    current_list = binary_data.dup
    binary_length.times do |index|
      min_val = min_value_column(index, current_list)
      current_list.select! { |data| data[index] == min_val }
    end
    current_list.first.to_i(2)
  end

  def life_support
    oxygen_generator * co2_scrubber
  end

  def gamma
    gamma_string = ""
    binary_length.times do |index|
      gamma_string << max_value_column(index)
    end
    gamma_string.to_i(2)
  end

  def epsilon
    epsilon_string = ""
    binary_length.times do |index|
      epsilon_string << min_value_column(index)
    end
    epsilon_string.to_i(2)
  end

  def power_consumption
    gamma * epsilon
  end

  def binary_length
    binary_data.first.length
  end

  private

  attr_accessor :filename

  def column_slice(data, column)
      data.map {|data| data[column] }
  end

  def max_value_column(index, source = binary_data)
    data_slice = column_slice(source, index)
    max_value(data_slice)
  end

  def min_value_column(index, source = binary_data)
    data_slice = column_slice(source, index)
    min_value(data_slice)
  end

  def max_value(slice)
    slice.sort.reverse.max_by {|value| slice.count(value) }
  end

  def min_value(slice)
    slice.sort.min_by {|value| slice.count(value) }
  end

  def binary_data
    @binary_data ||= read_binary_data_file.map(&:strip)
  end

  def read_binary_data_file
    File.readlines(filename)
  end
end
