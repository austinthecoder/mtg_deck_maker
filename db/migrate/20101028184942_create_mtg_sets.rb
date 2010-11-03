class CreateMtgSets < ActiveRecord::Migration
  def self.up
    create_table :mtg_sets do |t|
      t.string :name
      t.datetime :released_at
      t.integer :num_cards
      t.timestamps
    end
  end

  def self.down
    drop_table :mtg_sets
  end
end
