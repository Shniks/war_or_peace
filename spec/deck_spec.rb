require 'rspec'
require './lib/deck'

RSpec.describe Deck do
  before do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    @cards = [card1, card2, card3]
  end 

  it 'exists' do
    deck = Deck.new(@cards)

    expect(deck).to be_a(Deck)
  end

end