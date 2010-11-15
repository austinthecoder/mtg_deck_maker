class MtgSet < ActiveRecord::Base

  # validations
  validates :name, :presence => true, :uniqueness => true
  validate :released_at do
    errors.add(:base, "Must have a release date") if released_at.blank?
  end
  validate do
    errors.add(:base, "Must belong to the Standard format") unless standard_format?
  end
  validate do
    errors.add(:base, "Number of cards must be set") if num_cards.blank?
  end

  # associations
  has_and_belongs_to_many :formats
  has_many :cards

  # callbacks
  after_initialize do
    formats << Format.standard unless standard_format?
  end

  # other
  attr_accessible :name, :format_ids, :released_at, :num_cards

  ##################################################

  def standard_format?
    formats.include?(Format.standard)
  end

end