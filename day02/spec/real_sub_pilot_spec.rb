require_relative '../real_sub_pilot'

RSpec.describe SubPilot do
  context "test data" do
    let(:subject) { SubPilot.new("spec/fixtures/testdata.txt") }

    it "gets the right horizontal from the test" do
      expect(subject.horizontal).to eq(15)
    end

    it "gets the right vertical from the test" do
      expect(subject.vertical).to eq(60)
    end

    it "gets the right multiplied value" do
      expect(subject.vertical * subject.horizontal).to eq(900)
    end
  end

  context "real data" do
    let(:subject) { SubPilot.new("input.txt") }

    it "gets the right horizontal from the test" do
      expect(subject.horizontal).to eq(15)
    end

    it "gets the right vertical from the test" do
      expect(subject.vertical).to eq(10)
    end

    it "gets the right multiplied value" do
      expect(subject.vertical * subject.horizontal).to eq(150)
    end
  end
end
