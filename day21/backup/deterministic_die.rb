class DeterministicDie
  attr_accessor :next_roll, :rolls

  def initialize
    self.next_roll = 0
    self.rolls = 0
  end

  def roll(count = 1)
    (1..count).inject(0) { |sum, _| sum + roll_once }
  end

  def roll_once
    self.rolls += 1
    next_roll == 100 ? self.next_roll = 1 : self.next_roll += 1
  end
end
