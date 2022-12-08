require_relative '../syntax'

RSpec.describe Syntax do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "gets the correct score for the file" do
      expect(subject.total_score).to eq(26397)
    end

    it "gets the correct autocomplete score for the file" do
      expect(subject.autocomp_score).to eq(288957)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "gets the correct score for the file" do
      expect(subject.total_score).to eq(387363)
    end

    it "gets the correct autocomplete score for the file" do
      expect(subject.autocomp_score).to eq(288957)
    end
  end
end
