require_relative '../bingo_game'

RSpec.describe BingoGame do
  context "with test data" do
    let(:subject) { BingoGame.new("spec/fixtures/testdata.txt") }

    it "gets the right moves" do
      expect(subject.called_numbers).to eq([7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
    end

    it "gets the winning board's score" do
      expect(subject.score).to eq(4512)
    end

    it "gets the right unmarked score" do
      expect(subject.winner.unmarked_score).to eq(188)
    end
  end

  context "with real data" do
    let(:subject) { BingoGame.new("input.txt") }

    it "gets the winning board's score" do
      expect(subject.score).to eq(4512)
    end
  end
end
