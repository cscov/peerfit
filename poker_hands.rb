require "byebug"
require_relative "./hand"

class PokerHands

  attr_accessor :player_one_hand, :player_two_hand
  attr_reader :f

  RANKED_WINNING_HANDS = %w(highest_value one_pair two_pair three_of_a_kind
                            straight flush full_house four_of_a_kind straight_flush
                            royal_flush )

  def initialize(players)
    @player_one_hand = Hand.new(players[:hand_one])
    @player_two_hand = Hand.new(players[:hand_two])
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
    if self.has_flush?(hand)
      values.all? { |val| royal_values.include?(val) }
    else
      false
    end
  end

  def has_straight_flush?(hand)
    self.has_straight?(hand) && self.has_flush?(hand)
  end

  def has_four_of_a_kind?(hand)
    values = self.hand_values(hand)
    values.each do |val|
      return true if values.count(val) == 4
    end
    false
  end

  def has_full_house?(hand)
    value_hash = Hash.new(0)
    values = self.hand_values(hand)

    values.each do |val|
      value_hash[val] += 1
    end

    if value_hash.any? { |_, v| v == 2 } &&
      self.has_three_of_a_kind?(hand)
      true
    else
      false
    end
  end

  def has_flush?(hand)
    one_suit?(hand)
  end

  def has_straight?(hand)
    values = hand_values(hand)
    i = 0
    start_index = RANKED_VALUES.index(values[0])
    while i < values.length - 1
      # check for consecutive values
      return false if RANKED_VALUES.index(values[i + 1]) !=
      start_index + (i + 1)
      i += 1
    end
    true
  end

  def has_three_of_a_kind?(hand)
    value_hash = Hash.new(0)
    values = self.hand_values(hand)

    values.each do |val|
      value_hash[val] += 1
    end

    if value_hash.any? { |_, v| v == 3 }
      true
    else
      false
    end
  end

  def has_two_pairs?(hand)
    self.pair_count(hand) == 2
  end

  def has_one_pair?(hand)
    self.pair_count(hand) == 1
  end

  def pair_count(hand)
    value_hash = Hash.new(0)
    values = self.hand_values(hand)

    values.each do |val|
      value_hash[val] += 1
    end

    pair_count = 0
    value_hash.each_value do |v|
      pair_count += 1 if v == 2
    end
    pair_count
  end

  def highest_card(hand)
    self.hand_values(hand).last
  end

  def hand_rank(hand)
    if self.has_royal_flush?(hand)
      RANKED_WINNING_HANDS.index("royal_flush")
    elsif self.has_straight_flush?(hand)
      RANKED_WINNING_HANDS.index("straight_flush")
    elsif self.has_four_of_a_kind?(hand)
      RANKED_WINNING_HANDS.index("four_of_a_kind")
    elsif self.has_full_house?(hand)
      RANKED_WINNING_HANDS.index("full_house")
    elsif self.has_flush?(hand)
      RANKED_WINNING_HANDS.index("flush")
    elsif self.has_straight?(hand)
      RANKED_WINNING_HANDS.index("straight")
    elsif self.has_three_of_a_kind?(hand)
      RANKED_WINNING_HANDS.index("three_of_a_kind")
    elsif self.has_two_pairs?(hand)
      RANKED_WINNING_HANDS.index("two_pairs")
    elsif self.has_one_pair?(hand)
      RANKED_WINNING_HANDS.index("one_pair")
    else
      0 # RANKED_WINNING_HANDS.index("highest_value")
    end
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
hand = PokerHands.new(PokerHands.parse_file(all_hands, 0))
