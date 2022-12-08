require_relative 'player'

class DiracGameKey
  attr_accessor :players, :turn
  def initialize(players:, turn:)
    self.players = players
    self.turn = turn
  end

  def deep_duplicate
    DiracGameKey.new(players: players.clone.map(&:clone), turn: turn)
  end

  def eql?(other)
    hash == other.hash
  end

  def hash
    to_s.hash
  end

  def to_s
    "DiracGame: p0 on #{players.first.space} w/ #{players.first.score} pts, p1 on #{players.last.space} w/ #{players.last.score} pts, next turn p#{turn}"
  end
end
