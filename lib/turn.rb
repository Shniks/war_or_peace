class Turn

  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    return :basic if basic == true
    return :war if war == true
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

end
