class DepthCounter
  def initialize(filename)
    self.filename = filename
  end

  def depth_increases
    puts "#{depth_array
      .map
      .with_index {|depth, i| "#{depth} - #{depth > depth_array[i-1]}"}.join("\n")}"
    depth_array
      .map
      .with_index {|depth, i| depth > depth_array[i-1]}
      .count {|increases| increases }
  end

  def scaled_depth_increases
    puts "#{scaled_depth
      .map
      .with_index {|depth, i| "#{depth} - #{depth > scaled_depth[i-1]}"}
      .join("\n")}"
    scaled_depth
      .map
      .with_index {|depth, i| depth > scaled_depth[i-1]}
      .count {|increases| increases }
  end

  private

  def depth_array
    @depth_array ||= read_depth_array.map(&:strip).map(&:to_i)
  end

  def scaled_depth
    @scaled_depth ||= depth_array.map.with_index do |depth,i|
      i < depth_array.length - 2 ?  depth + depth_array[i+1] + depth_array[i+2] : 0
    end.reject {|depth| depth == 0 }
  end

  def read_depth_array
    File.readlines(filename)
  end

  attr_accessor :filename
end
