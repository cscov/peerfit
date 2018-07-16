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

RSpec.describe PokerHands, "#initialize" do
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
