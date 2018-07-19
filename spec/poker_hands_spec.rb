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
