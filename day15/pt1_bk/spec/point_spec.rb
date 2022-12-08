require_relative "../point"

RSpec.describe Point do
  let(:first) { described_class.new(x: 0, y: 2) }
  let(:up_one) { described_class.new(x: 0, y: 3) }
  let(:right_one) { described_class.new(x: 1, y: 2) }
  let(:left_one) { described_class.new(x: 0, y: 1) }
  let(:diagonal) { described_class.new(x: 1, y: 3) }
  let(:high_x)   { described_class.new(x: 9, y: 3) }
  let(:high_y)   { described_class.new(x: 3, y: 9) }

  let(:dup_first) {described_class.new(x: 0, y: 2) }

  it "tests equality" do
    expect(first).to eq(dup_first)
  end

  it "evaluates the same in a hash" do
    h = Hash.new
    h[first] = "test"
    expect(h.has_key?(dup_first)).to be_truthy
  end

  it "gets the adjacent points" do
    expect(first.adjacent).to contain_exactly(up_one, right_one, left_one)
  end

  it "stores the max allowed X and Y" do
    expect(high_x.invalid?).to be_falsy
    expect(high_y.invalid?).to be_falsy
    Point.max_x = 4
    Point.max_y = 3
    expect(high_x.invalid?).to be_truthy
    expect(high_y.invalid?).to be_truthy
    Point.max_x = 999
    Point.max_y = 999
  end
end
