require_relative 'bit_reader'

class Packet
  attr_accessor :version, :type_id, :reader
  def self.from_file(filename)
    bit_reader = BitFileReader.new(filename)
    self.from_stream(bit_reader)
  end

  def self.from_stream(bit_reader)
    version = bit_reader.get_int(3)
    type_id = bit_reader.get_int(3)
    if type_id == 4
      LiteralPacket.new(v: version, reader: bit_reader)
    else
      OperatorPacket.new(v: version, type: type_id, reader: bit_reader)
    end
  end
end

class OperatorPacket < Packet
  attr_accessor :subpackets, :reader
  def initialize(v:, type:, reader:)
    self.version = v
    self.type_id = type
    self.reader = reader
    length_type = reader.read
    if length_type == 0
      self.subpackets = load_packets_by_length
    else
      self.subpackets = load_packets_by_count
    end
  end

  def value
    case type_id
    when 0
      subpackets.map(&:value).sum
    when 1
      subpackets.map(&:value).inject(1) { |product, n| product * n }
    when 2
      subpackets.map(&:value).min
    when 3
      subpackets.map(&:value).max
    when 5
      subpackets[0].value > subpackets[1].value ? 1 : 0
    when 6
      subpackets[0].value < subpackets[1].value ? 1 : 0
    when 7
      subpackets[0].value == subpackets[1].value ? 1 : 0
    end
  end

  def versum
    subpackets.map(&:versum).sum + version
  end

  def load_packets_by_count
    subpackets = []
    packet_count = reader.get_int(11)
    packet_count.times do
      subpackets.push(Packet.from_stream(reader))
    end
    subpackets
  end

  def load_packets_by_length
    subpackets = []
    length = reader.get_int(15)
    packet_reader = BitDataReader.new(reader.read_bits(length))
    until packet_reader.empty?
      subpackets.push(Packet.from_stream(packet_reader))
    end
    subpackets
  end
end

class LiteralPacket < Packet
  attr_accessor :value
  def initialize(v: , reader:)
    self.version = v
    self.type_id = 4
    self.reader = reader
    self.value = reader.get_multi_group_int
  end

  def versum
    version
  end
end
