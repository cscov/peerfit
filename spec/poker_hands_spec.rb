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

  describe "#winner" do
    let(:high_val_hand1) {
      Hand.new(%w(2C 4H 5D 6C 8C))
    }
    let(:high_val_hand2) {
      Hand.new(%w(2H 4C 5H TH AH))
    }
    let(:one_pair_hand1) {
      Hand.new(%w(2C 2H 3D 7C KC))
    }
    let(:one_pair_hand2) {
      Hand.new(%w(2D 4H 5D 6C 8C))
    }
    let(:two_pair_hand1) {
      Hand.new(%w(2C 2H 3H 3C AH))
    }
    let(:two_pair_hand2) {
      Hand.new(%w(2D 4H 5D 6C 8C))
    }
    let(:three_pair_hand1) {
      Hand.new(%w(2C 2D 2H 4H 5H))
    }
    let(:three_pair_hand2) {
      Hand.new(%w(2S 4C 5D 6C 8C))
    }
    let(:straight_hand1) {
      Hand.new(%w(2C 3D 4H 5S 6C))
    }
    let(:straight_hand2) {
      Hand.new(%w(2S 4C 5D 6H 8C))
    }
    let(:flush_hand1) {
      Hand.new(%w(2C 5C 8C TC KC))
    }
    let(:flush_hand2) {
      Hand.new(%w(2C 5D 8D TH KH))
    }
    let(:full_hand1) {
      Hand.new(%w(2C 2H 2D 3D 3H))
    }
    let(:full_hand2) {
      Hand.new(%w(2C 2H 2D 3D 5H))
    }
    let(:four_hand1) {
      Hand.new(%w(2C 2S 2D 2H 3H))
    }
    let(:four_hand2) {
      Hand.new(%w(2C 2S 2D 3D 3H))
    }
    it "returns the winning hand when the highest-valued card wins" do
      game = PokerHands.new(high_val_hand1, high_val_hand2)
      expect(game.winner(high_val_hand1, high_val_hand2)).to eq(high_val_hand2)
    end
    it "returns the winning hand when the single-pair hand wins" do
      game = PokerHands.new(one_pair_hand1, one_pair_hand2)
      expect(game.winner(one_pair_hand1, one_pair_hand2)).to eq(one_pair_hand1)
    end
    it "returns the winning hand when the two-pair hand wins" do
      game = PokerHands.new(two_pair_hand1, two_pair_hand2)
      expect(game.winner(two_pair_hand1, two_pair_hand2)).to eq(two_pair_hand1)
    end
    it "returns the winning hand when the three-of-a-kind hand wins" do
      game = PokerHands.new(three_pair_hand1, three_pair_hand2)
      expect(game.winner(three_pair_hand1, three_pair_hand2)).to eq(three_pair_hand1)
    end
    it "returns the winning hand when the straight hand wins" do
      game = PokerHands.new(straight_hand1, straight_hand2)
      expect(game.winner(straight_hand1, straight_hand2)).to eq(straight_hand1)
    end
    it "returns the winning hand when the flush hand wins" do
      game = PokerHands.new(flush_hand1, flush_hand2)
      expect(game.winner(flush_hand1, flush_hand2)).to eq(flush_hand1)
    end
    it "returns the winning hand when the full-house hand wins" do
      game = PokerHands.new(full_hand1, full_hand2)
      expect(game.winner(full_hand1, full_hand2)).to eq(full_hand1)
    end
    # four of a kind
    it "returns the winning hand when the four-of-a-kind hand wins" do
      game = PokerHands.new(four_hand1, four_hand2)
      expect(game.winner(four_hand1, four_hand2)).to eq(four_hand1)
    end
    # straight flush
    # royal flush
    # tie breaker
  end
end
