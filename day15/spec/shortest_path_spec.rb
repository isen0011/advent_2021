require_relative '../shortest_path'

RSpec.describe ShortestPath do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "gets the lowest total risk to the bottom right" do
      expect(subject.lowest_risk).to eq(315)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "gets the lowest total risk to the bottom right" do
      expect(subject.lowest_risk).to eq(40)
    end
  end
end
