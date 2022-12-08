require_relative "../point_3d"

RSpec.describe Point3D do
  let(:first) { described_class.new(x: -9, y: 11, z: 0) }
  let(:second) { described_class.new(x: -10, y: 12, z: -1) }
  let(:outside) { described_class.new(x: 10, y: 12, z: -1) }

  let(:dup_first) {described_class.new(x: -9, y: 11, z: 0) }

  it "tests equality" do
    expect(first).to eq(dup_first)
  end

  it "evaluates the same in a hash" do
    h = Hash.new
    h[first] = "test"
    expect(h.has_key?(dup_first)).to be_truthy
  end

  it "stores different points as different keys in the hash" do
    h = Hash.new
    h[first] = "test"
    expect(h.has_key?(second)).to be_falsy
  end

  it "gets a range of points" do
    x_range = (-10..-8)
    y_range = (10..12)
    z_range = (-1..1)

    point_group = described_class.get_range_of_points(x_range: x_range, y_range: y_range, z_range: z_range)
    expect(point_group.count).to eq(27)
    expect(point_group).to include(first)
    expect(point_group).to include(second)
    expect(point_group).not_to include(outside)
  end
end
