require_relative "../hand"

RSpec.describe Hand do
  describe "#initialize" do
    let(:cards) {
      %w(2C 6D 9H TC JH)
    }
    it "initializes with a sorted hand" do
      hand = Hand.new(cards)
      expect(hand.cards).to eq(cards)
    end
  end
end
