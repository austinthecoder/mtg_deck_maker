class Format < ActiveRecord::Base

  validates :name, :inclusion => %w(Standard), :uniqueness => true

  has_and_belongs_to_many :mtg_sets

  class << self
    def standard
      find_by_name!('Standard')
    end
  end

end