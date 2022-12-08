require_relative '../seg_display'

RSpec.describe SegDisplay do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "gets the right number of unique segment digits" do
      expect(subject.output_digits_count([1, 4, 7, 8])).to eq(26)
    end

    it "gets the right sum of numbers" do
      expect(subject.output_digits_sum).to eq(61229)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "gets the right number of unique segment digits" do
      expect(subject.output_digits_count([1, 4, 7, 8])).to eq(284)
    end

    it "gets the right sum of numbers" do
      expect(subject.output_digits_sum).to eq(61229)
    end
  end
end
