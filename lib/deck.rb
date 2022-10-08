class Deck

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card(index)
    cards[index].rank
  end

  def high_ranking_cards
    cards.find_all { |card| card.rank > 10 }
  end

  def percent_high_ranking
    (high_ranking_cards.count.to_f / cards.count).round(4) * 100
  end

  def remove_card
    cards.shift
  end

  def add_card(card)
    cards << card
  end 

end
