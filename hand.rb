
class Hand
  include Comparable
  attr_reader :cards

  RANKED_VALUES = %w(2 3 4 5 6 7 8 9 T J Q K A)

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

  def <=>(other)

  end
end
