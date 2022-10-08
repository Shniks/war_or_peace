require 'rspec'
require './lib/deck'

RSpec.describe Deck do
  before do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @cards = [@card1, @card2, @card3]
  end

  it 'exists' do
    deck = Deck.new(@cards)

    expect(deck).to be_a(Deck)
  end

  it 'has attributes' do
    deck = Deck.new(@cards)

    expect(deck.cards.count).to eq(3)
    expect(deck.cards).to be_a(Array)
    expect(deck.cards).to eq(@cards)
  end

  it 'displays rank of cards' do
    deck = Deck.new(@cards)

    expect(deck.rank_of_card(0)).to eq(12)
    expect(deck.rank_of_card(1)).to eq(3)
    expect(deck.rank_of_card(2)).to eq(14)
  end

  it 'provides high ranking cards' do
    deck = Deck.new(@cards)

    expect(deck.high_ranking_cards).to eq([@card1, @card3])
    expect(deck.high_ranking_cards).to be_a(Array)
  end

  it 'provides percent high ranking cards' do
    deck = Deck.new(@cards)

    expect(deck.percent_high_ranking).to eq(66.67)
  end

  it 'can remove a card from the deck' do
    deck = Deck.new(@cards)

    expect(deck.remove_card).to eq(@card1)
    expect(deck.cards.count).to eq(2)
    expect(deck.cards).to eq([@card2, @card3])
  end

end
