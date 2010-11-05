class AddLoyaltyToCards < ActiveRecord::Migration
  def self.up
    add_column :cards, :loyalty, :integer
  end

  def self.down
    remove_column :cards, :loyalty
  end
end
