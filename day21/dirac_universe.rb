require_relative 'dirac_game_key'

class DiracUniverse
  attr_accessor :unfinished_universes, :finished_universes
  def initialize(filename)
    self.unfinished_universes = Hash.new(0)
    self.finished_universes = Hash.new(0)
    unfinished_universes[load_initial_game(filename)] = 1
  end

  def expand_all_universes
    while unfinished_universes.any?
      puts "#{finished_universes.count} finished, #{unfinished_universes.count} unfinished"
      expand_universe
    end
    puts "Stopping with #{unfinished_universes.count} unfinished, #{finished_universes.count} finished"
    puts "player 1 won in #{player_1_wins}"
    puts "player 2 won in #{player_2_wins}"
  end

  def player_1_wins
    finished_universes.select {|game, _| game.players.first.won? }.values.sum
  end

  def player_2_wins
    finished_universes.select {|game, _| game.players.last.won? }.values.sum
  end

  def expand_universe
    expand_game(unfinished_game)
  end

  def expand_game(game)
    game_count = unfinished_universes.delete(game)
#    puts "removed game #{game} w count #{game_count}"
    (1..3).each do |roll1|
      (1..3).each do |roll2|
        (1..3).each do |roll3|
          final_roll = roll1 + roll2 + roll3
          new_game = game.deep_duplicate
          take_turn(game: new_game, roll: final_roll, count: game_count)
        end
      end
    end
  end

  def take_turn(game:, roll:, count:)
    #puts "taking turn for #{game} with roll #{roll}"
    player = game.players[game.turn]
    player.move(roll)
    game.turn = (game.turn + 1) % 2
    if game_won?(game)
      finished_universes[game] += count
    else
      unfinished_universes[game] += count
    end
    #puts "post turn state of game: #{game}"
  end

  def game_won?(game)
    game.players.any? { |player| player.won? }
  end

  def unfinished_game
    unfinished_universes.keys.first
  end

  def load_initial_game(filename)
    DiracGameKey.new(players: load_players_from_file(filename), turn: 0)
  end

  def load_players_from_file(filename)
    File.readlines(filename).map { |line| parse_player_line(line) }
  end

  def parse_player_line(line)
    Player.new(spot: line.split(":").last.strip.to_i)
  end
end
