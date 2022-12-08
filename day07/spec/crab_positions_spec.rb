require_relative '../crab_positions'

RSpec.describe CrabPositions do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "finds the cheapest position" do
      expect(subject.best_position).to eq(5)
    end

    it "gets the needed fuel" do
      expect(subject.best_position_fuel).to eq(168)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "finds the cheapest position" do
      expect(subject.best_position).to eq(2)
    end

    it "gets the needed fuel" do
      expect(subject.best_position_fuel).to eq(37)
    end
  end
end
