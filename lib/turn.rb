class Turn

  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    return :basic if basic == true
    return :war if war == true && second_index != true
    return :mutually_assured_destruction if war == true && second_index == true
  end

  def basic
    player1.deck.rank_of_card(0) != player2.deck.rank_of_card(0)
  end

  def war
    player1.deck.rank_of_card(0) == player2.deck.rank_of_card(0)
  end

  def second_index
    player1.deck.rank_of_card(2) == player2.deck.rank_of_card(2)
  end

  def winner
    return winner_basic if basic == true
    return winner_war if type == :war
    return 'No Winner' if type == :mutually_assured_destruction
  end

  def winner_basic
    return player1 if player1.deck.rank_of_card(0) > player2.deck.rank_of_card(0)
    player2
  end

  def winner_war
    return player1 if player1.deck.rank_of_card(2) > player2.deck.rank_of_card(2)
    player2
  end

  def pile_cards
    case
      when type == :basic
        spoils_of_war << player1.deck.cards[0]
        spoils_of_war << player2.deck.cards[0]
        player1.deck.remove_card
        player2.deck.remove_card
      when type == :war
        spoils_of_war << player1.deck.cards[0..2]
        spoils_of_war << player2.deck.cards[0..2]
        remove_three_cards(player1, player2)
        spoils_of_war.flatten!
      when type == :mutually_assured_destruction
        remove_three_cards(player1, player2)
    end
  end

  def remove_three_cards(player1, player2)
    3.times do
      player1.deck.remove_card
      player2.deck.remove_card
    end
  end

  def award_spoils(winner)
    spoils_of_war.each do |card|
      winner.deck.cards << card
    end
    spoils_of_war.clear
  end

end
