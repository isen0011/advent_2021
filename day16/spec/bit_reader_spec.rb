require_relative "../bit_reader"

RSpec.describe BitFileReader do
  context "with a file" do
    let(:subject) { described_class.new("spec/fixtures/literal_2021.txt") }

    it "reads converts hex to bits and reads as requested" do
      expect(subject.read_bits(3)).to eq([1, 1, 0])
      expect(subject.read).to eq(1)
      expect(subject.read).to eq(0)
      expect(subject.read).to eq(0)
    end

    it "reads numbers from bits" do
      expect(subject.get_int(3)).to eq(6)
      expect(subject.get_int(3)).to eq(4)
    end

    it "reads multi-group numbers" do
      subject.read_bits(6)
      expect(subject.get_multi_group_int).to eq(2021)
    end

    it "reports empty when done" do
      subject.read_bits(24)
      expect(subject.empty?).to be_truthy
      expect(subject.read).to be_nil
    end
  end
end

RSpec.describe BitDataReader do
  context "with a bit array" do
    let(:source_array) { "110100101111111000101000".chars.map { |c| c.to_i } }
    let(:subject) { described_class.new(source_array) }

    it "reads bits from the source array" do
      expect(subject.read_bits(3)).to eq([1, 1, 0])
      expect(subject.read).to eq(1)
      expect(subject.read).to eq(0)
      expect(subject.read).to eq(0)
    end

    it "reads numbers from bits" do
      expect(subject.get_int(3)).to eq(6)
      expect(subject.get_int(3)).to eq(4)
    end

    it "reads multi-group numbers" do
      subject.read_bits(6)
      expect(subject.get_multi_group_int).to eq(2021)
    end

    it "reports empty when done" do
      subject.read_bits(24)
      expect(subject.empty?).to be_truthy
      expect(subject.read).to be_nil
    end
  end
end
