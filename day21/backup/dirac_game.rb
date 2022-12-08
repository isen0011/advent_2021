require_relative "player"
require_relative "deterministic_die"

class DiracGame
  attr_accessor :players, :die
  def initialize(filename)
    self.players = load_players_from_file(filename)
    self.die = DeterministicDie.new
  end

  def load_players_from_file(filename)
    File.readlines(filename).map { |line| parse_player_line(line) }
  end

  def parse_player_line(line)
    Player.new(line.split(":").last.strip.to_i)
  end

  def play_game
    loop do
      players.each do |player|
        player.move(die.roll(3))
        break if player.won?
      end
      break if winner
    end
  end

  def winner
    players.find { |player| player.won? }
  end

  def loser
    players.find { |player| !player.won? }
  end

  def score_times_rolls
    play_game
    puts "score :#{loser.score}, #{die.rolls}"
    loser.score * die.rolls
  end
end
