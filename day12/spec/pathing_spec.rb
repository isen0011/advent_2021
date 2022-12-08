require_relative '../cave_pathing'

RSpec.describe CavePathing do
  context "with small cave system" do
    let(:subject) { described_class.new("spec/fixtures/small_system.txt") }

    it "has the right number of paths" do
      expect(subject.finished_paths.count).to eq(36)
    end

    it "has the right path list" do
      expect(subject.path_list).to eq("start,A,b,A,b,A,c,A,end\nstart,A,b,A,b,A,end\nstart,A,b,A,b,end\nstart,A,b,A,c,A,b,A,end\nstart,A,b,A,c,A,b,end\nstart,A,b,A,c,A,c,A,end\nstart,A,b,A,c,A,end\nstart,A,b,A,end\nstart,A,b,d,b,A,c,A,end\nstart,A,b,d,b,A,end\nstart,A,b,d,b,end\nstart,A,b,end\nstart,A,c,A,b,A,b,A,end\nstart,A,c,A,b,A,b,end\nstart,A,c,A,b,A,c,A,end\nstart,A,c,A,b,A,end\nstart,A,c,A,b,d,b,A,end\nstart,A,c,A,b,d,b,end\nstart,A,c,A,b,end\nstart,A,c,A,c,A,b,A,end\nstart,A,c,A,c,A,b,end\nstart,A,c,A,c,A,end\nstart,A,c,A,end\nstart,A,end\nstart,b,A,b,A,c,A,end\nstart,b,A,b,A,end\nstart,b,A,b,end\nstart,b,A,c,A,b,A,end\nstart,b,A,c,A,b,end\nstart,b,A,c,A,c,A,end\nstart,b,A,c,A,end\nstart,b,A,end\nstart,b,d,b,A,c,A,end\nstart,b,d,b,A,end\nstart,b,d,b,end\nstart,b,end")
    end
  end

  context "with medium cave system" do
    let(:subject) { described_class.new("spec/fixtures/medium_system.txt") }

    it "has the right number of paths" do
      expect(subject.finished_paths.count).to eq(103)
    end
  end

  context "with large cave system" do
    let(:subject) { described_class.new("spec/fixtures/larger_system.txt") }

    it "has the right number of paths" do
      expect(subject.finished_paths.count).to eq(3509)
    end
  end

  context "with real data" do
    let(:subject) { described_class.new("input.txt") }

    it "has the right number of paths" do
      expect(subject.finished_paths.count).to eq(4411)
    end
  end
end
