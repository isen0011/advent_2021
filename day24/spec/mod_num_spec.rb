require_relative "../mod_num"

RSpec.describe ModNum do
  it "finds the right model number" do
    expect(subject.find_number).to eq(0)
  end
end
