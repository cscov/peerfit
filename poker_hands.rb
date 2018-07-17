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

  def hand_values(hand)
    values = []
    hand.each do |card|
      values.push(card[0...card.length - 1])
    end

    values
  end

  def one_suit?(hand)
    suits = []
    hand.each do |card|
      suits.push(card[card.length - 1])
    end
    first_suit = suits[0]
    suits.all? { |suit| suit == first_suit }
  end

  def has_royal_flush?(hand)
    if self.one_suit?(hand)

    else
      false
    end
  end
end

all_hands = File.new("poker.txt")
hand = PokerHands.new(PokerHands.parse_file(all_hands, 0))
