require_relative "../poker_hands"

# RSpec.describe PokerHands, ".parse_file" do
#   let(:hand_txt) { "2S 3S 4S 5S 6S 7S 8S 9S 10S JS" }
#   let(:file) { File.new(hand_txt) }
#   it 'returns a hands object based on a file line number' do
#     hands = PokerHands.parse_file(file, 0)
#     expect(hands[:hand_one]).to eq(%w(2S 3S 4S 5S 6S))
#     expect(hands[:hand_two]).to eq(%w(7S 8S 9S 10S JS))
#   end
# end

RSpec.describe PokerHands do
  describe "#initialize" do
    let(:players) {
      {
        :hand_one => %w(2S 3S 4S 5S 6S),
        :hand_two => %w(7S 8S 9S TS JS)
      }
    }
    it 'initializes a new game with two hands' do
      game = PokerHands.new(players)
      expect(game.player_one_hand).to eq(%w(2S 3S 4S 5S 6S))
      expect(game.player_two_hand).to eq(%w(7S 8S 9S TS JS))
    end
  end

  describe "#sort_hand_by_value" do
    let(:players) {
      {
        hand_one: %w(2S 3H 4D 5C 6S),
        hand_two: %w(TH KH 2H 4H 6H)
      }
    }
    it "returns a sorted hand by poker values(lowest to highest)" do
      game = PokerHands.new(players)
      expect(game.sort_hand_by_value(players[:hand_one])).to eq(%w(2S 3H 4D 5C 6S))
      expect(game.sort_hand_by_value(players[:hand_two])).to eq(%w(2H 4H 6H TH KH))
    end
  end

  describe "#hand_values" do
    let(:players) {
      {
        hand_one: %w(2S 4S 5S KS QS),
        hand_two: %w(2H 4H 5H KH QH)
      }
    }
    it "returns an array of a hand's values" do
      game = PokerHands.new(players)
      expect(game.hand_values(players[:hand_one])).to eq(%w(2 4 5 K Q))
    end
  end

  describe "#one_suit?" do
    let(:single_suit) {
      %w(2S 4S 6S 7S 9S)
    }
    let(:multi_suit) {
      %w(2H 4C 6H 7D 9D)
    }
    let(:players) {
      {
        hand_one: single_suit,
        hand_two: multi_suit
      }
    }

    it "returns true if the player's hand is all one suit" do
      game = PokerHands.new(players)
      expect(game.one_suit?(single_suit)).to be true
    end
    it "returns false if the player's hand has multiple suits" do
      game = PokerHands.new(players)
      expect(game.one_suit?(multi_suit)).to be false
    end
  end

  describe "#has_royal_flush?" do
    let(:royal_flush) {
      %w(TS JS QS KS AS)
    }
    let(:non_royal) {
      %w(TH JC QC KD AH)
    }
    let (:players) {
      {
        hand_one: royal_flush,
        hand_two: non_royal
      }
    }

    it "returns true if a player's hand has a royal flush" do
      game = PokerHands.new(players)
      expect(game.has_royal_flush?(royal_flush)).to be true
    end
    it "returns false if a player's hand does not have a royal flush" do
      game = PokerHands.new(players)
      expect(game.has_royal_flush?(non_royal)).to be false
    end
  end

  describe "#has_straight_flush?" do
    let(:players) {
      { hand_one: %w(2S 3S 4S 5S 6S),
        hand_two: %w(2H 3C 4H 5C 6H)}
    }
    let(:players2) {
      { hand_one: %w(2S 3S 4S 5S 6S),
        hand_two: %w(2H 5H 4H 7H 6H)}
    }
    it "returns true if a hand has consecutive values of the same suit" do
      game = PokerHands.new(players)
      expect(game.has_straight_flush?(players[:hand_one])).to be true
      expect(game.has_straight_flush?(players[:hand_two])).to be false
    end
    it "returns false if a hand does not have consecutive values" do
      game = PokerHands.new(players2)
      expect(game.has_straight_flush?(players2[:hand_two])).to be false
    end
    it "returns false if a hand has multiple suits" do
      game = PokerHands.new(players)
      expect(game.has_straight_flush?(players[:hand_two])).to be false
    end
  end

  describe "#has_four_of_a_kind?" do
    let(:players) {
      {
        hand_one: %w(2C 2D 2H 2S 3C),
        hand_two: %w(3H 4H QH KH TH)
      }
    }
    it "returns true if a hand has four cards of the same value" do
      game = PokerHands.new(players)
      expect(game.has_four_of_a_kind?(players[:hand_one])).to be true
    end
    it "returns false if a hand does not have four cards of the same value" do
      game = PokerHands.new(players)
      expect(game.has_four_of_a_kind?(players[:hand_two])).to be false
    end
  end

  describe "#has_full_house" do
    let(:players) {
      {
        hand_one: %w(2S 2D 2H 3H 3D),
        hand_two: %w(2C 3C 4C 5C 6C)
      }
    }
    it "returns true if a hand has 3 of a kind and a pair" do
      game = PokerHands.new(players)
      expect(game.has_full_house?(players[:hand_one])).to be true
    end
    it "returns false if a hand does not have 3 of a kind and a pair" do
      game = PokerHands.new(players)
      expect(game.has_full_house?(players[:hand_two])).to be false
    end
  end
end
