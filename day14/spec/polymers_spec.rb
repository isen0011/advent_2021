require_relative '../polymers'

RSpec.describe Polymer do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

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
