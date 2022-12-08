require_relative '../dirac_universe'

RSpec.describe DiracUniverse do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "creates a single starting universe" do
      expect(subject.unfinished_universes.keys.count).to eq(1)
      expect(subject.unfinished_universes.values.first).to eq(1)
      initial_game = subject.unfinished_universes.keys.first
      expect(initial_game.players.first.space).to eq(4)
      expect(initial_game.players.last.space).to eq(8)
      expect(initial_game.players.first.score).to eq(0)
      expect(initial_game.players.last.score).to eq(0)
      expect(initial_game.turn).to eq(0)
    end

    it "creates 3 universes after a single turn" do
      subject.expand_universe
      expect(subject.unfinished_universes.keys.count).to eq(7)
    end

    it "finds all of the win states after expanding all universes" do
      subject.expand_all_universes
      expect(subject.player_1_wins).to eq(444356092776315)
      expect(subject.player_2_wins).to eq(341960390180808)
    end
  end
  context "with test data" do
    let(:subject) { described_class.new("input.txt") }

    it "finds all of the win states after expanding all universes" do
      subject.expand_all_universes
      expect(subject.player_1_wins).to eq(444356092776315)
      expect(subject.player_2_wins).to eq(341960390180808)
    end
  end
 end
