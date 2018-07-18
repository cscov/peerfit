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

  describe "#has_flush?" do
    let(:players) {
      {
        hand_one: %w(2C 6C 8C TC AC),
        hand_two: %w(2D 6H 7H 9C AH)
      }
    }
    it "returns true when a hand has a single suit" do
      game = PokerHands.new(players)
      expect(game.has_flush?(players[:hand_one])).to be true
    end
    it "returns false wehn a hand has multiple suits" do
      game = PokerHands.new(players)
      expect(game.has_flush?(players[:hand_two])).to be false
    end
  end

  describe "#has_straight?" do
    let(:players) {
      {
        hand_one: %w(2C 3S 4H 5D 6C),
        hand_two: %w(5C 8C KC AC TC)
      }
    }
    it "returns true if a hand has five consecutive values" do
      game = PokerHands.new(players)
      expect(game.has_straight?(players[:hand_one])).to eq true
    end
    it "returns false if a hand does not have five consecutive values" do
      game = PokerHands.new(players)
      expect(game.has_straight?(players[:hand_two])).to eq false
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
