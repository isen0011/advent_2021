require_relative "../alu"

RSpec.describe ALU do
  context "clearing the context" do
    let(:subject) { described_class.new("spec/fixtures/clear_context.txt") }

    it "clears the context after each run" do
      subject.run("5")
      expect(subject.context.z).to eq(1)
      subject.run("3")
      expect(subject.context.z).to eq(1)
    end
  end

  context "simple negation" do
    let(:subject) { described_class.new("spec/fixtures/simple_negation.txt") }

    it "negates a number and stores it in x" do
      subject.run("5")
      expect(subject.context.x).to eq(-5)
    end
  end

  context "three times larger" do
    let(:subject) { described_class.new("spec/fixtures/three_times_larger.txt") }

    it "stores 1 if the number is three times larger" do
      subject.run("26")
      expect(subject.context.z).to eq(1)
    end

    it "stores 0 if the number is not three times larger" do
      subject.run("46")
      expect(subject.context.z).to eq(0)
    end
  end

  context "split into binary" do
    let(:subject) { described_class.new("spec/fixtures/split_into_binary.txt") }

    it "splits a number into binary" do
      subject.run("9")
      expect(subject.context.z).to eq(1)
      expect(subject.context.y).to eq(0)
      expect(subject.context.x).to eq(0)
      expect(subject.context.w).to eq(1)
    end
    it "splits a number into binary" do
      subject.run("1")
      expect(subject.context.z).to eq(1)
      expect(subject.context.y).to eq(0)
      expect(subject.context.x).to eq(0)
      expect(subject.context.w).to eq(0)
    end
  end
end
