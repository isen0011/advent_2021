require_relative '../energy_octo'

RSpec.describe EnergyOcto do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    it "finds the first simultaneous flash" do
      expect(subject.simultaneous_flash).to eq(195)
    end

    it "gets the right flash count after 100 steps" do
      subject.step(100)
      expect(subject.flash_count).to eq(1656)
    end

    it "generates the right output prior to the first step" do
      expect(subject.to_s).to eq("5483143223\n2745854711\n5264556173\n6141336146\n6357385478\n4167524645\n2176841721\n6882881134\n4846848554\n5283751526")
    end

    it "generates the right output after the first step" do
      subject.step(1)
      expect(subject.to_s).to eq("6594254334\n3856965822\n6375667284\n7252447257\n7468496589\n5278635756\n3287952832\n7993992245\n5957959665\n6394862637")
    end

    it "generates the right output after the second step" do
      subject.step(2)
      expect(subject.to_s).to eq("8807476555\n5089087054\n8597889608\n8485769600\n8700908800\n6600088989\n6800005943\n0000007456\n9000000876\n8700006848")
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "gets the right flash count after 100 steps" do
      subject.step(100)
      expect(subject.flash_count).to eq(1655)
    end

    it "finds the first simultaneous flash" do
      expect(subject.simultaneous_flash).to eq(195)
    end
  end
end
