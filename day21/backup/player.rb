class Player
  attr_accessor :space, :score
  def initialize(starting_spot)
    self.space = starting_spot
    self.score = 0
  end

  def move(distance)
    self.space = (space + distance) % 10
    self.space = 10 if self.space == 0
    self.score += space
  end

  def won?
    score > 999
  end
end
