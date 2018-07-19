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

  def highest_value_winner(hand1, hand2)
    hand_one_highest = Hand::RANKED_VALUES.index(hand1.highest_card)
    hand_two_highest = Hand::RANKED_VALUES.index(hand2.highest_card)
    case hand_one_highest <=> hand_two_highest
    when 1
      hand1
    when -1
      hand2
    when 0
      if !hand1.empty?
        self.highest_value_winner(hand1[0..hand1.length - 1],
                                  hand2[0..hand2.length - 1])
      end
    end
  end

  def winner(hand1, hand2)
    hand_one_rank = hand1.hand_rank
    hand_two_rank = hand2.hand_rank

    case hand_one_rank <=> hand_two_rank
    when 1
      hand1
    when -1
      hand2
    when 0
      self.highest_value_winner(hand1, hand2)
    end
  end
end

all_hands = File.new("poker.txt")
hands = PokerHands.parse_file(all_hands, 0)
game = PokerHands.new(hands[:hand_one], hands[:hand_two])
