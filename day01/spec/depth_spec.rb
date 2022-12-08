require_relative '../depth_counter'

RSpec.describe DepthCounter do
  let(:testdata) { "spec/fixtures/testdata.txt" }

  it "counts increases in depth" do
    subject = DepthCounter.new(testdata)
    expect(subject.depth_increases).to eq(7)
  end

  it "counts increases in depth with partial data" do
    subject = DepthCounter.new("spec/fixtures/partial.txt")
    expect(subject.depth_increases).to eq(5)
  end

  it "does the calculation" do
    subject = DepthCounter.new("input.txt")
    expect(subject.depth_increases).to eq(0)
  end

  it "gets the scaled depth" do
    subject = DepthCounter.new(testdata)
    expect(subject.scaled_depth_increases).to eq(5)
  end

  it "does the scaled calculation" do
    subject = DepthCounter.new("input.txt")
    expect(subject.scaled_depth_increases).to eq(0)
  end
end
