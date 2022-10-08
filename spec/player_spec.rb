require 'rspec'
require './lib/player'

RSpec.describe Player do
  before do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([card1, card2, card3])
  end

  it 'exists' do
    player = Player.new('Clarisa', @deck)

    expect(player).to be_a(Player)
  end

  it 'has attributes' do
    player = Player.new('Clarisa', @deck)

    expect(player.name).to eq('Clarisa')
    expect(player.deck).to eq(@deck)
  end

  it 'can check if player has lost' do
    player = Player.new('Clarisa', @deck)

    expect(player.has_lost?).to eq(false)

    player.deck.remove_card
    expect(player.has_lost?).to eq(false)

    player.deck.remove_card
    expect(player.has_lost?).to eq(false)

    player.deck.remove_card
    expect(player.has_lost?).to eq(true)
    expect(player.deck.cards).to eq([])
    expect(player.deck.cards.count).to eq(0)
  end

  it 'can check if player has lost in another deck' do
    player = Player.new('Clarisa', @deck)

    expect(player.has_lost?).to eq(false)

    player.deck.remove_card
    expect(player.has_lost?).to eq(false)

    card4 = Card.new(:club, '5', 5)
    player.deck.add_card(card4)

    player.deck.remove_card
    expect(player.has_lost?).to eq(false)

    player.deck.remove_card
    expect(player.has_lost?).to eq(false)

    player.deck.remove_card
    expect(player.has_lost?).to eq(true)
    expect(player.deck.cards).to eq([])
    expect(player.deck.cards.count).to eq(0)
  end

end
