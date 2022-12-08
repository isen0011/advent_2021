require_relative '../lanternfish'

RSpec.describe Lanternfish do
  context "with test data" do
    let(:subject) { Lanternfish.new("spec/fixtures/testdata.txt") }

    it "gets the right fish after 18 days" do
      expect(subject.advance_days(18)).to eq(26)
    end

    it "gets the right fish after 80 days" do
      expect(subject.advance_days(80)).to eq(5934)
    end
  end

  context "with test data" do
    let(:subject) { Lanternfish.new("input.txt") }

    it "gets the right fish after 80 days" do
      expect(subject.advance_days(256)).to eq(5934)
    end
  end
end
