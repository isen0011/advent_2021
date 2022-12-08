require_relative '../polymers'

RSpec.describe Polymer do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "outputs the unchanged chain" do
      expect(subject.to_s).to eq("NNCB")
    end

    it "reads all of the insertion rules" do
      expect(subject.insertion_rules.keys.count).to eq(16)
    end

    it "correctly moves forward one step" do
      subject.step(1)
      expect(subject.to_s).to eq("NCNBCHB")
    end

    it "moves forward two steps" do
      subject.step(2)
      expect(subject.to_s).to eq("NBCCNBBBCBHCB")
    end

    it "moves forward three steps" do
      subject.step(3)
      expect(subject.to_s).to eq("NBBBCNCCNBBNBNBBCHBHHBCHB")
    end

    it "moves forward four steps" do
      subject.step(4)
      expect(subject.to_s).to eq("NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB")
    end

    it "gets the most common and least common elements" do
      subject.step(10)
      expect(subject.most_common_element).to eq(1749)
      expect(subject.least_common_element).to eq(161)
      expect(subject.most_common_element - subject.least_common_element).to eq(1588)
    end
  end

  context "with test data" do
    let(:subject) { described_class.new("input.txt") }

    it "gets the most common and least common elements" do
      subject.step(40)
      expect(subject.most_common_element - subject.least_common_element).to eq(1588)
    end
  end
end
