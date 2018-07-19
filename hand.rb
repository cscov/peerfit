require "byebug"
class Hand
  attr_reader :cards

  RANKED_VALUES = %w(2 3 4 5 6 7 8 9 T J Q K A)
  RANKED_WINNING_HANDS = %w(highest_value one_pair two_pair three_of_a_kind
                            straight flush full_house four_of_a_kind straight_flush
                            royal_flush)

  def initialize(hand)
    @cards = self.sort_hand_by_value(hand)
  end

  # cards should be in the order shown in constant RANKED_VALUES
  def sort_hand_by_value(hand)
    value_hash = Hash.new
    sorted_hand = []

    hand.each do |card|
      value = card[0]
      suit = card[1]
      sort_index = RANKED_VALUES.index(value)
      if !value_hash[sort_index]
        value_hash[sort_index] = [[value, suit]]
      else
        value_hash[sort_index].push([value, suit])
      end
    end
    sorted_keys = value_hash.keys.sort
    sorted_keys.each do |key|
      val_array = value_hash[key]
      val_array.each do |card|
        sorted_hand.push(card.join)
      end
    end
    sorted_hand
  end

  def hand_values
    values = []
    self.cards.each do |card|
      values.push(card[0])
    end

    values
  end

  def one_suit?
    suits = []
    self.cards.each do |card|
      suits.push(card[card.length - 1])
    end
    first_suit = suits[0]
    suits.all? { |suit| suit == first_suit }
  end

  def has_flush?
    one_suit?
  end

  def has_royal_flush?
    royal_values = %w(T J K Q A)
    values = self.hand_values
    if self.has_flush?
      values.all? { |val| royal_values.include?(val) }
    else
      false
    end
  end

  def has_straight?
    values = self.hand_values
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

  def has_straight_flush?
    self.has_straight? && self.has_flush?
  end

  def has_four_of_a_kind?
    values = self.hand_values
    values.each do |val|
      return true if values.count(val) == 4
    end
    false
  end

  def has_three_of_a_kind?
    value_hash = Hash.new(0)
    values = self.hand_values

    values.each do |val|
      value_hash[val] += 1
    end

    if value_hash.any? { |_, v| v == 3 }
      true
    else
      false
    end
  end

  def has_full_house?
    value_hash = Hash.new(0)
    values = self.hand_values

    values.each do |val|
      value_hash[val] += 1
    end

    if value_hash.any? { |_, v| v == 2 } &&
      self.has_three_of_a_kind?
      true
    else
      false
    end
  end

  def pair_count
    value_hash = Hash.new(0)
    values = self.hand_values

    values.each do |val|
      value_hash[val] += 1
    end

    pair_count = 0
    value_hash.each_value do |v|
      pair_count += 1 if v == 2
    end
    pair_count
  end

  def has_two_pairs?
    self.pair_count == 2
  end

  def has_one_pair?
    self.pair_count == 1
  end

  def highest_card
    self.hand_values.last
  end

  def hand_rank
    if self.has_royal_flush?
      RANKED_WINNING_HANDS.index("royal_flush")
    elsif self.has_straight_flush?
      RANKED_WINNING_HANDS.index("straight_flush")
    elsif self.has_four_of_a_kind?
      RANKED_WINNING_HANDS.index("four_of_a_kind")
    elsif self.has_full_house?
      RANKED_WINNING_HANDS.index("full_house")
    elsif self.has_flush?
      RANKED_WINNING_HANDS.index("flush")
    elsif self.has_straight?
      RANKED_WINNING_HANDS.index("straight")
    elsif self.has_three_of_a_kind?
      RANKED_WINNING_HANDS.index("three_of_a_kind")
    elsif self.has_two_pairs?
      RANKED_WINNING_HANDS.index("two_pair")
    elsif self.has_one_pair?
      RANKED_WINNING_HANDS.index("one_pair")
    else
      0 # RANKED_WINNING_HANDS.index("highest_value")
    end
  end

end
