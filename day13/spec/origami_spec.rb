require_relative '../origami'

RSpec.describe Origami do
  context "with test data" do
    let(:subject) { described_class.new("spec/fixtures/testdata.txt") }

    let(:original_page) { <<~ORIG.chomp
      ...#..#..#.
      ....#......
      ...........
      #..........
      ...#....#.#
      ...........
      ...........
      ...........
      ...........
      ...........
      .#....#.##.
      ....#......
      ......#...#
      #..........
      #.#........
ORIG
}

    let(:first_folded_page) { <<~FIRST_FOLD.chomp
      #.##..#..#.
      #...#......
      ......#...#
      #...#......
      .#.#..#.###
FIRST_FOLD
}
    let(:square) { <<~SQUARE.chomp
      #####
      #...#
      #...#
      #...#
      #####
SQUARE
}


    it "outputs the original pre-folded paper" do
      expect(subject.to_s).to eq(original_page)
    end

    it "gets the right folded page" do
      subject.fold(1)
      expect(subject.to_s).to eq(first_folded_page)
    end

    it "gets the right count of dots after folding" do
      subject.fold(1)
      expect(subject.dot_count).to eq(17)
    end

    it "gets a square after all folding" do
      subject.fold
      expect(subject.to_s).to eq(square)
    end
  end

  context "with test data" do
    let(:subject) { described_class.new("input.txt") }
    let(:square) { <<~SQUARE.chomp
      #####
      #...#
      #...#
      #...#
      #####
SQUARE
}
    it "gets the right count of dots after folding" do
      subject.fold(1)
      expect(subject.dot_count).to eq(720)
    end

    it "gets a square after all folding" do
      subject.fold
      expect(subject.to_s).to eq(square)
    end
  end
end
