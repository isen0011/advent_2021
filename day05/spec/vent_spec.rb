require_relative "../vent_map"

RSpec.describe VentMap do
  context "with test data" do
    let(:subject) { VentMap.new("spec/fixtures/testdata.txt") }
    let(:example_map) { File.readlines("spec/fixtures/example_map.txt").map(&:strip) }

    it "returns the expected map" do
      expect(subject.to_s).to eq(example_map.join("\n"))
    end

    it "finds the points where at least two lines overlap" do
      expect(subject.overlap_count).to eq(12)
    end

    File.readlines("spec/fixtures/testdata.txt").map(&:strip).each do |line|
      context "with #{line}" do
        before do
          File.write("temp_file.txt", line)
        end

        after do
          File.delete("temp_file.txt")
        end

        it "reads line #{line} correctly" do
          puts line
          puts File.readlines("temp_file.txt")
          test_map = VentMap.new("temp_file.txt")
          expect(test_map.to_s).to eq(line)
        end
      end
    end
  end

  context "with real data" do
    let(:subject) { VentMap.new("input.txt") }

    it "finds the points where at least two lines overlap" do
      expect(subject.overlap_count).to eq(5)
    end
  end

  describe VentMap::Point do
    let(:start_point) { VentMap::Point.new(1,4) }
    let(:mid_point) { VentMap::Point.new(2,4) }
    let(:end_point) { VentMap::Point.new(3,4) }

    it "get a line" do
      expect(start_point.line_to(end_point)).to contain_exactly(start_point, mid_point, end_point)
    end
  end
end
