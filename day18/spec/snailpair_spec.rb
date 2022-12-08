require_relative '../snailpair'

RSpec.describe Snailpair do
  context "with a simple short pair" do
    let(:subject) { described_class.from_file("spec/fixtures/single_short.txt") }

    it "produces the right to_s output when simple" do
      expect(subject.to_s).to eq("[1,2]")
    end
    it "has the right depth" do
      expect(subject.depth).to eq(0)
    end
  end

  it "produces the right to_s output when hard" do
    subject = described_class.from_file("spec/fixtures/single_long.txt")
    expect(subject.to_s).to eq("[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]")
  end

  it "knows it's depth" do
    subject = described_class.from_file("spec/fixtures/single_long.txt")
    expect(subject.left.left.left.depth).to eq(3)
  end

  it "works for a simple sum" do
    subject = described_class.from_file("spec/fixtures/simple_sum.txt")
    expect(subject.to_s).to eq("[[[[1,1],[2,2]],[3,3]],[4,4]]")
  end

  it "works for an exploding sum" do
    subject = described_class.from_file("spec/fixtures/exploding_sum.txt")
    expect(subject.to_s).to eq("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
  end

  it "works with the large addition test" do
    subject = described_class.from_file("spec/fixtures/large_addition_test.txt")
    expect(subject.to_s).to eq("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]")
  end

end
