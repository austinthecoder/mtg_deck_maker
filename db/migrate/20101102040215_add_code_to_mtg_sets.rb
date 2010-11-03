class AddCodeToMtgSets < ActiveRecord::Migration
  def self.up
    add_column :mtg_sets, :code, :string
  end

  def self.down
    remove_column :mtg_sets, :code
  end
end
