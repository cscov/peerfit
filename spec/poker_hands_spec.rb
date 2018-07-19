require_relative "../poker_hands"
require_relative "../hand"

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
    let(:hand1) {
      %w(2S 3S 4S 5S 6S)
    }
    let(:hand2) {
      %w(7S 8S 9S TS JS)
    }
    it 'initializes a new game with two hands' do
      game = PokerHands.new(hand1, hand2)
      expect(game.player_one_hand).to eq(hand1)
      expect(game.player_two_hand).to eq(hand2)
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

  describe "#has_three_of_a_kind?" do
    let(:players) {
      {
        hand_one: %w(2C 2D 2H 5C 8H),
        hand_two: %w(4C TH 7C 8C 5D)
      }
    }
    it "returns true if the hand has three of the same value" do
      game = PokerHands.new(players)
      expect(game.has_three_of_a_kind?(players[:hand_one])).to be true
    end
    it "returns false if the hand does not have three of the same value" do
      game = PokerHands.new(players)
      expect(game.has_three_of_a_kind?(players[:hand_two])).to be false
    end
  end

  describe "#has_two_pairs?" do
    let(:players) {
      {
        hand_one: %w(2C 2D 3C 3H 4D),
        hand_two: %w(2H 3D 8C 9C TH)
      }
    }
    it "returns true if the hand has two pairs of the same value" do
      game = PokerHands.new(players)
      expect(game.has_two_pairs?(players[:hand_one])).to be true
    end
    it "returns false if the hand does not have two pairs of the same value" do
      game = PokerHands.new(players)
      expect(game.has_two_pairs?(players[:hand_two])).to be false
    end
  end

  describe "#has_one_pair?" do
    let(:players) {
      {
        hand_one: %w(2C 2D 4H 5C 6H),
        hand_two: %w(2H 6D KC KH KD)
      }
    }
    let(:players2) {
      {
        hand_one: %w(2C 2D 3C 3H 4D),
        hand_two: %w(2H 3D 8C 9C TH)
      }
    }
    it "returns true if the hand has one pair" do
      game = PokerHands.new(players)
      expect(game.has_one_pair?(players[:hand_one])).to be true
    end
    it "returns false if the hand has more than one pair" do
      game = PokerHands.new(players2)
      expect(game.has_one_pair?(players2[:hand_one])).to be false
    end
    it "returns false if the hand has no pairs" do
      game = PokerHands.new(players)
      expect(game.has_one_pair?(players2[:hand_two])).to be false
    end
  end

  describe "#pair_count" do
    let(:players) {
      {
        hand_one: %w(2C 3C 4C 4H 5D),
        hand_two: %w(2H 2D 3H 3D 5C)
      }
    }
    let(:players2) {
      {
        hand_one: %w(2C 3C 6C 4H 5D),
        hand_two: %w(2H 2D 3H 3D 5C)
      }
    }
    it "returns the number of pairs in a hand" do
      game = PokerHands.new(players)
      game2 = PokerHands.new(players2)
      expect(game.pair_count(players[:hand_one])).to eq(1)
      expect(game.pair_count(players[:hand_two])).to eq(2)
      expect(game2.pair_count(players2[:hand_one])).to eq(0)
    end
  end

  describe "#highest_card" do
    let(:players) {
      {
        hand_one: %w(2C 5C KC QC AC),
        hand_two: %w(2D 3D KH AD AH)
      }
    }
    it "returns the highest valued card in a hand" do
      game = PokerHands.new(players)
      expect(game.highest_card(players[:hand_one])).to eq("A")
      expect(game.highest_card(players[:hand_two])).to eq("A")
    end
  end

  describe "#hand_rank" do
    let(:players) {
      {
        hand_one: %w(2C 5C KC QD AC),
        hand_two: %w(2D 2H QH KD AH)
      }
    }
    it "determines the hand's rank returns the index of that rank in
    RANKED_WINNING_HANDS" do
      game = PokerHands.new(players)
      expect(game.hand_rank(players[:hand_one])).to eq(0)
      expect(game.hand_rank(players[:hand_two])).to eq(1)
    end
  end

  describe "#winner" do
    let(:high_val_players) {
      {
        hand_one: %w(2C 4H 5D 6C 8C),
        hand_two: %w(2H 4C 5H TH AH)
      }
    }
    let(:one_pair_players) {
      {
        hand_one: %w(2C 2H 3D 7C KC),
        hand_two: %w(2D 4H 5D 6C 8C)
      }
    }
    it "returns the winning hand when the highest-valued card wins" do
      game = PokerHands.new(high_val_players)
      expect(game.winner(high_val_players[:hand_one],
                         high_val_players[:hand_two]))
                         .to eq(high_val_players[:hand_two])
    end
    # one pair
    it "returns the winning hand when the single_pair hand wins" do
      game = PokerHands.new(one_pair_players)
      expect(game.winner(one_pair_players[:hand_one],
                         one_pair_players[:hand_two])).to eq(one_pair_players[:hand_one])
    end
    # two pairs
    # three of a kind
    # straight
    # flush
    # full house
    # four of a kind
    # straight flush
    # royal flush
    # tie breaker
  end
end
