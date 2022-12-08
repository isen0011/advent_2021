require_relative '../image_enhancer'

RSpec.describe ImageEnhancer do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }
    let(:original_state) { File.readlines("spec/fixtures/original_state.txt").join.strip }
    let(:enhanced_once) { File.readlines("spec/fixtures/enhanced_1_time.txt").join.strip }
    let(:enhanced_twice) { File.readlines("spec/fixtures/enhanced_2_times.txt").join.strip }

    it "correctly outputs the starting state" do
      expect(subject.to_s).to eq(original_state)
    end

    it "correctly enhances once" do
      subject.enhance(1)
      expect(subject.to_s).to eq(enhanced_once)
    end

    it "correctly enhances twice" do
      subject.enhance(2)
      expect(subject.to_s).to eq(enhanced_twice)
    end

    it "has the right final number of pixels lit" do
      subject.enhance(2)
      expect(subject.lit_pixels).to eq(35)
    end

    it "has the right number of pixels after enhancing 50 times" do
      subject.enhance(50)
      expect(subject.lit_pixels).to eq(3351)
    end



    context "min and max values" do
      it "gets the right min x" do
        expect(subject.min_x).to eq(0)
      end

      it "gets the right max x" do
        expect(subject.max_x).to eq(4)
      end

      it "gets the right min y" do
        expect(subject.min_y).to eq(0)
      end

      it "gets the right max y" do
        expect(subject.max_y).to eq(4)
      end

      context "after one image enhancement" do
        before do
          subject.enhance
        end
        it "gets the right min x" do
          expect(subject.min_x).to eq(-1)
        end

        it "gets the right max x" do
          expect(subject.max_x).to eq(5)
        end

        it "gets the right min y" do
          expect(subject.min_y).to eq(-1)
        end

        it "gets the right max y" do
          expect(subject.max_y).to eq(5)
        end
      end
    end
  end

  context "with live data" do
    let(:subject) { described_class.new("input.txt") }
    let(:original_state) { File.readlines("spec/fixtures/input_orig.txt").join.strip }

    it "has the right final number of pixels lit" do
      subject.enhance(2)
      expect(subject.lit_pixels).to eq(5291)
    end

    it "correctly outputs the starting state" do
      expect(subject.to_s).to eq(original_state)
    end

    it "has the right number of pixels after enhancing 50 times" do
      subject.enhance(50)
      expect(subject.lit_pixels).to eq(3351)
    end

  end
end
