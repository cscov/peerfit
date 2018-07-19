require "byebug"
require_relative "./hand"

class PokerHands

  attr_accessor :player_one_hand, :player_two_hand
  attr_reader :f

  def initialize(hand1, hand2)
    @player_one_hand = hand1
    @player_two_hand = hand2
  end

  def self.parse_file(f, game_num)
    game = f.readlines[game_num].split
    hand_one = game[0..4]
    hand_two = game[5..9]

    { hand_one: hand_one, hand_two: hand_two }
  end

  def winner(hand1, hand2)
  #   hand_one_highest = RANKED_VALUES.index(self.highest_card(hand1))
  #   hand_two_highest = RANKED_VALUES.index(self.highest_card(hand2))
  #   hand_one_rank = self.hand_rank(hand1)
  #   hand_two_rank = self.hand_rank(hand2)
  #
  #   if hand_one_rank < hand_two_rank
  #     hand2
  #   elsif hand_one_rank == hand_two_rank
  #     while hand_one_rank == hand_two_rank
  #
  #     end
  #   end
  #   if hand_one_highest > hand_two_highest
  #     hand1
  #   else
  #     hand2
  #   end
  end
end

all_hands = File.new("poker.txt")
hands = PokerHands.parse_file(all_hands, 0)
game = PokerHands.new(hands[:hand_one], hands[:hand_two])
