require_relative '../diagnostic'

RSpec.describe Diagnostic do
  context "life_support" do
    context "with test input" do
      let(:subject) { Diagnostic.new("spec/fixtures/testdata.txt") }

      it "gets the oxygen_generator rating" do
        expect(subject.oxygen_generator).to eq(23)
      end

      it "gets the co2_scrubber rating" do
        expect(subject.co2_scrubber).to eq(10)
      end

      it "gets the life_support rating" do
        expect(subject.life_support).to eq(230)
      end
    end

    context "with real input" do
      let(:subject) { Diagnostic.new("input.txt") }

      it "gets the oxygen_generator rating" do
        expect(subject.oxygen_generator).to eq(23)
      end

      it "gets the co2_scrubber rating" do
        expect(subject.co2_scrubber).to eq(10)
      end

      it "gets the life_support rating" do
        expect(subject.life_support).to eq(230)
      end
    end
  end

  context "power_consuption" do
    context "with test input" do
      let(:subject) { Diagnostic.new("spec/fixtures/testdata.txt") }

      it "gets the gamma" do
        expect(subject.gamma).to eq(22)
      end

      it "gets the epsilon" do
        expect(subject.epsilon).to eq(9)
      end

      it "gets the power consumption" do
        expect(subject.power_consumption).to eq(198)
      end

      it "gets the right binary length" do
        expect(subject.binary_length).to eq(5)
      end
    end

    context "with real input" do
      let(:subject) { Diagnostic.new("input.txt") }

      it "gets the gamma" do
        expect(subject.gamma).to eq(22)
      end

      it "gets the epsilon" do
        expect(subject.epsilon).to eq(9)
      end

      it "gets the power consumption" do
        expect(subject.power_consumption).to eq(198)
      end
    end
  end
end
