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
    let(:hand3) {
      %w(2D 2H 3D 3S AC)
    }
    context "returns a sorted hand by poker values(lowest to highest)" do
      it "sorts a multi-suit hand that is already suited" do
        hand_one = Hand.new(hand1)
        expect(hand_one.sort_hand_by_value(hand1)).to eq(%w(2S 3H 4D 5C 6S))
      end
      it "sorts a single_suit hand" do
        hand_two = Hand.new(hand2)
        expect(hand_two.sort_hand_by_value(hand2)).to eq(%w(2H 4H 6H TH KH))
      end
      it "sorts a hand that contains pairs" do
        hand_three = Hand.new(hand3)
        expect(hand_three.sort_hand_by_value(hand3)).to eq(%w(2D 2H 3D 3S AC))
      end
    end
  end

  describe "#hand_values" do
    let(:hand1) {
      Hand.new(%w(2S 4S 5S QS KS))
    }
    let(:hand2) {
      Hand.new(%w(2H 4H 5H QH KH))
    }
    let(:hand3) {
      Hand.new(%w(2D 2C 3C KC AC))
    }
    it "returns an array of a hand's values" do
      expect(hand1.hand_values).to eq(%w(2 4 5 Q K))
      expect(hand2.hand_values).to eq(%w(2 4 5 Q K))
      expect(hand3.hand_values).to eq(%w(2 2 3 K A))
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

  describe "#has_four_of_a_kind?" do
    let(:hand1) {
      Hand.new(%w(2C 2D 2H 2S 3C))
    }
    let(:hand2) {
      Hand.new(%w(3H 4H QH KH TH))
    }
    it "returns true if a hand has four cards of the same value" do
      expect(hand1.has_four_of_a_kind?).to be true
    end
    it "returns false if a hand does not have four cards of the same value" do
      expect(hand2.has_four_of_a_kind?).to be false
    end
  end

  describe "#has_three_of_a_kind?" do
    let(:hand1) {
      Hand.new(%w(2C 2D 2H 5C 8H))
    }
    let(:hand2) {
      Hand.new(%w(4C TH 7C 8C 5D))
    }
    it "returns true if the hand has three of the same value" do
      expect(hand1.has_three_of_a_kind?).to be true
    end
    it "returns false if the hand does not have three of the same value" do
      expect(hand2.has_three_of_a_kind?).to be false
    end
  end

  describe "#has_full_house" do
    let(:hand1) {
      Hand.new(%w(2S 2D 2H 3H 3D))
    }
    let(:hand2) {
      Hand.new(%w(2C 3C 4C 5C 6C))
    }
    it "returns true if a hand has 3 of a kind and a pair" do
      expect(hand1.has_full_house?).to be true
    end
    it "returns false if a hand does not have 3 of a kind and a pair" do
      expect(hand2.has_full_house?).to be false
    end
  end

  describe "#pair_count" do
    let(:hand1) {
      Hand.new(%w(2C 3C 4C 4H 5D))
    }
    let(:hand2) {
      Hand.new(%w(2H 2D 3H 3D 5C))
    }
    let(:hand3) {
      Hand.new(%w(2C 3C 6C 4H 5D))
    }
    it "returns the number of pairs in a hand" do
      expect(hand1.pair_count).to eq(1)
      expect(hand2.pair_count).to eq(2)
      expect(hand3.pair_count).to eq(0)
    end
  end

  describe "#has_two_pairs?" do
    let(:hand1) {
      Hand.new(%w(2C 2D 3C 3H 4D))
    }
    let(:hand2) {
      Hand.new(%w(2H 3D 8C 9C TH))
    }
    it "returns true if the hand has two pairs of the same value" do
      expect(hand1.has_two_pairs?).to be true
    end
    it "returns false if the hand does not have two pairs of the same value" do
      expect(hand2.has_two_pairs?).to be false
    end
  end

  describe "#has_one_pair?" do
    let(:hand1) {
      Hand.new(%w(2C 2D 4H 5C 6H))
    }
    let(:hand2) {
      Hand.new(%w(2C 2D 3C 3H 4D))
    }
    let(:hand3) {
      Hand.new(%w(2H 3D 8C 9C TH))
    }
    it "returns true if the hand has one pair" do
      expect(hand1.has_one_pair?).to be true
    end
    it "returns false if the hand has more than one pair" do
      expect(hand2.has_one_pair?).to be false
    end
    it "returns false if the hand has no pairs" do
      expect(hand3.has_one_pair?).to be false
    end
  end

  describe "#highest_card" do
    let(:hand1) {
      Hand.new(%w(2C 5C KC QC AC))
    }
    let(:hand2) {
      Hand.new(%w(2D 3D KH AD AH))
    }
    it "returns the highest valued card in a hand" do
      expect(hand1.highest_card).to eq("A")
      expect(hand2.highest_card).to eq("A")
    end
  end

  describe "#hand_rank" do
    let(:hand1) {
      Hand.new(%w(2C 5C KC QD AC))
    }
    let(:hand2) {
      Hand.new(%w(2D 2H QH KD AH))
    }
    it "determines the hand's rank returns the index of that rank in
    RANKED_WINNING_HANDS" do
      expect(hand1.hand_rank).to eq(0)
      expect(hand2.hand_rank).to eq(1)
    end
  end
end
