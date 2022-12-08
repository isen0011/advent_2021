require_relative '../dirac_game'

RSpec.describe DiracGame do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "has two players" do
      expect(subject.players.count).to eq(2)
    end

    it "finds the final score times rolls" do
      expect(subject.score_times_rolls).to eq(739785)
    end
  end
  context "with test data" do
    let(:subject) { described_class.new("input.txt") }

    it "finds the final score times rolls" do
      expect(subject.score_times_rolls).to eq(739785)
    end
  end

end
