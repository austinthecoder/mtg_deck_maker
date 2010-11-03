class RenameTextToRulesTextForCards < ActiveRecord::Migration
  def self.up
    rename_column :cards, :text, :rules_text
  end

  def self.down
    rename_column :cards, :rules_text, :text
  end
end
