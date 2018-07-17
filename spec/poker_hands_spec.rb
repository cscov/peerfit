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
        :hand_two => %w(7S 8S 9S 10S JS)
      }
    }
    it 'initializes a new game with two hands' do
      game = PokerHands.new(players)
      expect(game.player_one_hand).to eq(%w(2S 3S 4S 5S 6S))
      expect(game.player_two_hand).to eq(%w(7S 8S 9S 10S JS))
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
      %w(10S JS QS KS AS)
    }
    let(:non_royal) {
      %w(10H JC QC KD AH)
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
end
