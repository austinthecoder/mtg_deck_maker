class DeckCard < ActiveRecord::Base

  belongs_to :deck
  belongs_to :card

  validates :deck, :presence => true
  validates :card, :presence => true
  validates :card_id, :uniqueness => {:scope => :deck_id}

end