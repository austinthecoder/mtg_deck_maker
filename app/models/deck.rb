class Deck < ActiveRecord::Base

  has_many :deck_cards
  has_many :cards, :through => :deck_cards

  def add_card!(card, number)
    return if number < 1
    if deck_card = deck_cards.find_by_card_id(card.id)
      deck_card.number += number
      deck_card.save!
    else
      deck_cards.create!(:card => card, :number => number)
    end
  end

  def remove_card!(card, number)
    if number > 0 && deck_card = deck_cards.find_by_card_id(card.id)
      if number < deck_card.number
        deck_card.number -= number
        deck_card.save!
      else
        deck_card.destroy
      end
    end
  end

end