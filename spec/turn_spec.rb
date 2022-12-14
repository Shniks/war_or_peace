require 'rspec'
require './lib/turn'
require 'pry'

RSpec.describe Turn do
  before do
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)

    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card3, @card4, @card6, @card7])

    @player1 = Player.new("Megan", deck1)
    @player2 = Player.new("Aurora", deck2)
  end

  it 'exits' do
    turn = Turn.new(@player1, @player2)

    expect(turn).to be_a(Turn)
  end

  it 'has attributes' do
    turn = Turn.new(@player1, @player2)

    expect(turn.player1).to eq(@player1)
    expect(turn.player2).to eq(@player2)
  end

  it 'has a spoils of war array' do
    turn = Turn.new(@player1, @player2)

    expect(turn.spoils_of_war).to be_a(Array)
  end

  it 'displays a basic type of turn' do
    turn = Turn.new(@player1, @player2)

    expect(turn.type).to eq(:basic)
  end

  it 'displays a basic type of turn for a different player' do
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card3, @card4, @card6, @card7])
    player1 = Player.new("Megan", deck2)
    player2 = Player.new("Aurora", deck1)
    turn = Turn.new(player1, player2)

    expect(turn.winner).to eq(player2)
  end

  it 'displays winner of the turn' do
    turn = Turn.new(@player1, @player2)

    expect(turn.winner).to eq(@player1)
  end

  it 'can send cards to spoils of war after each turn' do
    turn = Turn.new(@player1, @player2)
    turn.pile_cards

    expect(turn.spoils_of_war.count).to eq(2)
    expect(turn.spoils_of_war).to eq([@card1, @card3])
    expect(@player1.deck.cards).to eq([@card2, @card5, @card8])
    expect(@player2.deck.cards).to eq([@card4, @card6, @card7])
  end

  it 'can award spoils to the winner' do
    turn = Turn.new(@player1, @player2)
    winner = turn.winner
    turn.pile_cards
    turn.award_spoils(winner)

    expect(@player1.deck.cards).to eq([@card2, @card5, @card8, @card1, @card3])
    expect(@player2.deck.cards).to eq([@card4, @card6, @card7])
  end

  it 'can account for a war type of turn' do
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    expect(turn.type).to eq(:war)

    winner = turn.winner
    turn.pile_cards

    expect(turn.spoils_of_war.count).to eq(6)
    expect(turn.spoils_of_war).to eq([@card1, @card2, @card5, @card4, @card3, @card6])

    turn.award_spoils(winner)

    expect(player1.deck.cards.count).to eq(1)
    expect(player1.deck.cards).to eq([@card8])
    expect(player2.deck.cards.count).to eq(7)
    expect(player2.deck.cards).to eq([@card7, @card1, @card2, @card5, @card4, @card3, @card6])
  end

  it 'can account for a mutually assured destruction type of turn' do
    card6 = Card.new(:diamond, '8', 8)
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)

    expect(turn.type).to eq(:mutually_assured_destruction)

    winner = turn.winner
    turn.pile_cards

    expect(turn.spoils_of_war).to eq([])
    expect(player1.deck.cards.count).to eq(1)
    expect(player1.deck.cards).to eq([@card8])
    expect(player2.deck.cards.count).to eq(1)
    expect(player2.deck.cards).to eq([@card7])
  end

end
