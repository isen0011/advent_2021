require_relative '../packet'

RSpec.describe Packet do
  context "with literal packet" do
    let(:file) { "spec/fixtures/literal_2021.txt" }

    it "creates single literal packet with versum 6" do
      packet = described_class.from_file(file)
      expect(packet).to be_an_instance_of(LiteralPacket)
      expect(packet.version).to eq(6)
      expect(packet.type_id).to eq(4)
      expect(packet.versum).to eq(6)
      expect(packet.value).to eq(2021)
    end
  end

  context "with operator with length bits" do
    let(:file) { "spec/fixtures/operator_6_length_type.txt" }
    let(:packet) { described_class.from_file(file) }

    it "creates operator packet with versum 1" do
      expect(packet).to be_an_instance_of(OperatorPacket)
      expect(packet.version).to eq(1)
      expect(packet.type_id).to eq(6)
    end

    it "has two subpackets" do
      expect(packet.subpackets.count).to eq(2)
      expect(packet.subpackets[0]).to be_an_instance_of(LiteralPacket)
      expect(packet.subpackets[0].value).to eq(10)
      expect(packet.subpackets[1]).to be_an_instance_of(LiteralPacket)
      expect(packet.subpackets[1].value).to eq(20)
    end

    it "gets the right value" do
      expect(packet.versum).to eq(9)
    end
  end

  context "with operator with subpacket count bit" do
    let(:file) { "spec/fixtures/operator_3_three_subpackets.txt" }
    let(:packet) { described_class.from_file(file) }

    it "creates operator packet with versum 1" do
      expect(packet).to be_an_instance_of(OperatorPacket)
      expect(packet.version).to eq(7)
      expect(packet.type_id).to eq(3)
    end

    it "has three subpackets" do
      expect(packet.subpackets.count).to eq(3)
      expect(packet.subpackets[0]).to be_an_instance_of(LiteralPacket)
      expect(packet.subpackets[0].value).to eq(1)
      expect(packet.subpackets[1]).to be_an_instance_of(LiteralPacket)
      expect(packet.subpackets[1].value).to eq(2)
      expect(packet.subpackets[2]).to be_an_instance_of(LiteralPacket)
      expect(packet.subpackets[2].value).to eq(3)
    end

    it "gets the right versum" do
      expect(packet.versum).to eq(14)
    end
  end

  context "with operator nexted_operator packets" do
    let(:file) { "spec/fixtures/operator_vers_sum_16.txt" }
    let(:packet) { described_class.from_file(file) }

    it "creates operator packet with version 4" do
      expect(packet).to be_an_instance_of(OperatorPacket)
      expect(packet.version).to eq(4)
    end

    it "has three nested subpackets" do
      expect(packet.version).to eq(4)
      expect(packet.subpackets.count).to eq(1)
      expect(packet.subpackets[0]).to be_an_instance_of(OperatorPacket)
      expect(packet.subpackets[0].version).to eq(1)
      expect(packet.subpackets[0].subpackets.count).to eq(1)
      expect(packet.subpackets[0].subpackets[0]).to be_an_instance_of(OperatorPacket)
      expect(packet.subpackets[0].subpackets[0].version).to eq(5)
      expect(packet.subpackets[0].subpackets[0].subpackets.count).to eq(1)
      expect(packet.subpackets[0].subpackets[0].subpackets[0]).to be_an_instance_of(LiteralPacket)
      expect(packet.subpackets[0].subpackets[0].subpackets[0].version).to eq(6)
    end

    it "gets the right versum" do
      expect(packet.versum).to eq(16)
    end
  end

  context "with operator nexted_operator packets" do
    let(:file) { "spec/fixtures/operator_vers_sum_23.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right versum" do
      expect(packet.versum).to eq(23)
    end
  end

  context "with operator nexted_operator packets" do
    let(:file) { "spec/fixtures/operator_vers_sum_31.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right versum" do
      expect(packet.versum).to eq(31)
    end
  end

  context "with operator nexted_operator packets" do
    let(:file) { "spec/fixtures/operator_vers_sum_12.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right versum" do
      expect(packet.versum).to eq(12)
    end
  end

  context "add" do
    let(:file) { "spec/fixtures/vals/sum_3.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(3)
    end
  end

  context "prod" do
    let(:file) { "spec/fixtures/vals/prod_54.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(54)
    end
  end

  context "min" do
    let(:file) { "spec/fixtures/vals/min_7.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(7)
    end
  end

  context "max" do
    let(:file) { "spec/fixtures/vals/max_9.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(9)
    end
  end

  context "less than" do
    let(:file) { "spec/fixtures/vals/less_than_1.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(1)
    end
  end

  context "greater than" do
    let(:file) { "spec/fixtures/vals/greater_0.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(0)
    end
  end

  context "equal to" do
    let(:file) { "spec/fixtures/vals/equal_0.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(0)
    end
  end

  context "sum and multiply" do
    let(:file) { "spec/fixtures/vals/sum_mul_1.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right value" do
      expect(packet.value).to eq(1)
    end
  end

  context "with real data" do
    let(:file) { "input.txt" }
    let(:packet) { described_class.from_file(file) }

    it "gets the right versum" do
      expect(packet.versum).to eq(906)
    end

    it "gets the right value" do
      expect(packet.value).to eq(1)
    end

  end
end
