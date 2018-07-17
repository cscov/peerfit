require "byebug"

class PokerHands
  attr_accessor :player_one_hand, :player_two_hand
  attr_reader :f
  RANKED_VALUES = %w(2 3 4 5 6 7 8 9 T J Q K A)

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

  def sort_hand_by_value(hand)
    value_hash = Hash.new
    sorted_hand = []

    hand.each do |card|
      value = card[0]
      suit = card[1]
      sort_index = RANKED_VALUES.index(value)
      value_hash[sort_index] = [value]
      value_hash[sort_index].push(suit)
    end
    sorted_keys = value_hash.keys.sort
    sorted_keys.each do |key|
      card = value_hash[key].join
      sorted_hand.push(card)
    end
    sorted_hand
  end

  def hand_values(hand)
    values = []
    hand.each do |card|
      values.push(card[0])
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
    royal_values = %w(T J K Q A)
    values = self.hand_values(hand)
    if self.one_suit?(hand)
      values.all? { |val| royal_values.include?(val) }
    else
      false
    end
  end

  def has_straight_flush?(hand)
    if self.one_suit?(hand)

    else
      false
    end
  end
end

all_hands = File.new("poker.txt")
hand = PokerHands.new(PokerHands.parse_file(all_hands, 0))
