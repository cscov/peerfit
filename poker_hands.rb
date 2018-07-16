require "byebug"

class PokerHands
  attr_accessor :player_one_hand, :player_two_hand
  attr_reader :f

  def initialize(players)
    @player_one_hand = players[:hand_one]
    @player_two_hand = players[:hand_two]
  end

  def self.parse_file(f, game_num)
    game = f.readlines[game_num].split
    hand_one = game[0..4]
    hand_two = game[5..9]

    { hand_one: hand_one, hand_two: hand_two }
  end
end
all_hands = File.new("poker.txt")
hand = PokerHands.new(PokerHands.parse_file(all_hands, 0))
