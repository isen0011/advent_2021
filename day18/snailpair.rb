require 'json'
require 'byebug'

class Snailpair
  class SnailpairParent
    def first_pair_with_regular_value_to_left
      SnailpairEmptyNumber.new
    end

    def depth
      -1
    end
  end

  class SnailpairEmptyNumber
    def right
      @right ||= SnailpairNumber.new(number: 0, position: "right")
    end

    def left
      @left ||= SnailpairNumber.new(number: 0, position: "left")
    end
  end

  class SnailpairNumber
    attr_accessor :position, :number
    def initialize(number:, position:)
      self.position = position
      self.number = number
    end

    def to_s
      number
    end

    def depth
      parent.depth + 1
    end

    def nested?
      false
    end

    def is_number?
      true
    end
  end

  def self.from_file(filename)
    base_pair = nil
    File.readlines(filename).map(&:strip).each do |line|
      base_pair = base_pair.nil? ? Snailpair.from_array(array: JSON.parse(line)) : base_pair.add(Snailpair.from_array(array: JSON.parse(line)))
    end
    base_pair
  end

  def self.from_array(array:, parent: SnailpairParent.new, position: "top")
    if array.is_a? Array
      created_pair = Snailpair.new(parent: parent, position: position)
      created_pair.left = Snailpair.from_array(array: array[0], parent: created_pair, position: "left")
      created_pair.right = Snailpair.from_array(array: array[1], parent: created_pair, position: "right")
      created_pair
    else
      SnailpairNumber.new(number: array, position: position)
    end
  end

  def self.get_number(data: , position:)
    SnailpairNumber.new(number: data.to_i, position: position)
  end

  attr_accessor :left, :right, :parent, :position

  def initialize(parent: SnailpairParent.new, position:)
    self.parent = parent
    self.position = position
  end

  def add(other_pair)
    new_pair = Snailpair.new(position: "top")
    new_pair.left = self
    self.position = "left"
    new_pair.right = other_pair
    other_pair.position = "right"
    self.parent = new_pair
    other_pair.parent = new_pair
    new_pair.reduce
  end

  def reduce
    while nested? || over_9?
      nested? ? leftmost_nested.explode : leftmost_over_9.split
    end
    self
  end

  def nested?
    deep? || left.nested? || right.nested?
  end

  def deep?
    depth > 3
  end

  def over_9?
    false
  end

  def leftmost_nested
    if deep?
      self
    else
      result = left.leftmost_nested
      result || right.leftmost_nested
    end
  end

  def rightmost_pair_with_number_on_right
    if right.is_number?
      self
    else
      right.rightmost_pair_with_number_on_right
    end
  end

  def leftmost_pair_with_number_on_left
    if left.is_number?
      self
    else
      left.leftmost_pair_with_number_on_left
    end
  end


  def explode

    byebug
    first_pair_with_regular_value_to_left.right.number += left.number
    first_pair_with_regular_value_to_right.left.number += right.number
    parents_pointer_to_me = 0
  end

  def first_pair_with_regular_value_to_left
    if position == "right"
      parent.left.rightmost_pair_with_number_on_right
    else
      parent.first_pair_with_regular_value_to_left
    end
  end

  def first_pair_with_regular_value_to_right
    if position == "left"
      parent.right.leftmost_pair_with_number_on_left
    else
      parent.first_pair_with_regular_value_to_right
    end
  end

  def depth
    parent.depth + 1
  end

  def to_s
    "[#{left.to_s},#{right.to_s}]"
  end

  def is_number?
    false
  end
end
