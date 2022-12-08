require_relative "../deterministic_die"

RSpec.describe DeterministicDie do
  it "rolls numbers in sequence" do
    expect(subject.roll).to eq(1)
    expect(subject.roll).to eq(2)
    expect(subject.roll).to eq(3)
  end

  it "can roll three numbers at once" do
    expect(subject.roll(3)).to eq(6)
  end

  it "loops back around to 1" do
    (1..100).each do |expected_roll|
      expect(subject.roll).to eq(expected_roll)
    end
    expect(subject.roll).to eq(1)
  end

  it "counts the number of rolls made" do
    expect(subject.rolls).to eq(0)
    subject.roll
    expect(subject.rolls).to eq(1)
    subject.roll(3)
    expect(subject.rolls).to eq(4)
  end
end
