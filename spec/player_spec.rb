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

end
