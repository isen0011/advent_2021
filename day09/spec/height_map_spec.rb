require_relative '../height_map'

RSpec.describe HeightMap do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "gets the right low points" do
      expect(subject.low_points).to contain_exactly([0,1], [0,9], [2,2], [4,6])
    end

    it "gets the right sum of low points" do
      expect(subject.sum_of_low_risks).to eq(15)
    end

    it "finds all four basins" do
      expect(subject.basins.count).to eq(4)
    end

    it "gets the sizes for the basins" do
      expect(subject.basins.map(&:count)).to contain_exactly(3, 9, 9, 14)
    end

    it "gets the multiplied size of the three largest basins" do
      expect(subject.large_basin_sizes).to eq(1134)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "gets the right sum of low points" do
      expect(subject.sum_of_low_risks).to eq(591)
    end

    it "gets the multiplied size of the three largest basins" do
      expect(subject.large_basin_sizes).to eq(1134)
    end
  end
end
