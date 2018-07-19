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

  describe "#one_suit?" do
    let(:single_suit) {
      Hand.new(%w(2S 4S 6S 7S 9S))
    }
    let(:multi_suit) {
      Hand.new(%w(2H 4C 6H 7D 9D))
    }

    it "returns true if the player's hand is all one suit" do
      expect(single_suit.one_suit?).to be true
    end
    it "returns false if the player's hand has multiple suits" do
      expect(multi_suit.one_suit?).to be false
    end
  end

  describe "#has_flush?" do
    let(:hand1) {
      Hand.new(%w(2C 6C 8C TC AC))
    }
    let(:hand2) {
      Hand.new(%w(2D 6H 7H 9C AH))
    }
    it "returns true when a hand has a single suit" do
      expect(hand1.has_flush?).to be true
    end
    it "returns false wehn a hand has multiple suits" do
      expect(hand2.has_flush?).to be false
    end
  end

  describe "#has_royal_flush?" do
    let(:royal_flush) {
      Hand.new(%w(TS JS QS KS AS))
    }
    let(:non_royal) {
      Hand.new(%w(TH JC QC KD AH))
    }

    it "returns true if a player's hand has a royal flush" do
      expect(royal_flush.has_royal_flush?).to be true
    end
    it "returns false if a player's hand does not have a royal flush" do
      expect(non_royal.has_royal_flush?).to be false
    end
  end

  describe "#has_straight?" do
    let(:hand1) {
        Hand.new(%w(2C 3S 4H 5D 6C))
      }
      let(:hand2) {
        Hand.new(%w(5C 8C KC AC TC))
      }
    it "returns true if a hand has five consecutive values" do
      expect(hand1.has_straight?).to eq true
    end
    it "returns false if a hand does not have five consecutive values" do
      expect(hand2.has_straight?).to eq false
    end
  end

  describe "#has_straight_flush?" do
    let(:hand1) {
      Hand.new(%w(2S 3S 4S 5S 6S))
    }
    let(:hand2) {
      Hand.new(%w(2H 3C 4H 5C 6H))
    }
    let(:hand3) {
      Hand.new(%w(2H 5H 4H 7H 6H))
    }
    it "returns true if a hand has consecutive values of the same suit" do
      expect(hand1.has_straight_flush?).to be true
      expect(hand2.has_straight_flush?).to be false
    end
    it "returns false if a hand does not have consecutive values" do
      expect(hand3.has_straight_flush?).to be false
    end
    it "returns false if a hand has multiple suits" do
      expect(hand2.has_straight_flush?).to be false
    end
  end
end
