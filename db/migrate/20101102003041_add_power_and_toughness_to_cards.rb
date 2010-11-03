class AddPowerAndToughnessToCards < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.string :power
      t.string :toughness
    end
  end

  def self.down
    change_table :cards do |t|
      t.remove :power
      t.remove :toughness
    end
  end
end
