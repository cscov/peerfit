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

  def count_player_one_wins(f)
    player_one_wins = 0
    i = 0
    while i < 1000
      hand1 = PokerHands.parse_file(f, i)[:hand_one]
      hand2 = PokerHands.parse_file(f, i)[:hand_two]
      if self.winner(hand1, hand2) == hand1
        player_one_wins += 1
      end
      i += 1
    end
    "Player one wins #{player_one_wins} hands"
  end
end

# all_hands =
player_one_wins = 0
i = 0

while i < 1000
  # debugger
  hands = PokerHands.parse_file(File.new("poker.txt"), i)
  game = PokerHands.new(hands[:hand_one], hands[:hand_two])
  # game.count_player_one_wins(all_hands)
  hand1 = Hand.new(game.player_one_hand)
  hand2 = Hand.new(game.player_two_hand)

  if game.winner(hand1, hand2) == hand1
    player_one_wins += 1
  end
  i += 1
end

puts "Player one wins #{player_one_wins} hands"
