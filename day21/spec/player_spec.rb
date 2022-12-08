require_relative '../player'

RSpec.describe Player do
  context "with no score" do
    let(:subject) { described_class.new(spot: 2) }
    it "saves the initial position" do
      expect(subject.space).to eq(2)
    end

    it "starts with no score" do
      expect(subject.score).to eq(0)
    end

    it "can move forward" do
      subject.move(8)
      expect(subject.space).to eq(10)
    end

    it "scores the space that it moves on to" do
      subject.move(4)
      expect(subject.score).to eq(6)
    end

    it "wraps around at 10" do
      subject.move(13)
      expect(subject.space).to eq(5)
    end

    it "scores multiple moves" do
      subject.move(13)
      expect(subject.score).to eq(5)
      subject.move(18)
      expect(subject.score).to eq(8)
      subject.move(20)
      expect(subject.score).to eq(11)
    end

    it "knows when someone has won" do
      expect(subject.won?).to be_falsy
      subject.score = 21
      expect(subject.won?).to be_truthy
    end
  end

  context "with a score" do
    let(:subject) { described_class.new(spot: 2, score: 900) }
    it "saves the initial position" do
      expect(subject.space).to eq(2)
    end

    it "starts with a score" do
      expect(subject.score).to eq(900)
    end

    it "can move forward" do
      subject.move(8)
      expect(subject.space).to eq(10)
    end

    it "scores the space that it moves on to" do
      subject.move(4)
      expect(subject.score).to eq(906)
    end

    it "wraps around at 10" do
      subject.move(13)
      expect(subject.space).to eq(5)
    end

    it "scores multiple moves" do
      subject.move(13)
      expect(subject.score).to eq(905)
      subject.move(18)
      expect(subject.score).to eq(908)
      subject.move(20)
      expect(subject.score).to eq(911)
    end
  end
end
