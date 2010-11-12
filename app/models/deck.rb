class Deck < ActiveRecord::Base

  has_many :deck_cards
  has_many :cards, :through => :deck_cards

  def add_card!(card, number)
    if deck_card = deck_cards.find_by_card_id(card.id)
      deck_card.number += number
      deck_card.save!
    else
      deck_cards.create!(:card => card, :number => number)
    end
  end

end