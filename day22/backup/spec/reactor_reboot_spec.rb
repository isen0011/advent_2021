require_relative "../reactor_reboot"

RSpec.describe ReactorReboot do
  context "with simple test data" do
    let(:subject) { described_class.new("spec/fixtures/simple_test.txt") }

    it "processes the first step correctly" do
      subject.next_step
      expect(subject.total_on_cubes).to eq(27)
    end

    it "has the right number on cubes turned on" do
      subject.all_steps
      expect(subject.total_on_cubes).to eq(39)
    end
  end

  context "with larger test data" do
    let(:subject) { described_class.new("spec/fixtures/large_example.txt") }

    it "has the right number on cubes turned on" do
      subject.all_steps
      expect(subject.total_on_cubes).to eq(590784)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "has the right number on cubes turned on" do
      pending
      subject.all_steps
      expect(subject.total_on_cubes).to eq(590784)
    end
  end
end

