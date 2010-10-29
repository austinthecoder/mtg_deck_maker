class CreateFormatsMtgSets < ActiveRecord::Migration
  def self.up
    create_table :formats_mtg_sets, :id => false do |t|
      t.integer :format_id
      t.integer :mtg_set_id
    end
  end

  def self.down
    drop_table :formats_mtg_sets
  end
end
