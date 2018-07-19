require_relative "../hand"

RSpec.describe Hand do
  describe "#initialize" do
    let(:cards) {
      %w(2C 6D 9H TC JH)
    }
    it "initializes with a sorted hand" do
      hand = Hand.new(cards)
      expect(hand.cards).to eq(cards)
    end
  end

  describe "#sort_hand_by_value" do
    let(:hand1) {
      %w(2S 3H 4D 5C 6S)
    }
    let(:hand2) {
      %w(TH KH 2H 4H 6H)
    }
    it "returns a sorted hand by poker values(lowest to highest)" do
      hand_one = Hand.new(hand1)
      hand_two = Hand.new(hand2)
      expect(hand_one.sort_hand_by_value(hand1)).to eq(%w(2S 3H 4D 5C 6S))
      expect(hand_two.sort_hand_by_value(hand2)).to eq(%w(2H 4H 6H TH KH))
    end
  end

  describe "#hand_values" do
    let(:hand1) {
      Hand.new(%w(2S 4S 5S QS KS))
    }
    let(:hand2) {
      Hand.new(%w(2H 4H 5H QH KH))
    }
    it "returns an array of a hand's values" do
      expect(hand1.hand_values).to eq(%w(2 4 5 Q K))
      expect(hand2.hand_values).to eq(%w(2 4 5 Q K))
    end
  end
end
