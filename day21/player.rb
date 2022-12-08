class Player
  attr_accessor :space, :score
  def initialize(spot: , score: 0)
    self.space = spot
    self.score = score
  end

  def move(distance)
    self.space = (space + distance) % 10
    self.space = 10 if self.space == 0
    self.score += space
  end

  def won?
    score > 20
  end
end
