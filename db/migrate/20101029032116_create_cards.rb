class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :name
      t.string :colors
      t.string :mana_cost
      t.string :rarity
      t.string :type_line
      t.text :text
      t.integer :mtg_set_id
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
