class Format < ActiveRecord::Base

  # validations
  validates :name, :inclusion => %w(Standard), :uniqueness => true

  # associations
  has_and_belongs_to_many :mtg_sets

  # other
  attr_accessible :name

  ##################################################

  class << self
    def standard
      find_by_name!('Standard')
    rescue ActiveRecord::RecordNotFound
      create!(:name => 'Standard')
    end
  end

end