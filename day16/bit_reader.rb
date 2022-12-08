class BitReader
  def get_multi_group_int
    bits_read = []
    continuing = read
    loop do
      bits_read.push(*read_bits(4))
      break if continuing == 0
      continuing = read
    end
    bits_read.map(&:to_s).join.to_i(2)
  end

  def get_int(count)
    bits = read_bits(count)
    bits.join.to_i(2)
  end

  def empty?
    data_stream.empty?
  end
end

class BitDataReader < BitReader
  attr_accessor :data_stream
  def initialize(data)
    self.data_stream = data.clone
  end

  def read_bits(count)
    data_stream.shift(count)
  end

  def read
    data_stream.shift
  end
end

class BitFileReader < BitReader
  attr_accessor :data_stream, :bit_stream
  def initialize(filename)
    self.data_stream = read_stream_from_file(filename)
    load_next_char
  end

  def read_stream_from_file(filename)
    File.readlines(filename).first.strip.chars
  end

  def read_bits(count)
    bits = []
    count.times do
      bits.push(read)
    end
    bits
  end

  def read
    if bit_stream.empty?
      load_next_char
    end
    bit_stream.shift
  end

  def load_next_char
    return [] if data_stream.empty?
    self.bit_stream = data_stream.shift.to_i(16).to_s(2).rjust(4, '0').chars.map(&:to_i)
  end
end
