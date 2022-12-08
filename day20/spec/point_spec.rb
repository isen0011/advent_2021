require_relative "../point"

RSpec.describe Point do
  let(:subject) { described_class.new(x: 1, y: -3) }
  let(:group_of_nine) { [described_class.new(x: 0, y: -4),
                         described_class.new(x: 1, y: -4),
                         described_class.new(x: 2, y: -4),
                         described_class.new(x: 0, y: -3),
                         described_class.new(x: 1, y: -3),
                         described_class.new(x: 2, y: -3),
                         described_class.new(x: 0, y: -2),
                         described_class.new(x: 1, y: -2),
                         described_class.new(x: 2, y: -2)] }

  it "get the group of nine points" do
    expect(subject.square).to eq(group_of_nine)
  end
end
