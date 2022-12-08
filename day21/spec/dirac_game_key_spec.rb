require_relative '../dirac_game_key'

RSpec.describe DiracGameKey do
  let(:player1) { Player.new(spot: 6, score: 4) }
  let(:player2) { Player.new(spot: 9, score: 7) }
  let(:players) { [ player1, player2 ] }

  it "two different game keys have a different hash" do
    first = described_class.new(players: players, turn: 0)
    second = described_class.new(players: players, turn: 1)
    hash = {}
    hash[first] = "test"
    expect(hash[second]).not_to eq("test")
  end

  it "two identical game keys have the same hash" do
    first = described_class.new(players: players, turn: 0)
    second = described_class.new(players: players, turn: 0)
    hash = {}
    hash[first] = "test"
    expect(hash[second]).to eq("test")
  end

  it "can get the game hash from a key" do
    alt_player2 = Player.new(spot: 9, score: 22)
    alt_players = [player1, alt_player2]
    first = described_class.new(players: alt_players, turn: 1)
    hash = {}
    hash[first] = "test"
    key = hash.keys.first
    expect(key.players.count).to eq(2)
    expect(key.players.first.score).to eq(4)
    expect(key.players.last.score).to eq(22)
    expect(key.players.first.space).to eq(6)
    expect(key.players.last.space).to eq(9)
    puts "key: #{key}, turn: #{key.turn}"
    expect(key.turn).to eq(1)
    expect(key.players.first.won?).to be_falsy
    expect(key.players.last.won?).to be_truthy
  end
end
